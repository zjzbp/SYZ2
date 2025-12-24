package com.cuco.syzadmin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.entity.ModalIdentifier;
import com.cuco.syzadmin.service.ModalIdentifierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 模态标识控制器
 */
@RestController
@RequestMapping("/api/modalIdentifier")
@CrossOrigin
public class ModalIdentifierController {

    @Autowired
    private ModalIdentifierService modalIdentifierService;

    /**
     * 分页查询模态标识列表
     */
    @GetMapping("/list")
    public Result<IPage<ModalIdentifier>> getModalIdentifierList(
            @RequestParam(required = false) String modalValue,
            @RequestParam(required = false) String twoFactorValue,
            @RequestParam(required = false) String identifierType,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        try {
            IPage<ModalIdentifier> pageResult = modalIdentifierService.getModalIdentifierList(
                    modalValue, twoFactorValue, identifierType, status, currentPage, pageSize);
            return Result.success("获取模态标识列表成功", pageResult);
        } catch (Exception e) {
            return Result.error("获取模态标识列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取模态标识详情
     */
    @GetMapping("/{id}")
    public Result<ModalIdentifier> getModalIdentifierDetail(@PathVariable Long id) {
        try {
            ModalIdentifier modalIdentifier = modalIdentifierService.getById(id);
            if (modalIdentifier != null) {
                return Result.success("获取模态标识详情成功", modalIdentifier);
            } else {
                return Result.error("模态标识不存在");
            }
        } catch (Exception e) {
            return Result.error("获取模态标识详情失败: " + e.getMessage());
        }
    }
}