package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.ModalIdentifier;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ModalIdentifierMapper {

    // 根据模态标识值查询
    ModalIdentifier findByValue(String modalValue);
    
    // 根据模态标识码查询（雪花算法生成的字符串）
    ModalIdentifier findByModalValue(String modalValue);

    // 根据双因子码值查询模态标识列表
    List<ModalIdentifier> findByTwoFactorValue(String twoFactorValue);

    // 插入模态标识
    void insert(ModalIdentifier modalIdentifier);

    // 更新状态
    void updateStatus(@Param("modalValue") String modalValue, @Param("status") String status);
    
    // 根据用户ID查询模态标识列表
    List<ModalIdentifier> findByUserId(Long userId);
    
    // 根据用户ID和项目类型查询
    List<ModalIdentifier> findByUserIdAndType(@Param("userId") Long userId, @Param("projectType") String projectType);
    
    // 根据用户ID和日期范围查询
    List<ModalIdentifier> findByUserIdAndDateRange(@Param("userId") Long userId, @Param("startDate") String startDate, @Param("endDate") String endDate);
    
    /**
     * 查询用户的模态绑定记录（关联项目信息）
     * @param userId 用户ID
     * @param projectType 项目类型（可选）
     * @param startDate 开始日期（可选）
     * @param endDate 结束日期（可选）
     * @return 绑定记录列表
     */
    List<Map<String, Object>> findUserBindings(@Param("userId") Long userId, 
                                                 @Param("projectType") String projectType, 
                                                 @Param("startDate") String startDate, 
                                                 @Param("endDate") String endDate);
}
