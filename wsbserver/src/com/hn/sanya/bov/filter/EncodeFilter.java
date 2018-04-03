package com.hn.sanya.bov.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EncodeFilter implements Filter {

    public void destroy() {

    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        request.setCharacterEncoding("utf-8");
        String methodPOrG = request.getMethod();//方法POST还是GET
        if("GET".equalsIgnoreCase(methodPOrG)){
            EncodingRequest er = new EncodingRequest(request);//实例化，就会用到装饰类，
            filterChain.doFilter(er, response);
        }else if("POST".equalsIgnoreCase(methodPOrG)){
            filterChain.doFilter(request, response);
        }
    }

    public void init(FilterConfig arg0) throws ServletException {
    }

}
