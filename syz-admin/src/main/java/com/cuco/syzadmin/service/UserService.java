package com.cuco.syzadmin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cuco.syzadmin.dto.LoginRequest;
import com.cuco.syzadmin.dto.LoginResponse;
import com.cuco.syzadmin.dto.UserFullDetailDTO;
import com.cuco.syzadmin.dto.UserInfoDTO;
import com.cuco.syzadmin.entity.Enterprise;
import com.cuco.syzadmin.entity.ModalIdentifier;
import com.cuco.syzadmin.entity.Personal;
import com.cuco.syzadmin.entity.ProjectInfo;
import com.cuco.syzadmin.entity.TwoFactorCode;
import com.cuco.syzadmin.entity.User;
import com.cuco.syzadmin.mapper.UserMapper;
import com.cuco.syzadmin.mapper.PersonalMapper;
import com.cuco.syzadmin.mapper.EnterpriseMapper;
import com.cuco.syzadmin.mapper.ModalIdentifierMapper;
import com.cuco.syzadmin.mapper.ProjectInfoMapper;
import com.cuco.syzadmin.mapper.ProjectMapper;
import com.cuco.syzadmin.mapper.TwoFactorCodeMapper;
import com.cuco.syzadmin.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 用户服务类
 */
@Service
public class UserService {
    
    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private PersonalMapper personalMapper;
    
    @Autowired
    private EnterpriseMapper enterpriseMapper;
    
    @Autowired
    private ModalIdentifierMapper modalIdentifierMapper;
    
    @Autowired
    private ProjectInfoMapper projectInfoMapper;
    
    @Autowired
    private TwoFactorCodeMapper twoFactorCodeMapper;
    
    @Autowired
    private ProjectMapper projectMapper;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    /**
     * 用户登录
     * @param loginRequest 登录请求
     * @return 登录响应（包含token和用户信息）
     */
    public LoginResponse login(LoginRequest loginRequest) {
        // 校验参数
        if (!StringUtils.hasText(loginRequest.getPhone()) 
                || !StringUtils.hasText(loginRequest.getPassword())) {
            throw new RuntimeException("手机号和密码不能为空");
        }
        
        // 根据手机号查询用户
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getPhone, loginRequest.getPhone());
        User user = userMapper.selectOne(queryWrapper);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        if (!loginRequest.getPassword().equals(user.getPassword())) {
            throw new RuntimeException("密码错误");
        }

        // 获取用户姓名（从个人或企业表中）
        String userName = null;
        if ("PERSONAL".equals(user.getUserType())) {
            userName = personalMapper.selectNameByUserId(user.getUserId());
        } else if ("ENTERPRISE".equals(user.getUserType())) {
            userName = enterpriseMapper.selectNameByUserId(user.getUserId());
        }
        
        // 如果没有查到姓名，使用手机号作为默认姓名
        if (userName == null || userName.isEmpty()) {
            userName = user.getPhone();
        }
        
        // 生成token
        String token = jwtUtil.generateToken(user.getUserId(), user.getPhone());
        LoginResponse response = new LoginResponse();
        response.setToken(token);
        UserInfoDTO userInfoDTO = new UserInfoDTO(user.getUserId(), userName);
        response.setUser(userInfoDTO);
        return response;
    }

    /**
     * 分页查询用户列表
     * @param userType 用户类型 (PERSONAL/ENTERPRISE)
     * @param phone 手机号
     * @param currentPage 当前页
     * @param pageSize 每页大小
     * @return 用户分页数据
     */
    public IPage<User> getUserList(String userType, String phone, Integer currentPage, Integer pageSize) {
        Page<User> page = new Page<>(currentPage, pageSize);
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        // 按用户类型筛选
        if (StringUtils.hasText(userType)) {
            queryWrapper.eq(User::getUserType, userType);
        }
        if (StringUtils.hasText(phone)) {
            queryWrapper.like(User::getPhone, phone);
        }
        // 按总分数倒序排列（从大到小），然后按创建时间倒序
        queryWrapper.orderByDesc(User::getTotalScore)
                    .orderByDesc(User::getCreateTime);
        return userMapper.selectPage(page, queryWrapper);
    }
    
    /**
     * 根据用户ID查询个人详情
     * @param userId 用户ID
     * @return 个人详情
     */
    public Personal getPersonalDetail(Long userId) {
        return personalMapper.selectByUserId(userId);
    }
    
    /**
     * 根据用户ID查询企业详情
     * @param userId 用户ID
     * @return 企业详情
     */
    public Enterprise getEnterpriseDetail(Long userId) {
        return enterpriseMapper.selectByUserId(userId);
    }
    
    /**
     * 获取用户完整详情（包括所有关联数据和统计信息）
     * @param userId 用户ID
     * @return 用户完整详情DTO
     */
    public UserFullDetailDTO getUserFullDetail(Long userId) {
        UserFullDetailDTO dto = new UserFullDetailDTO();
        
        // 1. 查询用户基本信息
        User user = userMapper.selectById(userId);
        if (user == null) {
            return null;
        }
        user.setPassword(null); // 隐藏密码
        dto.setUser(user);
        
        // 2. 根据用户类型查询个人/企业详情
        if ("PERSONAL".equals(user.getUserType())) {
            Personal personal = personalMapper.selectByUserId(userId);
            dto.setPersonalDetail(personal);
        } else if ("ENTERPRISE".equals(user.getUserType())) {
            Enterprise enterprise = enterpriseMapper.selectByUserId(userId);
            dto.setEnterpriseDetail(enterprise);
        }
        
        // 3. 查询双因子码信息
        if (StringUtils.hasText(user.getTwoFactorCode())) {
            TwoFactorCode twoFactorCode = twoFactorCodeMapper.selectByTwoFactorValue(user.getTwoFactorCode());
            dto.setTwoFactorCode(twoFactorCode);
        }
        
        // 4. 查询模态标识列表
        List<ModalIdentifier> modalIdentifiers = modalIdentifierMapper.selectByUserId(userId);
        dto.setModalIdentifiers(modalIdentifiers);
        dto.setModalIdentifierCount(modalIdentifiers != null ? modalIdentifiers.size() : 0);
        
        // 5. 查询项目信息列表
        List<ProjectInfo> projectInfos = projectInfoMapper.selectByUserId(userId);
        dto.setProjectInfos(projectInfos);
        
        // 6. 统计项目类别并计算分数（使用 project 表设置的分数）
        List<Map<String, Object>> typeStats = projectInfoMapper.countByUserIdGroupByType(userId);
        List<UserFullDetailDTO.ProjectTypeStat> projectTypeStats = new ArrayList<>();
        
        int totalCount = 0;
        
        // 计算总数
        for (Map<String, Object> stat : typeStats) {
            Object countObj = stat.get("count");
            int count = countObj instanceof Number ? ((Number) countObj).intValue() : 0;
            totalCount += count;
        }
        
        // 计算每个类别的分数和百分比
        // 打分规则：根据 project 表中设置的分数 × 该类别项目数量
        for (Map<String, Object> stat : typeStats) {
            String projectType = (String) stat.get("project_type");
            Object countObj = stat.get("count");
            int count = countObj instanceof Number ? ((Number) countObj).intValue() : 0;
            
            UserFullDetailDTO.ProjectTypeStat typeStat = new UserFullDetailDTO.ProjectTypeStat(projectType, count);
            
            // 计算百分比
            double percentage = totalCount > 0 ? (count * 100.0 / totalCount) : 0;
            typeStat.setPercentage(Math.round(percentage * 100.0) / 100.0);
            
            // 从 project 表获取该类别的单项分数，然后乘以数量
            Double typeScore = projectMapper.getScoreByProjectType(projectType);
            double score = (typeScore != null ? typeScore : 0) * count;
            typeStat.setScore(score);
            
            projectTypeStats.add(typeStat);
        }
        
        dto.setProjectTypeStats(projectTypeStats);
        
        // 总分直接从 biz_user 表的 total_score 字段读取
        dto.setTotalScore(user.getTotalScore() != null ? user.getTotalScore() : 0.0);
        
        return dto;
    }

    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户信息
     */
    public User getUserById(Long id) {
        return userMapper.selectById(id);
    }

    /**
     * 新增用户
     * @param user 用户信息
     * @return 影响行数
     */
    public int addUser(User user) {
        return userMapper.insert(user);
    }

    /**
     * 更新用户
     * @param user 用户信息
     * @return 影响行数
     */
    public int updateUser(User user) {
        return userMapper.updateById(user);
    }

    /**
     * 删除用户
     * @param id 用户ID
     * @return 影响行数
     */
    public int deleteUser(Long id) {
        return userMapper.deleteById(id);
    }

    /**
     * 批量删除用户
     * @param ids 用户ID列表
     * @return 影响行数
     */
    public int deleteUsers(List<Long> ids) {
        return userMapper.deleteBatchIds(ids);
    }
}