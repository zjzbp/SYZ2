package com.cuco.syzadmin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cuco.syzadmin.common.Result;
import com.cuco.syzadmin.dto.LoginRequest;
import com.cuco.syzadmin.dto.LoginResponse;
import com.cuco.syzadmin.dto.UserFullDetailDTO;
import com.cuco.syzadmin.entity.Enterprise;
import com.cuco.syzadmin.entity.Personal;
import com.cuco.syzadmin.entity.User;
import com.cuco.syzadmin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户控制器
 */
@RestController
@RequestMapping("/api/user")
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
    
    /**
     * 分页查询用户列表
     * @param userType 用户类型 (PERSONAL/ENTERPRISE)
     * @param phone 手机号
     * @param currentPage 当前页
     * @param pageSize 每页大小
     * @return 用户分页数据
     */
    @GetMapping("/list")
    public Result<IPage<User>> getUserList(
            @RequestParam(required = false) String userType,
            @RequestParam(required = false) String phone,
            @RequestParam(defaultValue = "1") Integer currentPage,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        try {
            IPage<User> pageResult = userService.getUserList(userType, phone, currentPage, pageSize);
            return Result.success("查询成功", pageResult);
        } catch (Exception e) {
            return Result.error("查询失败: " + e.getMessage());
        }
    }
    
    /**
     * 根据用户ID查询个人详情
     * @param userId 用户ID
     * @return 个人详情
     */
    @GetMapping("/personal/{userId}")
    public Result<Personal> getPersonalDetail(@PathVariable Long userId) {
        try {
            Personal personal = userService.getPersonalDetail(userId);
            if (personal != null) {
                return Result.success("查询成功", personal);
            } else {
                return Result.error("个人详情不存在");
            }
        } catch (Exception e) {
            return Result.error("查询失败: " + e.getMessage());
        }
    }
    
    /**
     * 根据用户ID查询企业详情
     * @param userId 用户ID
     * @return 企业详情
     */
    @GetMapping("/enterprise/{userId}")
    public Result<Enterprise> getEnterpriseDetail(@PathVariable Long userId) {
        try {
            Enterprise enterprise = userService.getEnterpriseDetail(userId);
            if (enterprise != null) {
                return Result.success("查询成功", enterprise);
            } else {
                return Result.error("企业详情不存在");
            }
        } catch (Exception e) {
            return Result.error("查询失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取用户完整详情（包含所有关联数据、项目类别统计和分数）
     * @param userId 用户ID
     * @return 用户完整详情
     */
    @GetMapping("/detail/{userId}")
    public Result<UserFullDetailDTO> getUserFullDetail(@PathVariable Long userId) {
        try {
            UserFullDetailDTO detail = userService.getUserFullDetail(userId);
            if (detail != null) {
                return Result.success("查询成功", detail);
            } else {
                return Result.error("用户不存在");
            }
        } catch (Exception e) {
            return Result.error("查询失败: " + e.getMessage());
        }
    }
    
    /**
     * 根据ID查询用户
     * @param id 用户ID
     * @return 用户信息
     */
    @GetMapping("/{id}")
    public Result<User> getUserById(@PathVariable Long id) {
        try {
            User user = userService.getUserById(id);
            if (user != null) {
                user.setPassword(null); // 隐藏密码
                return Result.success("查询成功", user);
            } else {
                return Result.error("用户不存在");
            }
        } catch (Exception e) {
            return Result.error("查询失败: " + e.getMessage());
        }
    }
    
    /**
     * 新增用户
     * @param user 用户信息
     * @return 操作结果
     */
    @PostMapping("/add")
    public Result<Void> addUser(@RequestBody User user) {
        try {
            int result = userService.addUser(user);
            if (result > 0) {
                return Result.success("新增成功", null);
            } else {
                return Result.error("新增失败");
            }
        } catch (Exception e) {
            return Result.error("新增失败: " + e.getMessage());
        }
    }
    
    /**
     * 更新用户
     * @param user 用户信息
     * @return 操作结果
     */
    @PutMapping("/update")
    public Result<Void> updateUser(@RequestBody User user) {
        try {
            int result = userService.updateUser(user);
            if (result > 0) {
                return Result.success("更新成功", null);
            } else {
                return Result.error("更新失败");
            }
        } catch (Exception e) {
            return Result.error("更新失败: " + e.getMessage());
        }
    }
    
    /**
     * 删除用户
     * @param id 用户ID
     * @return 操作结果
     */
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteUser(@PathVariable Long id) {
        try {
            int result = userService.deleteUser(id);
            if (result > 0) {
                return Result.success("删除成功", null);
            } else {
                return Result.error("删除失败");
            }
        } catch (Exception e) {
            return Result.error("删除失败: " + e.getMessage());
        }
    }
    
    /**
     * 批量删除用户
     * @param ids 用户ID列表
     * @return 操作结果
     */
    @DeleteMapping("/delete/batch")
    public Result<Void> deleteUsers(@RequestBody List<Long> ids) {
        try {
            int result = userService.deleteUsers(ids);
            if (result > 0) {
                return Result.success("批量删除成功", null);
            } else {
                return Result.error("批量删除失败");
            }
        } catch (Exception e) {
            return Result.error("批量删除失败: " + e.getMessage());
        }
    }
}