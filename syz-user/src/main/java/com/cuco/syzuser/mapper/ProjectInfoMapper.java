package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.ProjectInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProjectInfoMapper {

    // 根据项目ID 查询
    ProjectInfo findById(Long projectId);

    // 根据模态标识 ID 查询项目列表
    List<ProjectInfo> findByModalId(Long modalId);
    
    // 根据用户 ID 查询项目列表
    List<ProjectInfo> findByUserId(Long userId);

    // 插入项目信息
    void insert(ProjectInfo projectInfo);
    
    // 更新项目信息
    void update(ProjectInfo projectInfo);

    // 更新项目状态
    void updateStatus(@Param("projectId") Long projectId, @Param("projectStatus") String projectStatus);
    
    // 逻辑删除项目
    void deleteById(Long projectId);
    
    // 查询所有可用项目类型
    List<ProjectInfo> findAllAvailableProjects();
    
    // 根据项目类型查询
    ProjectInfo findByProjectType(String projectType);
}
