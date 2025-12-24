package com.cuco.syzadmin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cuco.syzadmin.entity.GridCode;
import com.cuco.syzadmin.mapper.GridCodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 网格码服务类
 */
@Service
public class GridCodeService extends ServiceImpl<GridCodeMapper, GridCode> {

    @Autowired
    private GridCodeMapper gridCodeMapper;

    /**
     * 分页查询网格码
     */
    public IPage<GridCode> getGridCodeList(String gridCodeValue, String status, Integer currentPage, Integer pageSize) {
        LambdaQueryWrapper<GridCode> queryWrapper = new LambdaQueryWrapper<>();
        
        // 按网格码值查询
        if (gridCodeValue != null && !gridCodeValue.trim().isEmpty()) {
            queryWrapper.like(GridCode::getGridCodeValue, gridCodeValue);
        }
        
        // 按状态查询
        if (status != null && !status.trim().isEmpty()) {
            queryWrapper.eq(GridCode::getStatus, status);
        }
        
        // 创建分页对象
        Page<GridCode> page = new Page<>(currentPage, pageSize);
        
        return gridCodeMapper.selectPage(page, queryWrapper);
    }

    /**
     * 验真网格码
     */
    public boolean verifyGridCode(Long id) {
        GridCode gridCode = gridCodeMapper.selectById(id);
        if (gridCode != null && "VALID".equals(gridCode.getStatus())) {
            // 这里可以实现具体的验真逻辑，比如检查区块链存证
            return true;
        }
        return false;
    }
}