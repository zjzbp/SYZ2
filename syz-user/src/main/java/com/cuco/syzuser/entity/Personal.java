package com.cuco.syzuser.entity;

import lombok.Data;
import java.util.Date;

/**
 * 个人用户详细信息实体类
 */
@Data
public class Personal {
    private Long personalId;                // 个人信息ID
    private Long userId;                    // 关联用户ID（逻辑外键 → biz_user.user_id）
    private String realName;                // 真实姓名
    private String idCard;                  // 身份证号
    private String idCardFrontUrl;          // 身份证正面照URL
    private String idCardBackUrl;           // 身份证反面照URL
    private String gender;                  // 性别：MALE-男，FEMALE-女，OTHER-其他
    private Date birthDate;                 // 出生日期
    private String nationality;             // 国籍
    private String address;                 // 居住地址
    private String email;                   // 邮箱
    private String occupation;              // 职业
    private String educationLevel;          // 学历：HIGH_SCHOOL-高中，ASSOCIATE-专科，BACHELOR-本科，MASTER-硕士，DOCTOR-博士
    private String emergencyContactName;    // 紧急联系人姓名
    private String emergencyContactPhone;   // 紧急联系人电话
    private String verificationStatus;      // 实名认证状态：PENDING-待审核，APPROVED-已通过，REJECTED-已拒绝
    private Date verificationTime;          // 认证时间
    private String remark;                  // 备注说明
    private Date createTime;                // 创建时间
    private Date updateTime;                // 更新时间
    private Integer deleted;                // 逻辑删除：0-未删除，1-已删除
}
