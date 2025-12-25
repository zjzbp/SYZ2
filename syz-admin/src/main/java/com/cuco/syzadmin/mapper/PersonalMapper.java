package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cuco.syzadmin.entity.Personal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 个人Mapper接口
 */
@Mapper
public interface PersonalMapper extends BaseMapper<Personal> {
    
    /**
     * 根据用户ID查询个人姓名
     */
    @Select("SELECT real_name FROM biz_personal WHERE user_id = #{userId} AND deleted = 0")
    String selectNameByUserId(@Param("userId") Long userId);
    
    /**
     * 根据用户ID查询个人详情
     */
    @Select("SELECT * FROM biz_personal WHERE user_id = #{userId} AND deleted = 0")
    Personal selectByUserId(@Param("userId") Long userId);
}