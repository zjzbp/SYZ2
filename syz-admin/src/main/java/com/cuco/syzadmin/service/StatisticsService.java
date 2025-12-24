package com.cuco.syzadmin.service;

import com.cuco.syzadmin.dto.StatisticsResponse;
import com.cuco.syzadmin.mapper.StatisticsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 统计服务类
 */
@Service
public class StatisticsService {

    @Autowired
    private StatisticsMapper statisticsMapper;

    /**
     * 获取统计数据
     */
    public StatisticsResponse getStatistics() {
        StatisticsResponse response = statisticsMapper.getStatisticsData();
        response.setMessage("统计数据获取成功");
        return response;
    }
    
    /**
     * 获取用户趋势数据
     */
    public List<Map<String, Object>> getUserTrendData() {
        return statisticsMapper.getUserTrendData();
    }
    
    /**
     * 获取双因子码类型分布（转换为中文）
     */
    public List<Map<String, Object>> getTwoFactorCodeTypeDistribution() {
        List<Map<String, Object>> data = statisticsMapper.getTwoFactorCodeTypeDistribution();
        return data.stream().map(item -> {
            Map<String, Object> newItem = new java.util.HashMap<>(item);
            String type = (String) item.get("type");
            if (type != null) {
                String typeCn = convertTwoFactorCodeTypeToChinese(type);
                newItem.put("type", typeCn);
                newItem.put("name", typeCn); // 为前端图表提供name字段
            }
            return newItem;
        }).collect(Collectors.toList());
    }
    
    /**
     * 获取网格码状态分布（转换为中文）
     */
    public List<Map<String, Object>> getGridCodeStatusDistribution() {
        List<Map<String, Object>> data = statisticsMapper.getGridCodeStatusDistribution();
        return data.stream().map(item -> {
            Map<String, Object> newItem = new java.util.HashMap<>(item);
            String status = (String) item.get("status");
            if (status != null) {
                String statusCn = convertGridCodeStatusToChinese(status);
                newItem.put("status", statusCn);
                newItem.put("name", statusCn); // 为前端图表提供name字段
            }
            return newItem;
        }).collect(Collectors.toList());
    }
    
    /**
     * 获取模态标识类型分布（转换为中文）
     */
    public List<Map<String, Object>> getModalIdentifierTypeDistribution() {
        List<Map<String, Object>> data = statisticsMapper.getModalIdentifierTypeDistribution();
        return data.stream().map(item -> {
            Map<String, Object> newItem = new java.util.HashMap<>(item);
            String type = (String) item.get("type");
            if (type != null) {
                String typeCn = convertModalIdentifierTypeToChinese(type);
                newItem.put("type", typeCn);
                newItem.put("name", typeCn); // 为前端图表提供name字段
            }
            return newItem;
        }).collect(Collectors.toList());
    }

    /**
     * 将双因子码类型转换为中文
     */
    private String convertTwoFactorCodeTypeToChinese(String type) {
        switch (type) {
            case "ASSET":
                return "资产类";
            case "PERSONAL":
                return "个人类";
            default:
                return type;
        }
    }

    /**
     * 将网格码状态转换为中文
     */
    private String convertGridCodeStatusToChinese(String status) {
        switch (status) {
            case "VALID":
                return "有效";
            case "INVALID":
                return "失效";
            default:
                return status;
        }
    }

    /**
     * 将模态标识类型转换为中文
     */
    private String convertModalIdentifierTypeToChinese(String type) {
        switch (type) {
            case "PROJECT":
                return "项目类";
            default:
                return type;
        }
    }
}