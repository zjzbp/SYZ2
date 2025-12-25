package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cuco.syzadmin.entity.Enterprise;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 企业Mapper接口
 */
@Mapper
public interface EnterpriseMapper extends BaseMapper<Enterprise> {
    
    /**
     * 根据用户ID查询企业名称
     */
    @Select("SELECT enterprise_name FROM biz_enterprise WHERE user_id = #{userId} AND deleted = 0")
    String selectNameByUserId(@Param("userId") Long userId);
    
    /**
     * 根据用户ID查询企业详情
     */
    @Select("SELECT * FROM biz_enterprise WHERE user_id = #{userId} AND deleted = 0")
    Enterprise selectByUserId(@Param("userId") Long userId);
}