package com.cuco.syzadmin.controller;

import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.dto.LoginRequest;
import com.cuco.syzadmin.dto.LoginResponse;
import com.cuco.syzadmin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 用户控制器
 */
@RestController
@RequestMapping("/api")
@CrossOrigin
public class UserController {
    
    @Autowired
    private UserService userService;
    
    /**
     * 用户登录接口
     * @param loginRequest 登录请求
     * @return 登录结果（包含token）
     */
    @PostMapping("/login")
    public Result<LoginResponse> login(@RequestBody LoginRequest loginRequest) {
        try {
            LoginResponse loginResponse = userService.login(loginRequest);
            return Result.success("登录成功", loginResponse);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
