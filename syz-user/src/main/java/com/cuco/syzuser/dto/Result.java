package com.cuco.syzuser.dto;
import lombok.Data;

@Data
public class Result<T> {
    private Integer code; // 1: 成功, 0: 失败
    private String msg;
    private T data;

    public static <T> Result<T> success(String msg, T data) {
        Result<T> r = new Result<>();
        r.code = 1;
        r.msg = msg;
        r.data = data;
        return r;
    }

    // 重载一个只传data的
    public static <T> Result<T> success(T data) {
        return success("操作成功", data);
    }

    public static <T> Result<T> error(String msg) {
        Result<T> r = new Result<>();
        r.code = 0;
        r.msg = msg;
        return r;
    }
}