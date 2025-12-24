package com.cuco.syzadmin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.entity.ProjectInfo;
import com.cuco.syzadmin.service.ProjectInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 项目信息控制器
 */
@RestController
@RequestMapping("/api/projectClassification")
@CrossOrigin
public class ProjectInfoController {

    @Autowired
    private ProjectInfoService projectInfoService;

    /**
     * 分页查询项目信息列表
     */
    @GetMapping("/list")
    public Result<IPage<ProjectInfo>> getProjectInfoList(
            @RequestParam(required = false) String projectName,
            @RequestParam(required = false) String projectType,
            @RequestParam(required = false) Long modalId, // 关联模态标识ID
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        try {
            IPage<ProjectInfo> pageResult = projectInfoService.getProjectInfoList(
                    projectName, projectType, modalId, currentPage, pageSize);
            return Result.success("获取项目信息列表成功", pageResult);
        } catch (Exception e) {
            return Result.error("获取项目信息列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取项目信息详情
     */
    @GetMapping("/{id}")
    public Result<ProjectInfo> getProjectInfoDetail(@PathVariable Long id) {
        try {
            ProjectInfo projectInfo = projectInfoService.getById(id);
            if (projectInfo != null) {
                return Result.success("获取项目信息详情成功", projectInfo);
            } else {
                return Result.error("项目信息不存在");
            }
        } catch (Exception e) {
            return Result.error("获取项目信息详情失败: " + e.getMessage());
        }
    }

    /**
     * 预览项目
     */
    @GetMapping("/preview/{id}")
    public Result<ProjectInfo> previewProject(@PathVariable Long id) {
        try {
            ProjectInfo projectInfo = projectInfoService.getById(id);
            if (projectInfo != null) {
                return Result.success("预览项目成功", projectInfo);
            } else {
                return Result.error("项目信息不存在");
            }
        } catch (Exception e) {
            return Result.error("预览项目失败: " + e.getMessage());
        }
    }
}