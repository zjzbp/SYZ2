package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.Enterprise;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 企业信息 Mapper 接口
 */
@Mapper
public interface EnterpriseMapper {

    /**
     * 根据用户ID查询企业信息
     */
    Enterprise findByUserId(Long userId);

    /**
     * 插入企业信息
     */
    void insert(Enterprise enterprise);

    /**
     * 更新企业信息
     */
    void update(Enterprise enterprise);

    /**
     * 根据统一社会信用代码查询企业
     */
    Enterprise findByCreditCode(String unifiedSocialCreditCode);

    /**
     * 更新认证状态
     */
    void updateVerificationStatus(@Param("userId") Long userId, 
                                   @Param("verificationStatus") String verificationStatus);
}
