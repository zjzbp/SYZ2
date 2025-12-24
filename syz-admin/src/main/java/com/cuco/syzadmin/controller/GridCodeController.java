package com.cuco.syzadmin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.entity.GridCode;
import com.cuco.syzadmin.service.GridCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 网格码控制器
 */
@RestController
@RequestMapping("/api/gridCode")
@CrossOrigin
public class GridCodeController {

    @Autowired
    private GridCodeService gridCodeService;

    /**
     * 分页查询网格码列表
     */
    @GetMapping("/list")
    public Result<IPage<GridCode>> getGridCodeList(
            @RequestParam(required = false) String gridCodeValue,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        try {
            IPage<GridCode> pageResult = gridCodeService.getGridCodeList(gridCodeValue, status, currentPage, pageSize);
            return Result.success("获取网格码列表成功", pageResult);
        } catch (Exception e) {
            return Result.error("获取网格码列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取网格码详情
     */
    @GetMapping("/{id}")
    public Result<GridCode> getGridCodeDetail(@PathVariable Long id) {
        try {
            GridCode gridCode = gridCodeService.getById(id);
            if (gridCode != null) {
                return Result.success("获取网格码详情成功", gridCode);
            } else {
                return Result.error("网格码不存在");
            }
        } catch (Exception e) {
            return Result.error("获取网格码详情失败: " + e.getMessage());
        }
    }

    /**
     * 验真网格码
     */
    @PostMapping("/verify/{id}")
    public Result<Boolean> verifyGridCode(@PathVariable Long id) {
        try {
            boolean result = gridCodeService.verifyGridCode(id);
            if (result) {
                return Result.success("网格码验真成功", true);
            } else {
                return Result.error("网格码验真失败或已失效");
            }
        } catch (Exception e) {
            return Result.error("网格码验真失败: " + e.getMessage());
        }
    }
}