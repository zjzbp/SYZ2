package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cuco.syzadmin.entity.Project;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ProjectMapper extends BaseMapper<Project> {
    
    /**
     * 查询所有项目类型（去重）
     */
    @Select("SELECT DISTINCT project_type FROM project WHERE is_delete = 0 ORDER BY project_type")
    List<String> findAllProjectTypes();
    
    /**
     * 根据项目类型查询分数
     */
    @Select("SELECT score FROM project WHERE project_type = #{projectType} AND is_delete = 0 LIMIT 1")
    Double getScoreByProjectType(@Param("projectType") String projectType);
    
    /**
     * 查询所有项目类型及其分数
     */
    @Select("SELECT project_type, score FROM project WHERE is_delete = 0")
    List<java.util.Map<String, Object>> findAllProjectTypesWithScore();
}
