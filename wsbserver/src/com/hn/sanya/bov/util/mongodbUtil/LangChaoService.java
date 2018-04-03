package com.hn.sanya.bov.util.mongodbUtil;

import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

import java.io.DataOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class LangChaoService {
    private LangChaoService(){}

    private static final String lcurl = "http://199.224.253.5:8087/Service/";
    private static final Logger logger = Logger.getLogger(LangChaoService.class);

    //根据事项编码获取表单信息
    //返回json格式字符串
    public static String getFormInfo(String itemCode){
        String urlPath = lcurl + "getFormInfo?itemCode="+itemCode;
        return methodGet(urlPath);
    }

    //根据formId获取表单
    //返回html格式字符串
    public static String getFormUI(String formId) {
        //http://199.224.253.11:8081/cform/getFormUI?formId=ShiShouLiBiaoDan
        String urlPath = "http://199.224.253.5:8081/cform/getFormUI?formId="+formId;
        return methodGet(urlPath);
    }


    //保存表单数据
    public static String saveData(String formId,String formData){
        String urlPath = lcurl + "saveDataEx";
        Map<String,String> map = new HashMap<>();
        map.put("formId",formId);
        map.put("formData",formData);
        return methodPost(urlPath,map);
    }

    //网上申报
    //网上申报事项 返回申办编号
    public static String webApply(String postdata) {
        String urlPath = lcurl + "webApply";
        Map<String,String> map = new HashMap<>();
        map.put("postdata",postdata);
        return methodPost(urlPath,map);
    }

    //获取业务办理信息
    //根据申办编号 获取办理信息
    public static String getBusinessInfo(String receiveNumber) {
        String urlPath = lcurl + "getBusinessInfo?receiveNumber="+receiveNumber;
        return methodGet(urlPath);
    }

//    public static String getItemInfoByItemCode(String itemCode){
//        String urlPaht = "http://199.224.253.5:8087/main/power/getItemInfoByItemCode?" +
//                "itemCode="+itemCode+"&type=material";
//        //+"&type=material"
//        return methodGet(urlPaht);
//    }
    public static JSONObject getEInfo(String itemCode, String eid){
        String urlPath = "http://199.224.20.101:8079/einfo";
        Map<String,String> params = new HashMap<>();
        params.put("item_id",itemCode);
        params.put("eid",eid);
        String info = methodPost(urlPath,params);
        return JSONObject.fromObject(info);
    }
    public static void main(String[] args){
    /*  String str = getItemInfoByItemCode("46020000YG-XK-0102");
      System.out.println(str);*/
       //String info = getBusinessInfo("46020000YG-XK-01021803240002");
     //  System.out.println(getFormUI("ShiShiYaoJianJu_ShiPinJingYing"));
        System.out.println(saveData("ShiShiYaoJianJu_ShiPinJingYing","test"));
    }

    private static String methodPost(String urlPaht , Map<String,String> map){
        DataOutputStream out = null;
        InputStream in = null;
        HttpURLConnection conn = null;
        //拼接参数
        try {
            StringBuffer sb = new StringBuffer();
            Iterator it = map.keySet().iterator();
            while (it.hasNext()) {
                String key = (String) it.next();
                sb.append(key+"="+ URLEncoder.encode(map.get(key),"utf-8") + "&");
            }
            //处理最后一个&
            int index = sb.toString().lastIndexOf("&");
            String param = sb.toString().substring(0,index);
            URL url = new URL(urlPaht);
            conn = (HttpURLConnection) url.openConnection();
            //发送post请求必须设置
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setRequestMethod("POST");//设置提交模式
            conn.setUseCaches(false);
            conn.setInstanceFollowRedirects(true);
            conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
            conn.connect();
            out = new DataOutputStream(conn.getOutputStream());
            out.writeBytes(param);
            //开始获取数据
            in = conn.getInputStream();
            byte[] b = new byte[in.available()];
            in.read(b);
            String str = new String(b,"utf-8");
            return str;
        }catch (Exception  e) {
            logger.debug("============="+e.getMessage()+"============");
            System.out.println("连接失败");
        }finally {
            if (null != in)
                try {
                    in.close();
                }catch (Exception e) {
                    logger.debug("====关闭输入流失败======");
                }
            if (null != out) {
                try {
                    out.close();
                }catch (Exception e) {
                    logger.debug("====关闭输出流失败======");
                }
            }
        }
        return "";
    }

    private static String methodGet(String urlPath){
        InputStream in = null;
        try {
            URL url = new URL(urlPath);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
            in = conn.getInputStream();
            byte[] b = new byte[in.available()];
            in.read(b);
            in.close();
            return new String(b);
        }catch (Exception e) {
            System.out.println("连接失败！！");
        }finally {
            if (null != in) {
                try {
                    in.close();
                }catch (Exception e) {
                    logger.debug("====关闭输入流失败======");
                }
            }
        }
        return null;
    }

}
