package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cuco.syzadmin.entity.GridCode;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 网格码Mapper接口
 */
@Mapper
public interface GridCodeMapper extends BaseMapper<GridCode> {
    
    /**
     * 根据网格码值查询网格码
     */
    @Select("SELECT * FROM biz_grid_code WHERE grid_code_value = #{gridCodeValue} AND deleted = 0")
    GridCode selectByGridCodeValue(@Param("gridCodeValue") String gridCodeValue);
}