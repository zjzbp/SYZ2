package com.cuco.syzadmin.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

/**
 * MyBatis Plus 配置类
 */
@Configuration
@MapperScan("com.cuco.syzadmin.mapper")
public class MybatisPlusConfig {
    // MyBatis Plus 自动配置
}
