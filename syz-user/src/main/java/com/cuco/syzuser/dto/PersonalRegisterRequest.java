package com.cuco.syzuser.dto;

import lombok.Data;
import java.util.Date;

/**
 * 个人注册请求 DTO
 */
@Data
public class PersonalRegisterRequest {
    // 基础信息
    private String phone;                       // 手机号（必填）
    private String password;                    // 密码（必填）
    private String confirmPassword;             // 确认密码（必填）
    private String verifyCode;                  // 短信验证码（必填）
    
    // 个人信息
    private String realName;                    // 真实姓名（必填）
    private String idCard;                      // 身份证号（可选）
    private String idCardFrontUrl;              // 身份证正面照URL（可选）
    private String idCardBackUrl;               // 身份证反面照URL（可选）
    private String gender;                      // 性别：MALE-男，FEMALE-女，OTHER-其他（可选）
    private Date birthDate;                     // 出生日期（可选）
    private String nationality;                 // 国籍（可选，默认"中国"）
    private String address;                     // 居住地址（可选）
    private String email;                       // 邮箱（可选）
    private String occupation;                  // 职业（可选）
    private String educationLevel;              // 学历：HIGH_SCHOOL-高中，ASSOCIATE-专科，BACHELOR-本科，MASTER-硕士，DOCTOR-博士（可选）
    private String emergencyContactName;        // 紧急联系人姓名（可选）
    private String emergencyContactPhone;       // 紧急联系人电话（可选）
}
