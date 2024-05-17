package com.mrChill.Relax.Dao;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResponseDAO {
    int code;// 1: thành công, 2: thất bại
    String message;
    Object data;

    public ResponseDAO(int code, String message) {
        this.code = code;
        this.message = message;
    }
}
