package com.cuco.syzadmin.controller;

import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.entity.Project;
import com.cuco.syzadmin.mapper.ProjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/project")
@CrossOrigin
public class ProjectTypeController {

    @Autowired
    private ProjectMapper projectMapper;

    /**
     * 获取所有项目类型
     */
    @GetMapping("/types")
    public Result<List<String>> getAllProjectTypes() {
        try {
            List<String> projectTypes = projectMapper.findAllProjectTypes();
            return Result.success("获取项目类型成功", projectTypes);
        } catch (Exception e) {
            return Result.error("获取项目类型失败: " + e.getMessage());
        }
    }

    /**
     * 新增项目类型
     */
    @PostMapping
    public Result<Project> createProject(@RequestBody Project project) {
        try {
            // 验证必填字段
            if (project.getProjectType() == null || project.getProjectType().trim().isEmpty()) {
                return Result.error("项目类型不能为空");
            }
            
            projectMapper.insert(project);
            return Result.success("项目类别创建成功", project);
        } catch (Exception e) {
            return Result.error("项目类别创建失败: " + e.getMessage());
        }
    }

    /**
     * 更新项目
     */
    @PutMapping("/{id}")
    public Result<String> updateProject(@PathVariable Integer id, @RequestBody Project project) {
        try {
            Project existProject = projectMapper.selectById(id);
            if (existProject == null) {
                return Result.error("项目不存在");
            }
            
            project.setId(id);
            projectMapper.updateById(project);
            return Result.success("项目更新成功");
        } catch (Exception e) {
            return Result.error("项目更新失败: " + e.getMessage());
        }
    }

    /**
     * 删除项目（逻辑删除）
     */
    @DeleteMapping("/{id}")
    public Result<String> deleteProject(@PathVariable Integer id) {
        try {
            Project existProject = projectMapper.selectById(id);
            if (existProject == null) {
                return Result.error("项目不存在");
            }
            
            // MyBatis-Plus的逻辑删除会自动设置is_delete=1
            projectMapper.deleteById(id);
            return Result.success("项目删除成功");
        } catch (Exception e) {
            return Result.error("项目删除失败: " + e.getMessage());
        }
    }

    /**
     * 根据项目类型删除（逻辑删除）
     */
    @DeleteMapping("/type/{projectType}")
    public Result<String> deleteProjectByType(@PathVariable String projectType) {
        try {
            // 查询所有匹配的项目类型
            List<Project> projects = projectMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Project>()
                    .eq(Project::getProjectType, projectType)
            );
            
            if (projects == null || projects.isEmpty()) {
                return Result.error("项目类型不存在");
            }
            
            // 删除所有匹配的记录
            for (Project project : projects) {
                projectMapper.deleteById(project.getId());
            }
            
            return Result.success("项目类型删除成功");
        } catch (Exception e) {
            return Result.error("项目类型删除失败: " + e.getMessage());
        }
    }
}
