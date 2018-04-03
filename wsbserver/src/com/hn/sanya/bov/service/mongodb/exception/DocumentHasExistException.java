package com.hn.sanya.bov.service.mongodb.exception;

/**
 * 文档已存在异常
 */
public class DocumentHasExistException extends RuntimeException {
    public DocumentHasExistException(String message){
        super(message);
    }
}
