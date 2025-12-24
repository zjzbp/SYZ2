package com.cuco.syzuser.service;

import com.cuco.syzuser.entity.GridCode;
import com.cuco.syzuser.mapper.GridCodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class GridCodeService {

    @Autowired
    private GridCodeMapper gridCodeMapper;

    // 验证网格码是否存在且有效
    public boolean validateGridCode(String gridCodeValue) {
        GridCode gridCode = gridCodeMapper.findByValue(gridCodeValue);
        return gridCode != null && "VALID".equals(gridCode.getStatus());
    }

    // 创建网格码
    @Transactional
    public GridCode createGridCode(String gridCodeValue) {
        // 检查是否已存在
        GridCode existing = gridCodeMapper.findByValue(gridCodeValue);
        if (existing != null) {
            throw new RuntimeException("网格码已存在");
        }

        GridCode gridCode = new GridCode();
        gridCode.setGridCodeValue(gridCodeValue);
        gridCode.setStatus("VALID");
        gridCode.setHashValue(generateHash());
        gridCode.setDepositRecordId(UUID.randomUUID().toString());
        
        gridCodeMapper.insert(gridCode);
        return gridCode;
    }

    // 生成区块链哈希值(简化版)
    private String generateHash() {
        return "HASH-" + UUID.randomUUID().toString().replace("-", "").toUpperCase();
    }
}
