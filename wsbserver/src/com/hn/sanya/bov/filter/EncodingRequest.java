package com.hn.sanya.bov.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.UnsupportedEncodingException;

/**
 * 辅助过滤器来处理GET编码问题
 * 继承HttpServletRequestWrapper(被装饰的类/接口)并且覆盖你希望改变的方法
 * 1、有一个呗装饰的类是属性
 * 2、有一个构成函数（传入父类构造函数的参数）
 * 3、重写方法（）
 *
 */
public class EncodingRequest extends HttpServletRequestWrapper {
    private static final Logger logger = LoggerFactory.getLogger(EncodingRequest.class);
    private HttpServletRequest request;
    public EncodingRequest(HttpServletRequest request) {
        super(request);
        this.request=request;
    }

    /**
     * 处理编码问题
     * @param name 参数的name属性名
     * 实例化这个类就会调用这个方法
     *  当没有参数的时候回出现空指针异常
     */
    public String getParameter(String name){
        String value = null;
        try{
             value = request.getParameter(name);//这里是方法名fun2，不应该呀，应该是参数
            // 处理编码问题
            try {
                // value = new String (value.getBytes("ISO-8859-1"),"utf-8");
                //并去掉所有空格
                value = new String (value.getBytes("ISO-8859-1"),"utf-8").replace(" ","");

                //去掉首尾空格
                //value = new String (value.getBytes("ISO-8859-1"),"utf-8").trim();

            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException(e);
            }
        }catch (NullPointerException e){
            logger.error("获取请求参数出现空指针异常"+e.getMessage());
        }

        return value;//返回方法名，这里是fun2()
    }


}
