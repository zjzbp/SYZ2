package com.cuco.syzuser.service;

import com.cuco.syzuser.entity.ModalIdentifier;
import com.cuco.syzuser.entity.ProjectInfo;
import com.cuco.syzuser.entity.TwoFactorCode;
import com.cuco.syzuser.mapper.ModalIdentifierMapper;
import com.cuco.syzuser.mapper.ProjectInfoMapper;
import com.cuco.syzuser.mapper.TwoFactorCodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class CodeManagementService {

    @Autowired
    private TwoFactorCodeMapper twoFactorCodeMapper;

    @Autowired
    private ModalIdentifierMapper modalIdentifierMapper;

    @Autowired
    private ProjectInfoMapper projectInfoMapper;

    @Autowired
    private GridCodeService gridCodeService;

    // 创建双因子码
    @Transactional
    public TwoFactorCode createTwoFactorCode(String twoFactorValue, String gridCodeValue, String codeType) {
        // 验证网格码
        if (!gridCodeService.validateGridCode(gridCodeValue)) {
            throw new RuntimeException("网格码无效");
        }

        // 检查双因子码是否已存在
        TwoFactorCode existing = twoFactorCodeMapper.findByValue(twoFactorValue);
        if (existing != null) {
            throw new RuntimeException("双因子码已存在");
        }

        TwoFactorCode twoFactorCode = new TwoFactorCode();
        twoFactorCode.setTwoFactorValue(twoFactorValue);
        twoFactorCode.setGridCodeValue(gridCodeValue);
        twoFactorCode.setCodeType(codeType);
        twoFactorCode.setStatus("ACTIVATED");

        twoFactorCodeMapper.insert(twoFactorCode);
        return twoFactorCode;
    }

    // 创建模态标识
    @Transactional
    public ModalIdentifier createModalIdentifier(String modalValue, String twoFactorValue, String identifierType) {
        // 验证双因子码
        TwoFactorCode twoFactorCode = twoFactorCodeMapper.findByValue(twoFactorValue);
        if (twoFactorCode == null || !"ACTIVATED".equals(twoFactorCode.getStatus())) {
            throw new RuntimeException("双因子码无效");
        }

        // 检查模态标识是否已存在
        ModalIdentifier existing = modalIdentifierMapper.findByValue(modalValue);
        if (existing != null) {
            throw new RuntimeException("模态标识已存在");
        }

        ModalIdentifier modalIdentifier = new ModalIdentifier();
        modalIdentifier.setModalValue(modalValue);
        modalIdentifier.setTwoFactorValue(twoFactorValue);
        modalIdentifier.setIdentifierType(identifierType);
        modalIdentifier.setStatus("VALID");
        modalIdentifier.setHashValue(generateHash());

        modalIdentifierMapper.insert(modalIdentifier);
        return modalIdentifier;
    }

    // 根据双因子码查询模态标识列表
    public List<ModalIdentifier> getModalsByTwoFactorCode(String twoFactorValue) {
        return modalIdentifierMapper.findByTwoFactorValue(twoFactorValue);
    }

    // 根据模态标识查询项目列表
    public List<ProjectInfo> getProjectsByModalId(Long modalId) {
        return projectInfoMapper.findByModalId(modalId);
    }

    // 获取用户的码管理信息
    public Map<String, Object> getUserCodeInfo(String twoFactorValue) {
        Map<String, Object> result = new HashMap<>();
        
        // 获取双因子码信息
        TwoFactorCode twoFactorCode = twoFactorCodeMapper.findByValue(twoFactorValue);
        if (twoFactorCode == null) {
            throw new RuntimeException("双因子码不存在");
        }
        result.put("twoFactorCode", twoFactorCode);

        // 获取模态标识列表
        List<ModalIdentifier> modals = modalIdentifierMapper.findByTwoFactorValue(twoFactorValue);
        result.put("modals", modals);

        return result;
    }

    // 生成区块链哈希值
    private String generateHash() {
        return "HASH-" + UUID.randomUUID().toString().replace("-", "").toUpperCase();
    }
}
