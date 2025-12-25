package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cuco.syzadmin.entity.TwoFactorCode;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 双因子码Mapper接口
 */
@Mapper
public interface TwoFactorCodeMapper extends BaseMapper<TwoFactorCode> {
    
    /**
     * 根据双因子码值查询
     */
    @Select("SELECT * FROM biz_two_factor_code WHERE two_factor_value = #{twoFactorValue} LIMIT 1")
    TwoFactorCode selectByTwoFactorValue(@Param("twoFactorValue") String twoFactorValue);
}