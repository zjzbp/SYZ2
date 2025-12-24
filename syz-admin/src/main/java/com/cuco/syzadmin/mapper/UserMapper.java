package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cuco.syzadmin.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 用户Mapper接口
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {
    
    /**
     * 根据双因子码查询用户
     */
    @Select("SELECT user_id, user_type, phone, grid_code, two_factor_code, password, is_fillin, create_time, modal_id FROM biz_user WHERE two_factor_code = #{twoFactorCode} AND deleted = 0")
    User selectByTwoFactorCode(@Param("twoFactorCode") String twoFactorCode);
}