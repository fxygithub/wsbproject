package com.hn.sanya.bov.util.exceptions;


import javax.servlet.http.HttpServletRequest;

public class ServletsController {
    /**
     * 是否是Ajax异步请求
     * @param request
     */
    public static boolean isAjaxRequest(HttpServletRequest request){

        String accept = request.getHeader("accept");
        String xRequestedWith = request.getHeader("X-Requested-With");

        // 如果是异步请求，则直接返回信息
        return ((accept != null && accept.indexOf("application/json") != -1 )
                || (xRequestedWith != null && xRequestedWith.indexOf("XMLHttpRequest") != -1));
    }

}