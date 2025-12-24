package com.cuco.syzuser.service;

import com.cuco.syzuser.entity.ProjectInfo;
import com.cuco.syzuser.mapper.ProjectInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProjectService {

    @Autowired
    private ProjectInfoMapper projectInfoMapper;

    /**
     * 创建项目
     */
    @Transactional
    public void createProject(ProjectInfo projectInfo) {
        // 验证必填字段
        if (projectInfo.getModalId() == null) {
            throw new RuntimeException("模态标识ID不能为空");
        }
        if (projectInfo.getUserId() == null) {
            throw new RuntimeException("用户ID不能为空");
        }
        if (projectInfo.getProjectName() == null || projectInfo.getProjectName().trim().isEmpty()) {
            throw new RuntimeException("项目名称不能为空");
        }
        if (projectInfo.getProjectType() == null || projectInfo.getProjectType().trim().isEmpty()) {
            throw new RuntimeException("项目类型不能为空");
        }
        
        // 设置默认状态
        if (projectInfo.getProjectStatus() == null) {
            projectInfo.setProjectStatus("ONLINE");
        }
        
        projectInfoMapper.insert(projectInfo);
    }

    /**
     * 根据用户ID查询项目列表
     */
    public List<ProjectInfo> getProjectsByUserId(Long userId) {
        return projectInfoMapper.findByUserId(userId);
    }

    /**
     * 根据项目ID查询项目详情
     */
    public ProjectInfo getProjectById(Long projectId) {
        ProjectInfo project = projectInfoMapper.findById(projectId);
        if (project == null) {
            throw new RuntimeException("项目不存在");
        }
        return project;
    }

    /**
     * 更新项目信息
     */
    @Transactional
    public void updateProject(ProjectInfo projectInfo) {
        if (projectInfo.getProjectId() == null) {
            throw new RuntimeException("项目ID不能为空");
        }
        
        // 验证项目是否存在
        ProjectInfo exist = projectInfoMapper.findById(projectInfo.getProjectId());
        if (exist == null) {
            throw new RuntimeException("项目不存在");
        }
        
        projectInfoMapper.update(projectInfo);
    }

    /**
     * 删除项目（逻辑删除）
     */
    @Transactional
    public void deleteProject(Long projectId) {
        // 验证项目是否存在
        ProjectInfo exist = projectInfoMapper.findById(projectId);
        if (exist == null) {
            throw new RuntimeException("项目不存在");
        }
        
        projectInfoMapper.deleteById(projectId);
    }

    /**
     * 更新项目状态
     */
    @Transactional
    public void updateProjectStatus(Long projectId, String status) {
        // 验证项目是否存在
        ProjectInfo exist = projectInfoMapper.findById(projectId);
        if (exist == null) {
            throw new RuntimeException("项目不存在");
        }
        
        projectInfoMapper.updateStatus(projectId, status);
    }
}
