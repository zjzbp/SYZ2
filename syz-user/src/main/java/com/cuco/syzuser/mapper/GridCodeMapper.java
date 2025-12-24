package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.GridCode;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface GridCodeMapper {

    // 根据网格码值查询
    GridCode findByValue(String gridCodeValue);

    // 插入网格码
    void insert(GridCode gridCode);

    // 更新状态
    void updateStatus(@Param("gridCodeValue") String gridCodeValue, @Param("status") String status);
}
