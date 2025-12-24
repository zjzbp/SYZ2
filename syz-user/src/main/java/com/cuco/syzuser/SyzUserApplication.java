package com.cuco.syzuser;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.cuco.syzuser.mapper")
public class SyzUserApplication {

    public static void main(String[] args) {
        SpringApplication.run(SyzUserApplication.class, args);
    }

}
