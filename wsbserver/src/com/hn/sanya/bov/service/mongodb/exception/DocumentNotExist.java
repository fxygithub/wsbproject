package com.hn.sanya.bov.service.mongodb.exception;

/**
 * 文档不存在异常
 */
public class DocumentNotExist extends RuntimeException {
    public DocumentNotExist(String message){
        super(message);
    }
}
