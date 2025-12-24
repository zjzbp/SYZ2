package com.cuco.syzadmin.mapper;

import com.cuco.syzadmin.dto.StatisticsResponse;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * 统计数据Mapper接口
 */
@Mapper
public interface StatisticsMapper {

    /**
     * 获取统计数据
     */
    @Select("SELECT " +
            "(SELECT COUNT(*) FROM biz_personal) AS totalUsers, " +
            "(SELECT COUNT(*) FROM biz_grid_code) AS totalGridCodes, " +
            "(SELECT COUNT(*) FROM biz_two_factor_code) AS totalTwoFactorCodes, " +
            "(SELECT COUNT(*) FROM biz_modal_identifier) AS totalModalIdentifiers, " +
            "(SELECT COUNT(*) FROM biz_project_info) AS totalProjects")
    StatisticsResponse getStatisticsData();
    
    /**
     * 获取最近7天的用户注册趋势
     */
    @Select("SELECT DATE(create_time) as date, COUNT(*) as count " +
            "FROM biz_personal " +
            "WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
            "GROUP BY DATE(create_time) " +
            "ORDER BY date")
    List<Map<String, Object>> getUserTrendData();
    
    /**
     * 获取双因子码类型分布
     */
    @Select("SELECT code_type as type, COUNT(*) as count " +
            "FROM biz_two_factor_code " +
            "GROUP BY code_type")
    List<Map<String, Object>> getTwoFactorCodeTypeDistribution();
    
    /**
     * 获取网格码状态分布
     */
    @Select("SELECT status as status, COUNT(*) as count " +
            "FROM biz_grid_code " +
            "GROUP BY status")
    List<Map<String, Object>> getGridCodeStatusDistribution();
    
    /**
     * 获取模态标识类型分布
     */
    @Select("SELECT identifier_type as type, COUNT(*) as count " +
            "FROM biz_modal_identifier " +
            "GROUP BY identifier_type")
    List<Map<String, Object>> getModalIdentifierTypeDistribution();
}