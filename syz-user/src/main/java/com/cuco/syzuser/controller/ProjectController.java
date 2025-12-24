package com.cuco.syzuser.controller;

import com.cuco.syzuser.entity.ProjectInfo;
import com.cuco.syzuser.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/projects")
public class ProjectController {

    @Autowired
    private ProjectService projectService;

    /**
     * 创建项目
     */
    @PostMapping
    public Map<String, Object> createProject(@RequestBody ProjectInfo projectInfo) {
        Map<String, Object> response = new HashMap<>();
        try {
            projectService.createProject(projectInfo);
            response.put("code", 200);
            response.put("message", "项目创建成功");
            return response;
        } catch (Exception e) {
            response.put("code", 0);
            response.put("message", e.getMessage());
            return response;
        }
    }

    /**
     * 根据用户ID查询项目列表
     */
    @GetMapping("/user/{userId}")
    public Map<String, Object> getProjectsByUserId(@PathVariable Long userId) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<ProjectInfo> projects = projectService.getProjectsByUserId(userId);
            response.put("code", 200);
            response.put("data", projects);
            return response;
        } catch (Exception e) {
            response.put("code", 0);
            response.put("message", e.getMessage());
            return response;
        }
    }

    /**
     * 根据项目ID查询项目详情
     */
    @GetMapping("/{projectId}")
    public Map<String, Object> getProjectById(@PathVariable Long projectId) {
        Map<String, Object> response = new HashMap<>();
        try {
            ProjectInfo project = projectService.getProjectById(projectId);
            response.put("code", 200);
            response.put("data", project);
            return response;
        } catch (Exception e) {
            response.put("code", 0);
            response.put("message", e.getMessage());
            return response;
        }
    }

    /**
     * 更新项目信息
     */
    @PutMapping("/{projectId}")
    public Map<String, Object> updateProject(@PathVariable Long projectId, 
                                             @RequestBody ProjectInfo projectInfo) {
        Map<String, Object> response = new HashMap<>();
        try {
            projectInfo.setProjectId(projectId);
            projectService.updateProject(projectInfo);
            response.put("code", 200);
            response.put("message", "项目更新成功");
            return response;
        } catch (Exception e) {
            response.put("code", 0);
            response.put("message", e.getMessage());
            return response;
        }
    }

    /**
     * 删除项目（逻辑删除）
     */
    @DeleteMapping("/{projectId}")
    public Map<String, Object> deleteProject(@PathVariable Long projectId) {
        Map<String, Object> response = new HashMap<>();
        try {
            projectService.deleteProject(projectId);
            response.put("code", 200);
            response.put("message", "项目删除成功");
            return response;
        } catch (Exception e) {
            response.put("code", 0);
            response.put("message", e.getMessage());
            return response;
        }
    }

    /**
     * 更新项目状态
     */
    @PatchMapping("/{projectId}/status")
    public Map<String, Object> updateProjectStatus(@PathVariable Long projectId,
                                                   @RequestParam String status) {
        Map<String, Object> response = new HashMap<>();
        try {
            projectService.updateProjectStatus(projectId, status);
            response.put("code", 200);
            response.put("message", "状态更新成功");
            return response;
        } catch (Exception e) {
            response.put("code", 0);
            response.put("message", e.getMessage());
            return response;
        }
    }
}
