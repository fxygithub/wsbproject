package com.hn.sanya.bov.util.mongodbUtil;

public class ViewUtils {
    //返回十个页面的地址String
    public static String getView(String view,String code){
            if ("46020000YG-FW-0101".equals(code)){//1
                view+="46020000YG-FW-0101.jsp";
            }
            if ("46020000YG-FW-0102".equals(code)){//2
                view+="46020000YG-FW-0102.jsp";
            }
            if ("46020000YG-FW-0103".equals(code)){//3
                view+="46020000YG-FW-0103.jsp";
            }
            if ("46020000YG-FW-0104".equals(code)){//4
                view+="46020000YG-FW-0104.jsp";
            }
            if ("46020000YG-XK-0101".equals(code)){//5
                view+="46020000YG-XK-0101.jsp";
            }
            if ("46020000YG-XK-0102".equals(code)){//6
                view+="46020000YG-XK-0102.jsp";
            }
            if ("46020000YG-XK-0103".equals(code)){//7
                view+="46020000YG-XK-0103.jsp";
            }
            if ("46020000ZF-XK-0402".equals(code)){//8
                view+="46020000ZF-XK-0402.jsp";
            }
            if ("46020000ZF-XK-0501".equals(code)){//9
                view+="46020000ZF-XK-0501.jsp";
            }
            if ("46020000SY-XK-0703".equals(code)){
                view+="46020000SY-XK-0703.jsp";
            }
        return view;
    }

}
