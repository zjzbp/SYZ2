package com.cuco.syzadmin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cuco.syzadmin.entity.ModalIdentifier;
import com.cuco.syzadmin.mapper.ModalIdentifierMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 模态标识服务类
 */
@Service
public class ModalIdentifierService extends ServiceImpl<ModalIdentifierMapper, ModalIdentifier> {

    @Autowired
    private ModalIdentifierMapper modalIdentifierMapper;

    /**
     * 分页查询模态标识
     */
    public IPage<ModalIdentifier> getModalIdentifierList(String modalValue, String twoFactorValue, String identifierType, String status, Integer currentPage, Integer pageSize) {
        LambdaQueryWrapper<ModalIdentifier> queryWrapper = new LambdaQueryWrapper<>();
        
        // 按模态标识值查询
        if (modalValue != null && !modalValue.trim().isEmpty()) {
            queryWrapper.like(ModalIdentifier::getModalValue, modalValue);
        }
        
        // 按关联双因子码查询
        if (twoFactorValue != null && !twoFactorValue.trim().isEmpty()) {
            queryWrapper.eq(ModalIdentifier::getTwoFactorValue, twoFactorValue);
        }
        
        // 按标识类型查询
        if (identifierType != null && !identifierType.trim().isEmpty()) {
            queryWrapper.eq(ModalIdentifier::getIdentifierType, identifierType);
        }
        
        // 按状态查询
        if (status != null && !status.trim().isEmpty()) {
            queryWrapper.eq(ModalIdentifier::getStatus, status);
        }
        
        // 创建分页对象
        Page<ModalIdentifier> page = new Page<>(currentPage, pageSize);
        
        return modalIdentifierMapper.selectPage(page, queryWrapper);
    }
}