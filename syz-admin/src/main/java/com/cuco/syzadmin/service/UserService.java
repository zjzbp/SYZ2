package com.cuco.syzadmin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cuco.syzadmin.dto.LoginRequest;
import com.cuco.syzadmin.dto.LoginResponse;
import com.cuco.syzadmin.dto.UserInfoDTO;
import com.cuco.syzadmin.entity.User;
import com.cuco.syzadmin.mapper.UserMapper;
import com.cuco.syzadmin.mapper.PersonalMapper;
import com.cuco.syzadmin.mapper.EnterpriseMapper;
import com.cuco.syzadmin.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * 用户服务类
 */
@Service
public class UserService {
    
    @Autowired
    private UserMapper userMapper;
    
    @Autowired
    private PersonalMapper personalMapper;
    
    @Autowired
    private EnterpriseMapper enterpriseMapper;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    /**
     * 用户登录
     * @param loginRequest 登录请求
     * @return 登录响应（包含token和用户信息）
     */
    public LoginResponse login(LoginRequest loginRequest) {
        // 校验参数
        if (!StringUtils.hasText(loginRequest.getPhone()) 
                || !StringUtils.hasText(loginRequest.getPassword())) {
            throw new RuntimeException("手机号和密码不能为空");
        }
        
        // 根据手机号查询用户
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getPhone, loginRequest.getPhone());
        User user = userMapper.selectOne(queryWrapper);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        if (!loginRequest.getPassword().equals(user.getPassword())) {
            throw new RuntimeException("密码错误");
        }

        // 获取用户姓名（从个人或企业表中）
        String userName = null;
        if ("PERSONAL".equals(user.getUserType())) {
            userName = personalMapper.selectNameByUserId(user.getUserId());
        } else if ("ENTERPRISE".equals(user.getUserType())) {
            userName = enterpriseMapper.selectNameByUserId(user.getUserId());
        }
        
        // 如果没有查到姓名，使用手机号作为默认姓名
        if (userName == null || userName.isEmpty()) {
            userName = user.getPhone();
        }
        
        // 生成token
        String token = jwtUtil.generateToken(user.getUserId(), user.getPhone());
        LoginResponse response = new LoginResponse();
        response.setToken(token);
        UserInfoDTO userInfoDTO = new UserInfoDTO(user.getUserId(), userName);
        response.setUser(userInfoDTO);
        return response;
    }

    /**
     * 分页查询用户列表
     * @param name 用户名
     * @param phone 手机号
     * @param currentPage 当前页
     * @param pageSize 每页大小
     * @return 用户分页数据
     */
    public IPage<User> getUserList(String phone, Integer currentPage, Integer pageSize) {
        Page<User> page = new Page<>(currentPage, pageSize);
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(phone)) {
            queryWrapper.eq(User::getPhone, phone);
        }
        return userMapper.selectPage(page, queryWrapper);
    }

    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户信息
     */
    public User getUserById(Long id) {
        return userMapper.selectById(id);
    }

    /**
     * 新增用户
     * @param user 用户信息
     * @return 影响行数
     */
    public int addUser(User user) {
        return userMapper.insert(user);
    }

    /**
     * 更新用户
     * @param user 用户信息
     * @return 影响行数
     */
    public int updateUser(User user) {
        return userMapper.updateById(user);
    }

    /**
     * 删除用户
     * @param id 用户ID
     * @return 影响行数
     */
    public int deleteUser(Long id) {
        return userMapper.deleteById(id);
    }

    /**
     * 批量删除用户
     * @param ids 用户ID列表
     * @return 影响行数
     */
    public int deleteUsers(List<Long> ids) {
        return userMapper.deleteBatchIds(ids);
    }
}