package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.TwoFactorCode;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface TwoFactorCodeMapper {

    // 根据双因子码值查询
    TwoFactorCode findByValue(String twoFactorValue);

    // 插入双因子码
    void insert(TwoFactorCode twoFactorCode);

    // 更新状态
    void updateStatus(@Param("twoFactorValue") String twoFactorValue, @Param("status") String status);
    
    // 更新网格码绑定
    void updateGridCode(@Param("twoFactorValue") String twoFactorValue, @Param("gridCodeValue") String gridCodeValue);
    
    /**
     * 扣减模态标识数量
     * @param twoFactorValue 双因子码
     * @return 影响行数
     */
    int decreaseRemainingModals(@Param("twoFactorValue") String twoFactorValue);
}
