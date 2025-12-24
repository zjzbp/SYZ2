package com.cuco.syzuser.entity;
import lombok.Data;
import java.util.Date;

@Data
public class UserModal {
    private Long id;            // 主键
    private Long userId;        // 用户ID
    private Integer modalId;    // 模态标识（0-99999999）
    private Date createTime;    // 创建时间
}
