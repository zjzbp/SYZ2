package com.cuco.syzadmin.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.cuco.syzadmin.dto.LoginRequest;
import com.cuco.syzadmin.dto.LoginResponse;
import com.cuco.syzadmin.dto.UserInfoDTO;
import com.cuco.syzadmin.entity.User;
import com.cuco.syzadmin.mapper.UserMapper;
import com.cuco.syzadmin.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * 用户服务类
 */
@Service
public class UserService {
    
    @Autowired
    private UserMapper userMapper;
    
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
        
        // 验证用户是否存在
        if (user == null) {
            throw new RuntimeException("手机号不存在");
        }
        
        // 验证密码
        if (!loginRequest.getPassword().equals(user.getPassword())) {
            throw new RuntimeException("密码错误");
        }
        
        // 生成 JWT token
        String token = jwtUtil.generateToken(user.getId(), user.getPhone());
        
        // 登录成功，返回用户信息（只包含id和name）
        UserInfoDTO userInfo = new UserInfoDTO(user.getId(), user.getName());
        
        return new LoginResponse(token, userInfo);
    }
}
