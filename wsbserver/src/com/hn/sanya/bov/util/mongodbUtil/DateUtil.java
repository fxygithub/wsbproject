package com.hn.sanya.bov.util.mongodbUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    private static final Logger logger= LoggerFactory.getLogger(DateUtil.class);
    private static SimpleDateFormat simpleDateFormat=new SimpleDateFormat();

    //变成yyyy-MM-dd 如：2017-11-30 方法的后面3 表示年月日，三个内容
    public  static String DateBianString3(Date date){
        String pattern=null;
        String dateStr="";
        if(date!=null){
            pattern="yyyy-MM-dd";
            simpleDateFormat.applyPattern(pattern);
            dateStr=simpleDateFormat.format(date);
            logger.info("时间转换成功！");
        }else{
            logger.info("当前时间不能为空，显示：0000-00-00表示当前传入空值！ ");
            dateStr="0000-00-00";
        }
       return dateStr;
    }

    //变成yyyy-MM-dd hh:mm:ss 年月日时分秒
    public static String DateBianString6(Date date){
        String pattern=null;
        String dateStr="";
        if(date!=null){
            pattern="yyyy-MM-dd hh:mm:ss";
            simpleDateFormat.applyPattern(pattern);
            dateStr=simpleDateFormat.format(date);
            logger.info("时间转换成功！");
        }else{
            logger.info("当前时间不能为空，显示：0000-00-00表示当前传入空值！ ");
            dateStr="0000-00-00 00:00:00";
        }
        return dateStr;
}


public static void main(String args[]){
    Date date = new Date();
    System.out.println(DateBianString3(date));
    System.out.println(DateBianString3(null));

    System.out.println(DateBianString6(date));
    System.out.println(DateBianString6(null));

}
}
