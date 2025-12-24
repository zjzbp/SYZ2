package com.cuco.syzuser.dto;

import lombok.Data;

@Data
public class ModalBindingRequest {
    private Long userId;           // 用户ID
    private String modalCode;      // 模态标识码（雪花算法生成）
    private String projectType;    // 项目类型
    private String projectName;    // 项目名称
    private Long byteSize;         // 字节码大小
    private String projectDesc;    // 项目描述
}
