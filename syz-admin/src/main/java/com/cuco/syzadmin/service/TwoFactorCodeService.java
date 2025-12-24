package com.cuco.syzadmin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cuco.syzadmin.dto.TwoFactorCodeRelationsDTO;
import com.cuco.syzadmin.dto.ModalIdentifierQueryDTO;
import com.cuco.syzadmin.dto.ProjectInfoQueryDTO;
import com.cuco.syzadmin.entity.TwoFactorCode;
import com.cuco.syzadmin.entity.User;
import com.cuco.syzadmin.entity.GridCode;
import com.cuco.syzadmin.entity.ModalIdentifier;
import com.cuco.syzadmin.entity.ProjectInfo;
import com.cuco.syzadmin.mapper.TwoFactorCodeMapper;
import com.cuco.syzadmin.mapper.ModalIdentifierMapper;
import com.cuco.syzadmin.mapper.UserMapper;
import com.cuco.syzadmin.mapper.GridCodeMapper;
import com.cuco.syzadmin.mapper.ProjectInfoMapper;
import com.cuco.syzadmin.mapper.PersonalMapper;
import com.cuco.syzadmin.mapper.EnterpriseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.ArrayList;

/**
 * 双因子码服务类
 */
@Service
public class TwoFactorCodeService extends ServiceImpl<TwoFactorCodeMapper, TwoFactorCode> {

    @Autowired
    private TwoFactorCodeMapper twoFactorCodeMapper;
    
    @Autowired
    private ModalIdentifierMapper modalIdentifierMapper;
    
    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private GridCodeMapper gridCodeMapper;
    
    @Autowired
    private ProjectInfoMapper projectInfoMapper;
    
    @Autowired
    private PersonalMapper personalMapper;
    
    @Autowired
    private EnterpriseMapper enterpriseMapper;

    /**
     * 分页查询双因子码
     */
    public IPage<TwoFactorCode> getTwoFactorCodeList(String twoFactorValue, String gridCodeValue, String codeType, String status, Integer currentPage, Integer pageSize) {
        LambdaQueryWrapper<TwoFactorCode> queryWrapper = new LambdaQueryWrapper<>();
        
        // 按双因子码值查询
        if (twoFactorValue != null && !twoFactorValue.trim().isEmpty()) {
            queryWrapper.like(TwoFactorCode::getTwoFactorValue, twoFactorValue);
        }
        
        // 按关联网格码查询
        if (gridCodeValue != null && !gridCodeValue.trim().isEmpty()) {
            queryWrapper.eq(TwoFactorCode::getGridCodeValue, gridCodeValue);
        }
        
        // 按码类型查询
        if (codeType != null && !codeType.trim().isEmpty()) {
            queryWrapper.eq(TwoFactorCode::getCodeType, codeType);
        }
        
        // 按状态查询
        if (status != null && !status.trim().isEmpty()) {
            queryWrapper.eq(TwoFactorCode::getStatus, status);
        }
        
        // 创建分页对象
        Page<TwoFactorCode> page = new Page<>(currentPage, pageSize);
        
        IPage<TwoFactorCode> result = twoFactorCodeMapper.selectPage(page, queryWrapper);
        
        // 记录的剩余模态标识数量已经通过MyBatis自动映射
        
        return result;
    }
    
    /**
     * 获取双因子码及其关联信息
     */
    public TwoFactorCodeRelationsDTO getTwoFactorCodeWithRelations(Long id) {
        // 获取双因子码基本信息
        TwoFactorCode twoFactorCode = twoFactorCodeMapper.selectById(id);
        if (twoFactorCode == null) {
            return null;
        }
        
        // 设置剩余模态标识数量（直接从数据库获取）
        TwoFactorCode dbTwoFactorCode = twoFactorCodeMapper.selectById(id);
        twoFactorCode.setRemainingModals(dbTwoFactorCode.getRemainingModals());
        
        // 获取关联用户
        User user = userMapper.selectByTwoFactorCode(twoFactorCode.getTwoFactorValue());
        
        // 获取用户姓名（从个人或企业表中）
        String userName = null;
        if (user != null) {
            if ("PERSONAL".equals(user.getUserType())) {
                userName = personalMapper.selectNameByUserId(user.getUserId());
            } else if ("ENTERPRISE".equals(user.getUserType())) {
                userName = enterpriseMapper.selectNameByUserId(user.getUserId());
            }
        }
        
        // 获取关联网格码
        GridCode gridCode = gridCodeMapper.selectByGridCodeValue(twoFactorCode.getGridCodeValue());
        
        // 获取关联的模态标识
        List<ModalIdentifier> modalIdentifiers = modalIdentifierMapper.selectByTwoFactorValue(twoFactorCode.getTwoFactorValue());
        
        // 获取关联的项目
        List<ProjectInfo> projects = new ArrayList<>();
        if (!modalIdentifiers.isEmpty()) {
            Long[] modalIds = modalIdentifiers.stream().map(ModalIdentifier::getModalId).toArray(Long[]::new);
            projects = projectInfoMapper.selectByModalIds(modalIds);
        }
        
        TwoFactorCodeRelationsDTO result = new TwoFactorCodeRelationsDTO(twoFactorCode, user, gridCode, modalIdentifiers, projects);
        result.setUserName(userName);
        return result;
    }
    
    /**
     * 分页查询模态标识信息
     */
    public IPage<ModalIdentifier> getModalIdentifiersPage(ModalIdentifierQueryDTO queryDTO) {
        Page<ModalIdentifier> page = new Page<>(queryDTO.getCurrentPage(), queryDTO.getPageSize());
        return modalIdentifierMapper.selectPageWithFilters(
            queryDTO.getTwoFactorValue(),
            queryDTO.getModalValue(),
            queryDTO.getIdentifierType(),
            queryDTO.getCreateTimeStart(),
            queryDTO.getCreateTimeEnd(),
            page
        );
    }
    
    /**
     * 分页查询项目信息
     */
    public IPage<ProjectInfo> getProjectsPage(ProjectInfoQueryDTO queryDTO) {
        Page<ProjectInfo> page = new Page<>(queryDTO.getCurrentPage(), queryDTO.getPageSize());
        
        // 根据模态标识获取其ID
        List<ModalIdentifier> modalIdentifiers = modalIdentifierMapper.selectByTwoFactorValue(queryDTO.getTwoFactorValue());
        Long[] modalIds = null;
        if (!modalIdentifiers.isEmpty()) {
            modalIds = modalIdentifiers.stream().map(ModalIdentifier::getModalId).toArray(Long[]::new);
        } else {
            modalIds = new Long[0];
        }
        
        return projectInfoMapper.selectPageWithFilters(
            modalIds,
            queryDTO.getProjectName(),
            queryDTO.getProjectType(),
            queryDTO.getCreateTimeStart(),
            queryDTO.getCreateTimeEnd(),
            page
        );
    }
    
    /**
     * 获取所有项目类型
     */
    public List<String> getProjectTypes() {
        return projectInfoMapper.selectDistinctProjectTypes();
    }
}