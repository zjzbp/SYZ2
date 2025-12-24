package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cuco.syzadmin.entity.TwoFactorCode;
import org.apache.ibatis.annotations.Mapper;

/**
 * 双因子码Mapper接口
 */
@Mapper
public interface TwoFactorCodeMapper extends BaseMapper<TwoFactorCode> {
}