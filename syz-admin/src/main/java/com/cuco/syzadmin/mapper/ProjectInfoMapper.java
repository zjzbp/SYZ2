package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cuco.syzadmin.entity.ProjectInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 项目信息Mapper接口
 */
@Mapper
public interface ProjectInfoMapper extends BaseMapper<ProjectInfo> {
    
    /**
     * 根据模态标识ID数组查询项目信息
     */
    @Select("<script>" +
            "SELECT * FROM biz_project_info WHERE " +
            "<if test='modalIds != null and modalIds.length > 0'>" +
            "modal_id IN " +
            "<foreach collection='modalIds' item='id' open='(' separator=',' close=')'> " +
            "#{id}" +
            "</foreach> AND " +
            "</if>" +
            "deleted = 0" +
            "</script>")
    List<ProjectInfo> selectByModalIds(@Param("modalIds") Long[] modalIds);
        
    /**
     * 分页查询项目信息（支持时间范围、模糊查询、类型筛选）
     */
    IPage<ProjectInfo> selectPageWithFilters(@Param("modalIds") Long[] modalIds,
                                             @Param("projectName") String projectName,
                                             @Param("projectType") String projectType,
                                             @Param("createTimeStart") String createTimeStart,
                                             @Param("createTimeEnd") String createTimeEnd,
                                             Page<?> page);
    
    /**
     * 获取所有项目类型（不重複）
     */
    @Select("SELECT DISTINCT project_type FROM biz_project_info WHERE deleted = 0 AND project_type IS NOT NULL ORDER BY project_type")
    List<String> selectDistinctProjectTypes();
}