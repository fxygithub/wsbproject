package com.hn.sanya.bov.util.exceptions;

import org.apache.commons.lang.StringEscapeUtils;

public class ExceptinsUtil {
    /**
     * 替换为手机识别的HTML，去掉样式及属性，保留回车。
     * @param txt
     * @return
     */
    public static String toHtml(String txt){
        if (txt == null){
            return "";
        }
        return org.apache.commons.lang.StringUtils.replace(
                org.apache.commons.lang.StringUtils.replace(StringEscapeUtils.escapeHtml(txt), "\n", "<br/>"),
                "\t", "&nbsp; &nbsp; ");
    }
}