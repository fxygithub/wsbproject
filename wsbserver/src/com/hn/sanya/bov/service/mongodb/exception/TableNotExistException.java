package com.hn.sanya.bov.service.mongodb.exception;

/**
 * 表不存在异常
 */
public class TableNotExistException extends RuntimeException{
    public TableNotExistException(String message){
        super(message);
    }
}
