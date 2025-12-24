package com.cuco.syzadmin.controller;

import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.dto.StatisticsResponse;
import com.cuco.syzadmin.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * 统计控制器
 */
@RestController
@RequestMapping("/api/statistics")
@CrossOrigin
public class StatisticsController {

    @Autowired
    private StatisticsService statisticsService;

    /**
     * 获取统计数据
     */
    @GetMapping("/data")
    public Result<StatisticsResponse> getStatisticsData() {
        try {
            StatisticsResponse response = statisticsService.getStatistics();
            return Result.success("获取统计数据成功", response);
        } catch (Exception e) {
            return Result.error("获取统计数据失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取用户趋势数据
     */
    @GetMapping("/user-trend")
    public Result<List<Map<String, Object>>> getUserTrendData() {
        try {
            List<Map<String, Object>> data = statisticsService.getUserTrendData();
            return Result.success("获取用户趋势数据成功", data);
        } catch (Exception e) {
            return Result.error("获取用户趋势数据失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取双因子码类型分布
     */
    @GetMapping("/two-factor-distribution")
    public Result<List<Map<String, Object>>> getTwoFactorCodeTypeDistribution() {
        try {
            List<Map<String, Object>> data = statisticsService.getTwoFactorCodeTypeDistribution();
            return Result.success("获取双因子码类型分布成功", data);
        } catch (Exception e) {
            return Result.error("获取双因子码类型分布失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取网格码状态分布
     */
    @GetMapping("/grid-code-status")
    public Result<List<Map<String, Object>>> getGridCodeStatusDistribution() {
        try {
            List<Map<String, Object>> data = statisticsService.getGridCodeStatusDistribution();
            return Result.success("获取网格码状态分布成功", data);
        } catch (Exception e) {
            return Result.error("获取网格码状态分布失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取模态标识类型分布
     */
    @GetMapping("/modal-identifier-type")
    public Result<List<Map<String, Object>>> getModalIdentifierTypeDistribution() {
        try {
            List<Map<String, Object>> data = statisticsService.getModalIdentifierTypeDistribution();
            return Result.success("获取模态标识类型分布成功", data);
        } catch (Exception e) {
            return Result.error("获取模态标识类型分布失败: " + e.getMessage());
        }
    }
}