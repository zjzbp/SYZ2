package com.cuco.syzuser.dto;

import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 企业注册请求 DTO
 */
@Data
public class EnterpriseRegisterRequest {
    // 基础信息
    private String phone;                       // 手机号（必填）
    private String password;                    // 密码（必填）
    private String confirmPassword;             // 确认密码（必填）
    private String verifyCode;                  // 短信验证码（必填）
    
    // 企业信息
    private String enterpriseName;              // 企业名称（必填）
    private String legalPersonName;             // 法人姓名（必填）
    private String unifiedSocialCreditCode;     // 统一社会信用代码（可选）
    private String businessLicenseUrl;          // 营业执照照片URL（可选）
    private String legalPersonIdCard;           // 法人身份证号（可选）
    private String legalPersonIdFrontUrl;       // 法人身份证正面照URL（可选）
    private String legalPersonIdBackUrl;        // 法人身份证反面照URL（可选）
    private String contactPhone;                // 企业联系电话（可选）
    private String contactEmail;                // 企业联系邮箱（可选）
    private String enterpriseAddress;           // 企业地址（可选）
    private String businessScope;               // 经营范围（可选）
    private BigDecimal registeredCapital;       // 注册资本（可选）
    private Date establishmentDate;             // 成立日期（可选）
}
