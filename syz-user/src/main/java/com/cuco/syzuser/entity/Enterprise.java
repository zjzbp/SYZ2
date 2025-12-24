package com.cuco.syzuser.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 企业用户详细信息实体类
 */
@Data
public class Enterprise {
    private Long enterpriseId;                  // 企业信息ID
    private Long userId;                        // 关联用户ID（逻辑外键 → biz_user.user_id）
    private String enterpriseName;              // 企业名称
    private String unifiedSocialCreditCode;     // 统一社会信用代码（18位）
    private String businessLicenseUrl;          // 营业执照照片URL
    private String legalPersonName;             // 法人姓名
    private String legalPersonIdCard;           // 法人身份证号
    private String legalPersonIdFrontUrl;       // 法人身份证正面照URL
    private String legalPersonIdBackUrl;        // 法人身份证反面照URL
    private String contactPhone;                // 企业联系电话
    private String contactEmail;                // 企业联系邮箱
    private String enterpriseAddress;           // 企业地址
    private String businessScope;               // 经营范围
    private BigDecimal registeredCapital;       // 注册资本（元）
    private Date establishmentDate;             // 成立日期
    private String verificationStatus;          // 认证状态：PENDING-待审核，APPROVED-已通过，REJECTED-已拒绝
    private Date verificationTime;              // 认证时间
    private String remark;                      // 备注说明
    private Date createTime;                    // 创建时间
    private Date updateTime;                    // 更新时间
    private Integer deleted;                    // 逻辑删除：0-未删除，1-已删除
}
