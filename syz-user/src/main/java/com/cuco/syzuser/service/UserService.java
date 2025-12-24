package com.cuco.syzuser.service;

import com.cuco.syzuser.dto.*;
import com.cuco.syzuser.entity.*;
import com.cuco.syzuser.mapper.*;
import com.cuco.syzuser.util.JwtUtil;
import com.cuco.syzuser.util.SnowflakeIdGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private TwoFactorCodeMapper twoFactorCodeMapper;
    
    @Autowired
    private GridCodeMapper gridCodeMapper;
    
    @Autowired
    private ModalIdentifierMapper modalIdentifierMapper;
    
    @Autowired
    private EnterpriseMapper enterpriseMapper;
    
    @Autowired
    private PersonalMapper personalMapper;
    
    @Autowired
    private ProjectInfoMapper projectInfoMapper;
    
    @Autowired
    private ProjectMapper projectMapper;
    
    @Autowired
    private SnowflakeIdGenerator snowflakeIdGenerator;

    @Autowired
    private SmsService smsService;

    @Autowired
    private JwtUtil jwtUtil;

    @Transactional
    public Map<String, Object> register(RegisterRequest req) {
        // 此方法已废弃，请使用 registerEnterprise() 或 registerPersonal()
        throw new RuntimeException("请使用企业注册或个人注册接口");
    }
    
    /**
     * 企业注册
     */
    @Transactional
    public Map<String, Object> registerEnterprise(EnterpriseRegisterRequest req) {
        // 验证密码一致性
        if (!req.getPassword().equals(req.getConfirmPassword())) {
            throw new RuntimeException("两次输入的密码不一致");
        }
        
        // 验证短信验证码
        boolean isCodeValid = smsService.validateCode(req.getPhone(), req.getVerifyCode());
        if (!isCodeValid) {
            throw new RuntimeException("验证码错误或已过期");
        }

        // 检查手机号是否已注册
        User exist = userMapper.findByPhone(req.getPhone());
        if (exist != null) {
            throw new RuntimeException("该手机号已注册");
        }

        // 生成双因子码
        String twoFactorCode = "TFC-" + generateRandomCode(8);
        
        // 创建用户主表记录
        User user = new User();
        user.setUserType("ENTERPRISE");
        user.setPhone(req.getPhone());
        user.setPassword(req.getPassword()); // TODO: 应该加密存储
        user.setTwoFactorCode(twoFactorCode);
        user.setIsFillin(0);
        user.setStatus("ACTIVE");
        userMapper.insert(user);
        
        // 创建企业信息记录
        Enterprise enterprise = new Enterprise();
        enterprise.setUserId(user.getUserId());
        enterprise.setEnterpriseName(req.getEnterpriseName());
        enterprise.setLegalPersonName(req.getLegalPersonName());
        enterprise.setUnifiedSocialCreditCode(req.getUnifiedSocialCreditCode());
        enterprise.setBusinessLicenseUrl(req.getBusinessLicenseUrl());
        enterprise.setLegalPersonIdCard(req.getLegalPersonIdCard());
        enterprise.setLegalPersonIdFrontUrl(req.getLegalPersonIdFrontUrl());
        enterprise.setLegalPersonIdBackUrl(req.getLegalPersonIdBackUrl());
        enterprise.setContactPhone(req.getContactPhone());
        enterprise.setContactEmail(req.getContactEmail());
        enterprise.setEnterpriseAddress(req.getEnterpriseAddress());
        enterprise.setBusinessScope(req.getBusinessScope());
        enterprise.setRegisteredCapital(req.getRegisteredCapital());
        enterprise.setEstablishmentDate(req.getEstablishmentDate());
        enterprise.setVerificationStatus("PENDING");
        enterpriseMapper.insert(enterprise);
        
        // 保存双因子码到 biz_two_factor_code 表
        TwoFactorCode twoFactorCodeEntity = new TwoFactorCode();
        twoFactorCodeEntity.setTwoFactorValue(twoFactorCode);
        twoFactorCodeEntity.setUserId(user.getUserId());
        twoFactorCodeEntity.setGridCodeValue(null);
        twoFactorCodeEntity.setCodeType("ASSET"); // 企业用户使用资产类
        twoFactorCodeEntity.setStatus("ACTIVATED");
        twoFactorCodeMapper.insert(twoFactorCodeEntity);
        
        // 返回成功信息
        Map<String, Object> data = new HashMap<>();
        data.put("userId", user.getUserId());
        data.put("phone", user.getPhone());
        data.put("twoFactorCode", user.getTwoFactorCode());
        data.put("userType", "ENTERPRISE");
        data.put("message", "企业注册成功，请登录");
        return data;
    }
    
    /**
     * 个人注册
     */
    @Transactional
    public Map<String, Object> registerPersonal(PersonalRegisterRequest req) {
        // 验证密码一致性
        if (!req.getPassword().equals(req.getConfirmPassword())) {
            throw new RuntimeException("两次输入的密码不一致");
        }
        
        // 验证短信验证码
        boolean isCodeValid = smsService.validateCode(req.getPhone(), req.getVerifyCode());
        if (!isCodeValid) {
            throw new RuntimeException("验证码错误或已过期");
        }

        // 检查手机号是否已注册
        User exist = userMapper.findByPhone(req.getPhone());
        if (exist != null) {
            throw new RuntimeException("该手机号已注册");
        }

        // 生成双因子码
        String twoFactorCode = "TFC-" + generateRandomCode(8);
        
        // 创建用户主表记录
        User user = new User();
        user.setUserType("PERSONAL");
        user.setPhone(req.getPhone());
        user.setPassword(req.getPassword()); // TODO: 应该加密存储
        user.setTwoFactorCode(twoFactorCode);
        user.setIsFillin(0);
        user.setStatus("ACTIVE");
        userMapper.insert(user);
        
        // 创建个人信息记录
        Personal personal = new Personal();
        personal.setUserId(user.getUserId());
        personal.setRealName(req.getRealName());
        personal.setIdCard(req.getIdCard());
        personal.setIdCardFrontUrl(req.getIdCardFrontUrl());
        personal.setIdCardBackUrl(req.getIdCardBackUrl());
        personal.setGender(req.getGender());
        personal.setBirthDate(req.getBirthDate());
        personal.setNationality(req.getNationality() != null ? req.getNationality() : "中国");
        personal.setAddress(req.getAddress());
        personal.setEmail(req.getEmail());
        personal.setOccupation(req.getOccupation());
        personal.setEducationLevel(req.getEducationLevel());
        personal.setEmergencyContactName(req.getEmergencyContactName());
        personal.setEmergencyContactPhone(req.getEmergencyContactPhone());
        personal.setVerificationStatus("PENDING");
        personalMapper.insert(personal);
        
        // 保存双因子码到 biz_two_factor_code 表
        TwoFactorCode twoFactorCodeEntity = new TwoFactorCode();
        twoFactorCodeEntity.setTwoFactorValue(twoFactorCode);
        twoFactorCodeEntity.setUserId(user.getUserId());
        twoFactorCodeEntity.setGridCodeValue(null);
        twoFactorCodeEntity.setCodeType("PERSONAL"); // 个人用户使用个人类
        twoFactorCodeEntity.setStatus("ACTIVATED");
        twoFactorCodeMapper.insert(twoFactorCodeEntity);
        
        // 返回成功信息
        Map<String, Object> data = new HashMap<>();
        data.put("userId", user.getUserId());
        data.put("phone", user.getPhone());
        data.put("twoFactorCode", user.getTwoFactorCode());
        data.put("userType", "PERSONAL");
        data.put("message", "个人注册成功，请登录");
        return data;
    }

    // 登录
    public Map<String, Object> login(LoginRequest req) {
        User user = null;
        
        // 验证密码是否为空
        if (req.getPassword() == null || req.getPassword().trim().isEmpty()) {
            throw new RuntimeException("请输入密码");
        }
        
        // 验证账号是否为空
        if (req.getAccount() == null || req.getAccount().trim().isEmpty()) {
            throw new RuntimeException("请输入账号");
        }
        
        // 判断登录方式
        if ("phone".equals(req.getLoginType())) {
            // 手机号 + 密码登录
            user = userMapper.findByPhone(req.getAccount());
            if (user == null) {
                throw new RuntimeException("手机号不存在");
            }
        } else if ("twoFactorCode".equals(req.getLoginType())) {
            // 双因子码 + 密码登录
            user = userMapper.findByTwoFactorCode(req.getAccount());
            if (user == null) {
                throw new RuntimeException("双因子码不存在");
            }
        } else if ("gridCode".equals(req.getLoginType())) {
            // 网格码 + 密码登录
            user = userMapper.findByGridCode(req.getAccount());
            if (user == null) {
                throw new RuntimeException("网格码不存在");
            }
        } else {
            throw new RuntimeException("未知的登录方式");
        }
        
        // 验证密码
        if (!user.getPassword().equals(req.getPassword())) {
            throw new RuntimeException("密码错误");
        }

        // 生成 JWT Token
        String token = jwtUtil.generateToken(user.getUserId(), user.getPhone());

        // 构建返回数据
        Map<String, Object> data = new HashMap<>();
        data.put("userId", user.getUserId());
        data.put("phone", user.getPhone());
        data.put("twoFactorCode", user.getTwoFactorCode());
        data.put("gridCode", user.getGridCode());
        data.put("isFillin", user.getIsFillin());
        data.put("modalId", user.getModalId());
        data.put("userType", user.getUserType()); // 返回用户类型
        data.put("status", user.getStatus());
        data.put("token", token);
        
        // 根据用户类型，返回额外信息
        if ("ENTERPRISE".equals(user.getUserType())) {
            Enterprise enterprise = enterpriseMapper.findByUserId(user.getUserId());
            if (enterprise != null) {
                data.put("enterpriseName", enterprise.getEnterpriseName());
                data.put("legalPersonName", enterprise.getLegalPersonName());
                data.put("verificationStatus", enterprise.getVerificationStatus());
            }
        } else if ("PERSONAL".equals(user.getUserType())) {
            Personal personal = personalMapper.findByUserId(user.getUserId());
            if (personal != null) {
                data.put("realName", personal.getRealName());
                data.put("gender", personal.getGender());
                data.put("verificationStatus", personal.getVerificationStatus());
            }
        }
        
        return data;
    }

    // 绑定网格码 (充值后)
    @Transactional
    public void fillInfo(FillInfoRequest req) {
        // 获取用户信息
        User user = userMapper.findById(req.getUserId());
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        // 保存网格码到 biz_grid_code 表
        GridCode gridCode = new GridCode();
        gridCode.setGridCodeValue(req.getGridCode());
        gridCode.setUserId(req.getUserId());
        gridCode.setStatus("VALID");
        gridCodeMapper.insert(gridCode);
        
        // 更新 biz_two_factor_code 表，绑定网格码
        if (user.getTwoFactorCode() != null) {
            twoFactorCodeMapper.updateGridCode(user.getTwoFactorCode(), req.getGridCode());
        }
        
        // 更新 user 表
        User updateUser = new User();
        updateUser.setUserId(req.getUserId());
        updateUser.setGridCode(req.getGridCode());
        userMapper.update(updateUser);
    }

    // 获取用户信息
    public User getUserById(Long id) {
        return userMapper.findById(id);
    }
    
    // 获取用户详细信息（包含企业或个人信息）
    public Map<String, Object> getUserDetailById(Long id) {
        User user = userMapper.findById(id);
        if (user == null) {
            return null;
        }
        
        // 构建返回数据
        Map<String, Object> data = new HashMap<>();
        data.put("userId", user.getUserId());
        data.put("phone", user.getPhone());
        data.put("twoFactorCode", user.getTwoFactorCode());
        data.put("gridCode", user.getGridCode());
        data.put("isFillin", user.getIsFillin());
        data.put("modalId", user.getModalId());
        data.put("userType", user.getUserType());
        data.put("status", user.getStatus());
        
        // 根据用户类型，返回额外信息
        if ("ENTERPRISE".equals(user.getUserType())) {
            Enterprise enterprise = enterpriseMapper.findByUserId(user.getUserId());
            if (enterprise != null) {
                data.put("enterpriseName", enterprise.getEnterpriseName());
                data.put("legalPersonName", enterprise.getLegalPersonName());
                data.put("verificationStatus", enterprise.getVerificationStatus());
            }
        } else if ("PERSONAL".equals(user.getUserType())) {
            Personal personal = personalMapper.findByUserId(user.getUserId());
            if (personal != null) {
                data.put("realName", personal.getRealName());
                data.put("gender", personal.getGender());
                data.put("verificationStatus", personal.getVerificationStatus());
            }
        }
        
        return data;
    }

    // 绑定模态标识 (资产确权)
    @Transactional
    public void updateModal(UpdateModalRequest req) {
        // 验证模态标识是否为空
        if (req.getModalId() == null) {
            throw new RuntimeException("请选择模态标识");
        }
        
        // 验证模态标识范围（0-99999999）
        if (req.getModalId() < 0 || req.getModalId() > 99999999) {
            throw new RuntimeException("模态标识范围必须在 0-99999999 之间");
        }
        
        // 检查该用户是否已经使用过这个模态标识
        List<UserModal> userModals = userMapper.findModalsByUserId(req.getUserId());
        for (UserModal userModal : userModals) {
            if (userModal.getModalId().equals(req.getModalId())) {
                throw new RuntimeException("该模态标识已经被您使用过，请选择其他模态标识");
            }
        }
        
        // 获取用户信息，获取双因子码
        User user = userMapper.findById(req.getUserId());
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        // 保存到 biz_modal_identifier 表
        ModalIdentifier modalIdentifier = new ModalIdentifier();
        modalIdentifier.setModalValue(String.valueOf(req.getModalId()));
        modalIdentifier.setTwoFactorValue(user.getTwoFactorCode());
        modalIdentifier.setUserId(req.getUserId());
        modalIdentifier.setIdentifierType("PROJECT");
        modalIdentifier.setStatus("VALID");
        modalIdentifierMapper.insert(modalIdentifier);

        // 插入 user_modal 表（历史记录）
        UserModal userModal = new UserModal();
        userModal.setUserId(req.getUserId());
        userModal.setModalId(req.getModalId());
        userMapper.insertUserModal(userModal);

        // 更新 user 表的 modal_id 字段
        userMapper.updateUserModalId(req.getUserId(), req.getModalId());
    }

    // 重置密码
    @Transactional
    public void resetPassword(ResetPasswordRequest req) {
        // 验证短信验证码
        boolean isCodeValid = smsService.validateCode(req.getPhone(), req.getVerifyCode());
        if (!isCodeValid) {
            throw new RuntimeException("验证码错误或已过期");
        }

        // 验证两次密码输入是否一致
        if (!req.getNewPassword().equals(req.getConfirmPassword())) {
            throw new RuntimeException("两次输入的密码不一致");
        }

        // 检查用户是否存在
        User user = userMapper.findByPhone(req.getPhone());
        if (user == null) {
            throw new RuntimeException("该手机号未注册");
        }

        // 更新密码
        userMapper.updatePassword(req.getPhone(), req.getNewPassword());
    }

    // 生成随机码
    private String generateRandomCode(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
    
    // 获取用户的模态标识历史列表
    public List<UserModal> getUserModals(Long userId) {
        return userMapper.findModalsByUserId(userId);
    }
    
    // 获取模态标识统计信息（从双因子码表查询）
    public Map<String, Object> getModalStats() {
        // 总模态标识数量（1亿个）
        long totalModals = 100000000L;
        
        // 已使用的模态标识数量（从 biz_modal_identifier 表统计）
        Long usedModals = userMapper.countUsedModals();
        if (usedModals == null) {
            usedModals = 0L;
        }
        
        // 剩余模态标识数量
        long remainingModals = totalModals - usedModals;
        
        // 使用率
        double usageRate = (usedModals * 100.0) / totalModals;
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalModals", totalModals);
        stats.put("usedModals", usedModals);
        stats.put("remainingModals", remainingModals);
        stats.put("usageRate", String.format("%.6f", usageRate));
        
        return stats;
    }
    
    /**
     * 获取用户的模态标识统计信息（从用户的双因子码查询）
     * @param userId 用户ID
     * @return 统计信息
     */
    public Map<String, Object> getUserModalStats(Long userId) {
        // 查询用户信息
        User user = userMapper.findById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        // 查询用户的双因子码信息
        TwoFactorCode twoFactorCode = twoFactorCodeMapper.findByValue(user.getTwoFactorCode());
        if (twoFactorCode == null) {
            throw new RuntimeException("双因子码不存在");
        }
        
        // 总模态标识数量（1亿个）
        long totalModals = 100000000L;
        
        // 剩余模态标识数量（从双因子码表获取）
        Long remainingModals = twoFactorCode.getRemainingModals();
        if (remainingModals == null) {
            remainingModals = totalModals;
        }
        
        // 已使用数量
        long usedModals = totalModals - remainingModals;
        
        // 使用率
        double usageRate = (usedModals * 100.0) / totalModals;
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalModals", totalModals);
        stats.put("usedModals", usedModals);
        stats.put("remainingModals", remainingModals);
        stats.put("usageRate", String.format("%.6f", usageRate));
        
        return stats;
    }
    
    // 查询所有可用项目类型
    public List<Project> getAvailableProjects() {
        return projectMapper.findAll();
    }
    
    // 生成模态标识码（雪花算法）
    public String generateModalCode(Long userId, String projectType) {
        // 使用雪花算法生成唯一ID
        return snowflakeIdGenerator.nextIdStr();
    }
    
    // 模态标识绑定项目
    @Transactional
    public void bindModalToProject(ModalBindingRequest req) {
        // 1. 验证用户存在
        User user = userMapper.findById(req.getUserId());
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        // 2. 验证模态标识码是否已经绑定
        ModalIdentifier existIdentifier = modalIdentifierMapper.findByModalValue(req.getModalCode());
        if (existIdentifier != null) {
            throw new RuntimeException("该模态标识码已被使用");
        }
        
        // 3. 验证双因子码剩余数量
        TwoFactorCode twoFactorCode = twoFactorCodeMapper.findByValue(user.getTwoFactorCode());
        if (twoFactorCode == null) {
            throw new RuntimeException("双因子码不存在");
        }
        if (twoFactorCode.getRemainingModals() == null || twoFactorCode.getRemainingModals() <= 0) {
            throw new RuntimeException("模态标识数量不足，无法绑定");
        }
        
        // 4. 创建模态标识记录
        ModalIdentifier modalIdentifier = new ModalIdentifier();
        modalIdentifier.setModalValue(req.getModalCode());
        modalIdentifier.setTwoFactorValue(user.getTwoFactorCode());
        modalIdentifier.setUserId(req.getUserId());
        modalIdentifier.setIdentifierType(req.getProjectType());
        modalIdentifier.setStatus("VALID");
        modalIdentifier.setHashValue(generateHash(req.getModalCode(), user.getTwoFactorCode()));
        modalIdentifierMapper.insert(modalIdentifier);
        
        // 5. 创建项目信息记录
        ProjectInfo project = new ProjectInfo();
        project.setModalId(modalIdentifier.getModalId());
        project.setModalValue(req.getModalCode());
        project.setUserId(req.getUserId());
        project.setProjectName(req.getProjectName());
        project.setProjectType(req.getProjectType());
        project.setByteSize(req.getByteSize());
        project.setProjectDesc(req.getProjectDesc());
        project.setProjectStatus("ONLINE");
        project.setDeleted(0);
        projectInfoMapper.insert(project);
        
        // 6. 扣减双因子码的剩余模态数量
        int updated = twoFactorCodeMapper.decreaseRemainingModals(user.getTwoFactorCode());
        if (updated == 0) {
            throw new RuntimeException("扣减模态数量失败，请重试");
        }
    }
    
    // 生成哈希值（区块链存证用）
    private String generateHash(String modalCode, String twoFactorCode) {
        String data = modalCode + ":" + twoFactorCode + ":" + System.currentTimeMillis();
        return "HASH-" + Integer.toHexString(data.hashCode()).toUpperCase();
    }
    
    /**
     * 查询用户的模态绑定记录
     * @param userId 用户ID
     * @param projectType 项目类型（可选）
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 绑定记录列表
     */
    public List<Map<String, Object>> getUserModalBindings(Long userId, String projectType, String startDate, String endDate) {
        return modalIdentifierMapper.findUserBindings(userId, projectType, startDate, endDate);
    }
}