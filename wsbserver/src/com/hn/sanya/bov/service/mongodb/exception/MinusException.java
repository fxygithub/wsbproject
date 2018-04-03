package com.hn.sanya.bov.service.mongodb.exception;

/**
 * 页码为负数异常
 */
public class MinusException extends RuntimeException {
    public MinusException (String message){
        super(message);
    }
}
