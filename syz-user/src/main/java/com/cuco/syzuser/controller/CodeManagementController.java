package com.cuco.syzuser.controller;

import com.cuco.syzuser.dto.Result;
import com.cuco.syzuser.entity.ModalIdentifier;
import com.cuco.syzuser.entity.ProjectInfo;
import com.cuco.syzuser.entity.TwoFactorCode;
import com.cuco.syzuser.service.CodeManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/code")
@CrossOrigin(origins = "*")
public class CodeManagementController {

    @Autowired
    private CodeManagementService codeManagementService;

    // 创建双因子码
    @PostMapping("/createTwoFactorCode")
    public Result<TwoFactorCode> createTwoFactorCode(
            @RequestParam String twoFactorValue,
            @RequestParam String gridCodeValue,
            @RequestParam String codeType) {
        try {
            TwoFactorCode result = codeManagementService.createTwoFactorCode(twoFactorValue, gridCodeValue, codeType);
            return Result.success("双因子码创建成功", result);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    // 创建模态标识
    @PostMapping("/createModalIdentifier")
    public Result<ModalIdentifier> createModalIdentifier(
            @RequestParam String modalValue,
            @RequestParam String twoFactorValue,
            @RequestParam String identifierType) {
        try {
            ModalIdentifier result = codeManagementService.createModalIdentifier(modalValue, twoFactorValue, identifierType);
            return Result.success("模态标识创建成功", result);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    // 根据双因子码查询模态标识列表
    @GetMapping("/modals")
    public Result<List<ModalIdentifier>> getModalsByTwoFactorCode(@RequestParam String twoFactorValue) {
        try {
            List<ModalIdentifier> modals = codeManagementService.getModalsByTwoFactorCode(twoFactorValue);
            return Result.success("查询成功", modals);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    // 根据模态标识查询项目列表
    @GetMapping("/projects")
    public Result<List<ProjectInfo>> getProjectsByModalId(@RequestParam Long modalId) {
        try {
            List<ProjectInfo> projects = codeManagementService.getProjectsByModalId(modalId);
            return Result.success("查询成功", projects);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    // 获取用户的码管理信息
    @GetMapping("/userCodeInfo")
    public Result<Map<String, Object>> getUserCodeInfo(@RequestParam String twoFactorValue) {
        try {
            Map<String, Object> info = codeManagementService.getUserCodeInfo(twoFactorValue);
            return Result.success("查询成功", info);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
