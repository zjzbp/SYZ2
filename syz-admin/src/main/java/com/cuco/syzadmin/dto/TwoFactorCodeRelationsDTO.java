package com.cuco.syzadmin.dto;

import com.cuco.syzadmin.entity.TwoFactorCode;
import com.cuco.syzadmin.entity.User;
import com.cuco.syzadmin.entity.GridCode;
import com.cuco.syzadmin.entity.ModalIdentifier;
import com.cuco.syzadmin.entity.ProjectInfo;

import java.util.List;

/**
 * 双因子码关联信息DTO
 */
public class TwoFactorCodeRelationsDTO {
    private TwoFactorCode twoFactorCode;
    private User user;
    private String userName; // 用户姓名
    private GridCode gridCode;
    private List<ModalIdentifier> modalIdentifiers;
    private List<ProjectInfo> projects;

    // 构造函数
    public TwoFactorCodeRelationsDTO() {
    }

    public TwoFactorCodeRelationsDTO(TwoFactorCode twoFactorCode, User user, GridCode gridCode,
                                     List<ModalIdentifier> modalIdentifiers, List<ProjectInfo> projects) {
        this.twoFactorCode = twoFactorCode;
        this.user = user;
        this.gridCode = gridCode;
        this.modalIdentifiers = modalIdentifiers;
        this.projects = projects;
    }

    // Getter和Setter方法
    public TwoFactorCode getTwoFactorCode() {
        return twoFactorCode;
    }

    public void setTwoFactorCode(TwoFactorCode twoFactorCode) {
        this.twoFactorCode = twoFactorCode;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public GridCode getGridCode() {
        return gridCode;
    }

    public void setGridCode(GridCode gridCode) {
        this.gridCode = gridCode;
    }

    public List<ModalIdentifier> getModalIdentifiers() {
        return modalIdentifiers;
    }

    public void setModalIdentifiers(List<ModalIdentifier> modalIdentifiers) {
        this.modalIdentifiers = modalIdentifiers;
    }

    public List<ProjectInfo> getProjects() {
        return projects;
    }

    public void setProjects(List<ProjectInfo> projects) {
        this.projects = projects;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
}