package com.cuco.syzadmin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cuco.syzadmin.entity.ProjectInfo;
import com.cuco.syzadmin.mapper.ProjectInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 项目信息服务类
 */
@Service
public class ProjectInfoService extends ServiceImpl<ProjectInfoMapper, ProjectInfo> {

    @Autowired
    private ProjectInfoMapper projectInfoMapper;

    /**
     * 分页查询项目信息
     */
    public IPage<ProjectInfo> getProjectInfoList(String projectName, String projectType, Long modalId, Integer currentPage, Integer pageSize) {
        LambdaQueryWrapper<ProjectInfo> queryWrapper = new LambdaQueryWrapper<>();
        
        // 按项目名称查询
        if (projectName != null && !projectName.trim().isEmpty()) {
            queryWrapper.like(ProjectInfo::getProjectName, projectName);
        }
        
        // 按项目类型模糊查询
        if (projectType != null && !projectType.trim().isEmpty()) {
            queryWrapper.like(ProjectInfo::getProjectType, projectType);
        }
        
        // 按关联模态标识查询
        if (modalId != null) {
            queryWrapper.eq(ProjectInfo::getModalId, modalId);
        }
        
        // 创建分页对象
        Page<ProjectInfo> page = new Page<>(currentPage, pageSize);
        
        return projectInfoMapper.selectPage(page, queryWrapper);
    }
}