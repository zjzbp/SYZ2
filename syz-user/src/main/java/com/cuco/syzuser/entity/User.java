package com.cuco.syzuser.entity;
import lombok.Data;
import java.util.Date;

@Data
public class User {
    private Long userId;            // 用户ID
    private String userType;        // 用户类型：ENTERPRISE-企业，PERSONAL-个人
    private String phone;           // 手机号（唯一登录凭证）
    private String password;        // 密码（加密存储）
    private String twoFactorCode;   // 双因子码（注册时生成，格式：TFC-XXXXXXXX）
    private String gridCode;        // 网格码（填写详细信息后生成）
    private Integer modalId;        // 当前模态标识值（0-99999999）
    private Integer isFillin;       // 是否已填写详细信息：0-未填写，1-已填写
    private String status;          // 账户状态：ACTIVE-正常，FROZEN-冻结，DELETED-注销
    private Date createTime;        // 创建时间
    private Date updateTime;        // 更新时间
    private Integer deleted;        // 逻辑删除：0-未删除，1-已删除
    private Double totalScore;       // 用户总分数
}