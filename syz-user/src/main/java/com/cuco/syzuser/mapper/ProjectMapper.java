package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.Project;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ProjectMapper {
    
    // 查询所有项目类型
    List<Project> findAll();
    
    // 根据ID查询
    Project findById(Integer id);
    
    // 根据项目类型查询
    Project findByType(String projectType);
}
