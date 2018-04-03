package com.hn.sanya.bov.Interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckInterceptor implements HandlerInterceptor {
	private static final Logger logger = LoggerFactory.getLogger(CheckInterceptor.class);
	@Override
	public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
		try{
			 httpServletRequest.getSession().getAttribute("userName").toString();//这里检查是不是已经username
			 return true;

		}catch (NullPointerException e){
			logger.error("还没检查到用户，先去注册！！！！");
		}

		return false;
	}

	@Override
	public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

	}
}
