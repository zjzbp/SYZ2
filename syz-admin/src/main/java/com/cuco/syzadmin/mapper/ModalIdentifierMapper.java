package com.cuco.syzadmin.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cuco.syzadmin.entity.ModalIdentifier;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 模态标识Mapper接口
 */
@Mapper
public interface ModalIdentifierMapper extends BaseMapper<ModalIdentifier> {
    
    /**
     * 根据双因子码值统计模态标识数量
     */
    @Select("SELECT COUNT(*) FROM biz_modal_identifier WHERE two_factor_value = #{twoFactorValue}")
    Integer countByTwoFactorValue(@Param("twoFactorValue") String twoFactorValue);
    
    /**
     * 根据双因子码值查询模态标识列表
     */
    @Select("SELECT * FROM biz_modal_identifier WHERE two_factor_value = #{twoFactorValue} AND deleted = 0 ORDER BY create_time DESC")
    List<ModalIdentifier> selectByTwoFactorValue(@Param("twoFactorValue") String twoFactorValue);
    
    /**
     * 分页查询模态标识（支持时间范围、模糊查询、类型筛选）
     */
    IPage<ModalIdentifier> selectPageWithFilters(@Param("twoFactorValue") String twoFactorValue,
                                                  @Param("modalValue") String modalValue,
                                                  @Param("identifierType") String identifierType,
                                                  @Param("createTimeStart") String createTimeStart,
                                                  @Param("createTimeEnd") String createTimeEnd,
                                                  Page<?> page);
    
    /**
     * 根据用户ID查询模态标识列表
     */
    @Select("SELECT * FROM biz_modal_identifier WHERE user_id = #{userId} AND deleted = 0 ORDER BY create_time DESC")
    List<ModalIdentifier> selectByUserId(@Param("userId") Long userId);
    
    /**
     * 根据用户ID统计模态标识数量
     */
    @Select("SELECT COUNT(*) FROM biz_modal_identifier WHERE user_id = #{userId} AND deleted = 0")
    Integer countByUserId(@Param("userId") Long userId);
}