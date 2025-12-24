package com.cuco.syzadmin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.dto.ModalIdentifierQueryDTO;
import com.cuco.syzadmin.dto.ProjectInfoQueryDTO;
import com.cuco.syzadmin.entity.TwoFactorCode;
import com.cuco.syzadmin.entity.ModalIdentifier;
import com.cuco.syzadmin.entity.ProjectInfo;
import com.cuco.syzadmin.service.TwoFactorCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 双因子码控制器
 */
@RestController
@RequestMapping("/api/twoFactorCode")
@CrossOrigin
public class TwoFactorCodeController {

    @Autowired
    private TwoFactorCodeService twoFactorCodeService;

    /**
     * 分页查询双因子码列表
     */
    @GetMapping("/list")
    public Result<IPage<TwoFactorCode>> getTwoFactorCodeList(
            @RequestParam(required = false) String twoFactorValue,
            @RequestParam(required = false) String gridCodeValue,
            @RequestParam(required = false) String codeType,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        try {
            IPage<TwoFactorCode> pageResult = twoFactorCodeService.getTwoFactorCodeList(
                    twoFactorValue, gridCodeValue, codeType, status, currentPage, pageSize);
            return Result.success("获取双因子码列表成功", pageResult);
        } catch (Exception e) {
            return Result.error("获取双因子码列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取双因子码详情
     */
    @GetMapping("/{id}")
    public Result<TwoFactorCode> getTwoFactorCodeDetail(@PathVariable Long id) {
        try {
            TwoFactorCode twoFactorCode = twoFactorCodeService.getById(id);
            if (twoFactorCode != null) {
                return Result.success("获取双因子码详情成功", twoFactorCode);
            } else {
                return Result.error("双因子码不存在");
            }
        } catch (Exception e) {
            return Result.error("获取双因子码详情失败: " + e.getMessage());
        }
    }

    /**
     * 获取双因子码及其关联信息（用户、网格码、模态标识、项目）
     */
    @GetMapping("/{id}/relations")
    public Result<?> getTwoFactorCodeWithRelations(@PathVariable Long id) {
        try {
            var relations = twoFactorCodeService.getTwoFactorCodeWithRelations(id);
            if (relations != null) {
                return Result.success("获取双因子码关联信息成功", relations);
            } else {
                return Result.error("双因子码不存在");
            }
        } catch (Exception e) {
            return Result.error("获取双因子码关联信息失败: " + e.getMessage());
        }
    }

    /**
     * 分页查询模态标识
     */
    @PostMapping("/{id}/modals/page")
    public Result<IPage<ModalIdentifier>> getModalIdentifiersPage(@PathVariable Long id,
                                                                  @RequestBody ModalIdentifierQueryDTO queryDTO) {
        try {
            TwoFactorCode twoFactorCode = twoFactorCodeService.getById(id);
            if (twoFactorCode == null) {
                return Result.error("双因子码不存在");
            }
            queryDTO.setTwoFactorValue(twoFactorCode.getTwoFactorValue());
            IPage<ModalIdentifier> pageResult = twoFactorCodeService.getModalIdentifiersPage(queryDTO);
            return Result.success("获取模态标识成功", pageResult);
        } catch (Exception e) {
            return Result.error("获取模态标识失败: " + e.getMessage());
        }
    }

    /**
     * 根据双因子码ID获取第一页项目并获取所有项目类型
     */
    @GetMapping("/{id}/projects")
    public Result<?> getProjectsAndTypes(@PathVariable Long id) {
        try {
            TwoFactorCode twoFactorCode = twoFactorCodeService.getById(id);
            if (twoFactorCode == null) {
                return Result.error("双因子码不存在");
            }
            
            // 获取所有项目类型
            List<String> projectTypes = twoFactorCodeService.getProjectTypes();
            
            // 获取第一页项目
            ProjectInfoQueryDTO queryDTO = new ProjectInfoQueryDTO();
            queryDTO.setTwoFactorValue(twoFactorCode.getTwoFactorValue());
            queryDTO.setCurrentPage(1);
            queryDTO.setPageSize(10);
            IPage<ProjectInfo> projectsPage = twoFactorCodeService.getProjectsPage(queryDTO);
            
            // 返回结果
            java.util.Map<String, Object> result = new java.util.HashMap<>();
            result.put("projectTypes", projectTypes);
            result.put("projects", projectsPage);
            
            return Result.success("获取成功", result);
        } catch (Exception e) {
            return Result.error("获取失败: " + e.getMessage());
        }
    }
    
    /**
     * 分页查询项目信息
     */
    @PostMapping("/{id}/projects/page")
    public Result<IPage<ProjectInfo>> getProjectsPage(@PathVariable Long id,
                                                     @RequestBody ProjectInfoQueryDTO queryDTO) {
        try {
            TwoFactorCode twoFactorCode = twoFactorCodeService.getById(id);
            if (twoFactorCode == null) {
                return Result.error("双因子码不存在");
            }
            queryDTO.setTwoFactorValue(twoFactorCode.getTwoFactorValue());
            IPage<ProjectInfo> pageResult = twoFactorCodeService.getProjectsPage(queryDTO);
            return Result.success("获取项目信息成功", pageResult);
        } catch (Exception e) {
            return Result.error("获取项目信息失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取所有项目类型
     */
    @GetMapping("/project/types")
    public Result<List<String>> getProjectTypes() {
        try {
            List<String> projectTypes = twoFactorCodeService.getProjectTypes();
            return Result.success("获取成功", projectTypes);
        } catch (Exception e) {
            return Result.error("获取失败: " + e.getMessage());
        }
    }
}