package com.cuco.syzuser.controller;

import com.cuco.syzuser.dto.*;
import com.cuco.syzuser.entity.ModalIdentifier;
import com.cuco.syzuser.entity.Project;
import com.cuco.syzuser.entity.ProjectInfo;
import com.cuco.syzuser.entity.User;
import com.cuco.syzuser.entity.UserModal;
import com.cuco.syzuser.service.SmsService;
import com.cuco.syzuser.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
@CrossOrigin(origins = "*") // 允许前端跨域
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private SmsService smsService;

    @PostMapping("/sendCode")
    public Result<Void> sendVerifyCode(@RequestParam String phone) {
        smsService.sendVerifyCode(phone);
        return Result.success("验证码发送成功(默认888888)", null);
    }

    @PostMapping("/register")
    public Result<Map<String, Object>> register(@RequestBody RegisterRequest request) {
        try {
            userService.register(request);
            return Result.success("注册成功", null);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    /**
     * 企业注册
     */
    @PostMapping("/register/enterprise")
    public Result<Map<String, Object>> registerEnterprise(@RequestBody EnterpriseRegisterRequest request) {
        try {
            Map<String, Object> data = userService.registerEnterprise(request);
            return Result.success("企业注册成功", data);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    /**
     * 个人注册
     */
    @PostMapping("/register/personal")
    public Result<Map<String, Object>> registerPersonal(@RequestBody PersonalRegisterRequest request) {
        try {
            Map<String, Object> data = userService.registerPersonal(request);
            return Result.success("个人注册成功", data);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody LoginRequest request) {
        try {
            Map<String, Object> data = userService.login(request);
            return Result.success("登录成功", data);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @PostMapping("/fillInfo")
    public Result<Void> fillInfo(@RequestBody FillInfoRequest request) {
        try {
            userService.fillInfo(request);
            return Result.success("网格权益开通成功", null);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public Result<Map<String, Object>> getUserById(@PathVariable Long id) {
        Map<String, Object> data = userService.getUserDetailById(id);
        if (data != null) {
            return Result.success("Success", data);
        }
        return Result.error("用户不存在");
    }

    @PostMapping("/updateModal")
    public Result<Void> updateModal(@RequestBody UpdateModalRequest request) {
        try {
            userService.updateModal(request);
            return Result.success("资产确权绑定成功", null);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    // 重置密码
    @PostMapping("/resetPassword")
    public Result<Void> resetPassword(@RequestBody ResetPasswordRequest request) {
        try {
            userService.resetPassword(request);
            return Result.success("密码重置成功", null);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    // 获取用户的模态标识历史列表
    @GetMapping("/userModals/{userId}")
    public Result<List<UserModal>> getUserModals(@PathVariable Long userId) {
        try {
            List<UserModal> userModals = userService.getUserModals(userId);
            return Result.success("Success", userModals);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    // 获取模态标识统计信息（全局）
    @GetMapping("/modalStats")
    public Result<Map<String, Object>> getModalStats() {
        try {
            Map<String, Object> stats = userService.getModalStats();
            return Result.success("Success", stats);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    // 获取用户的模态标识统计信息（从用户双因子码查询）
    @GetMapping("/modalStats/{userId}")
    public Result<Map<String, Object>> getUserModalStats(@PathVariable Long userId) {
        try {
            Map<String, Object> stats = userService.getUserModalStats(userId);
            return Result.success("Success", stats);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    // 查询所有可用项目类型
    @GetMapping("/projects/available")
    public Result<List<Project>> getAvailableProjects() {
        try {
            List<Project> projects = userService.getAvailableProjects();
            return Result.success("Success", projects);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    // 生成模态标识码（雪花算法）
    @PostMapping("/modal/generate")
    public Result<Map<String, Object>> generateModalCode(@RequestBody Map<String, Object> params) {
        try {
            // 验证参数
            if (params.get("userId") == null || params.get("userId").toString().trim().isEmpty()) {
                return Result.error("用户ID不能为空");
            }
            
            if (params.get("projectType") == null || params.get("projectType").toString().trim().isEmpty()) {
                return Result.error("项目类型不能为空");
            }
            
            Long userId = Long.valueOf(params.get("userId").toString());
            String projectType = params.get("projectType").toString();
            
            String modalCode = userService.generateModalCode(userId, projectType);
            
            Map<String, Object> data = new HashMap<>();
            data.put("modalCode", modalCode);
            
            return Result.success("生成成功", data);
        } catch (NumberFormatException e) {
            return Result.error("用户ID格式错误");
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    // 模态标识绑定项目
    @PostMapping("/modal/bind")
    public Result<Void> bindModalToProject(@RequestBody ModalBindingRequest request) {
        try {
            userService.bindModalToProject(request);
            return Result.success("模态标识绑定成功", null);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
    
    // 查询用户的模态标识绑定记录
    @GetMapping("/modal/bindings/{userId}")
    public Result<List<Map<String, Object>>> getUserModalBindings(@PathVariable Long userId,
                                                                    @RequestParam(required = false) String projectType,
                                                                    @RequestParam(required = false) String startDate,
                                                                    @RequestParam(required = false) String endDate) {
        try {
            List<Map<String, Object>> bindings = userService.getUserModalBindings(userId, projectType, startDate, endDate);
            return Result.success("Success", bindings);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}