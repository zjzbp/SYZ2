package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.Personal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 个人信息 Mapper 接口
 */
@Mapper
public interface PersonalMapper {

    /**
     * 根据用户ID查询个人信息
     */
    Personal findByUserId(Long userId);

    /**
     * 插入个人信息
     */
    void insert(Personal personal);

    /**
     * 更新个人信息
     */
    void update(Personal personal);

    /**
     * 根据身份证号查询个人
     */
    Personal findByIdCard(String idCard);

    /**
     * 更新认证状态
     */
    void updateVerificationStatus(@Param("userId") Long userId, 
                                   @Param("verificationStatus") String verificationStatus);
}
