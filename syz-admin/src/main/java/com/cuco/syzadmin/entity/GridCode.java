package com.cuco.syzadmin.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 网格码实体类
 */
@Data
@TableName("biz_grid_code")
public class GridCode {

    @TableId(type = IdType.AUTO)
    private Long gridCodeId;

    @TableField("grid_code_value")
    private String gridCodeValue; // 网格码唯一值

    @TableField("user_id")
    private Long userId; // 用户ID

    @TableField("status")
    private String status; // 状态：VALID-有效、INVALID-失效

    @TableField("hash_value")
    private String hashValue; // 区块链存证哈希值

    @TableField("deposit_record_id")
    private String depositRecordId; // 区块钾存证记录ID

    @TableField("create_time")
    private String createTime; // 创建时间
}