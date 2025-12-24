package com.cuco.syzuser.mapper;

import com.cuco.syzuser.entity.User;
import com.cuco.syzuser.entity.UserModal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    // 根据手机号查用户
    User findByPhone(String phone);

    // 根据双因子码查用户
    User findByTwoFactorCode(String twoFactorCode);
    
    // 根据网格码查用户
    User findByGridCode(String gridCode);

    // 根据双因子码和网格码查用户
    User findByTwoFactorCodeAndGridCode(@Param("twoFactorCode") String twoFactorCode, @Param("gridCode") String gridCode);

    // 根据ID查用户
    User findById(Long id);

    // 插入新用户
    void insert(User user);

    // 更新用户
    void update(User user);

    // 更新密码
    void updatePassword(@Param("phone") String phone, @Param("password") String password);

    // 更新用户当前模态标识
    void updateUserModalId(@Param("userId") Long userId, @Param("modalId") Integer modalId);

    // 插入用户模态关联记录
    void insertUserModal(UserModal userModal);

    // 查询用户的所有模态标识
    List<UserModal> findModalsByUserId(Long userId);
    
    // 统计已使用的模态标识数量
    Long countUsedModals();
}