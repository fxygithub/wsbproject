package com.hn.sanya.bov.util.mongodbUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;

@Service("lcService")
public class LCService {
    private static CloseableHttpClient httpClient;
    private static final String lcurl = "http://199.224.253.5:8085/";
    private static final String lcurl_ = "http://199.224.253.5:8087/Service/";
    private LCService(){}

    //1.保存表单数据
    public static String saveData(String formId,String formData){
        String urlPath = lcurl_ + "saveDataEx";
        Map<String,String> map = new HashMap<String,String>();
        map.put("formId",formId);
        map.put("formData",formData);
        return post(urlPath,map);
    }
    //2.网上申报
    //网上申报事项 返回申办编号 serviceNum
    public static String webApply(String postdata) {
        String urlPath = lcurl_ + "webApply";
        Map<String,String> map = new HashMap<String,String>();
        map.put("postdata",postdata);
        return post(urlPath,map);
    }
    //3.拿材料信息
    public static String getItemInfoByItemCode(String itemCode){
        String urlPaht = lcurl+"main/power/getItemInfoByItemCode";
        Map<String,String> params = new HashMap<String,String>();
        params.put("itemCode",itemCode);
        params.put("type","material");
        return get(urlPaht,params);
    }
    //4.获取要事项的材料信息
    public static JSONArray getItemInfoByItemCodeJSONArray(String itemCode){
        String itemInfo = getItemInfoByItemCode(itemCode);
        if ("".equals(itemInfo)) {
            return null;
        }
        JSONObject json = JSONObject.fromObject(itemInfo);
        if ("1".equals(json.getString("state"))){
            JSONArray array = json.getJSONArray("ItemInfo");
            return array;
        }
        return null;
    }
//5.拿状态信息
    public static JSONArray getBusinessInfoJSONArray(String receiveNum){
        String urlPaht = lcurl_+"getBusinessInfo";
        Map<String,String> params = new HashMap<String,String>();
        params.put("receiveNumber",receiveNum);
        String info = get(urlPaht,params);
        if ("".equals(info))
            return null;
        JSONObject obj = JSONObject.fromObject(info);
        return obj.getJSONArray("info");
    }

    //6.根据事项编码获取表单信息（暂时没有用到，数据写死到本地库）
    //返回json格式字符串
    public static String getFormInfo(String itemCode){
        String urlPath = lcurl + "getFormInfo";
        Map<String,String> param = new HashMap();
        param.put("itemCode",itemCode);
        return get(urlPath,param);
    }
    //7.根据formId获取表单（暂时没有用到）
    //返回html格式字符串
    public static String getFormUI(String formId) {
        //只有这个能获取 ：http://199.224.253.11:8081/cform/getFormUI?formId=ShiShouLiBiaoDan
        String urlPath = "http://199.224.253.5:8087/cform/getFormUI";
        Map<String, String> param = new HashMap();
        param.put("formId", formId);
        return get(urlPath, param);
    }
    //8.获取业务办理信息
    //根据申办编号 获取办理信息
    public static String getBusinessInfo(String receiveNumber) {
        String urlPath = lcurl + "getBusinessInfo";
        Map<String, String> param = new HashMap();
        param.put("receiveNumber", receiveNumber);
        return get(urlPath, param);
    }
    //9.编码，社会信用代码
    public static JSONObject getEInfo(String itemCode, String eid){
        String urlPath = "http://199.224.20.101:8079/einfo";
        Map<String,String> params = new HashMap<String,String>();
        params.put("item_id",itemCode);
        params.put("eid",eid);
        String info = post(urlPath,params);
        return JSONObject.fromObject(info);
    }
    /**
     *
     * @param url
     * @param params
     * @return 成功：String，失败：null
     */
    private static String get(String url , Map<String,String> params){
        String content = null;
        CloseableHttpClient httpClient = null;
        HttpGet httpGet = null;
        URIBuilder builder = null;
        CloseableHttpResponse response = null;
        try {
            httpClient = getCloseableHttpClient();
            //封装请求参数
            builder = new URIBuilder(url);
            for (String key : params.keySet()) {
                builder.setParameter(key,params.get(key));
            }
            httpGet = new HttpGet(builder.build());
            RequestConfig config = RequestConfig.custom()//
                    .setConnectTimeout(5000)//
                    .setConnectionRequestTimeout(5000)//
                    .setSocketTimeout(5000)//
                    .build();
            httpGet.setConfig(config);
            response = httpClient.execute(httpGet);
            if (response.getStatusLine().getStatusCode() == 200) {//请求成功
                HttpEntity entity = response.getEntity();
                content = EntityUtils.toString(entity,"utf-8");
            }
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (response != null)
                try {
                    response.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            if (httpClient != null)
                try {
                    httpClient.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
        return content;

    }

    private static CloseableHttpClient getCloseableHttpClient(){
        if (null == httpClient)
            return HttpClients.createDefault();
        return httpClient;
    }
    /**
     *
     * @param url
     * @param map
     * @return 成功：String，失败：null
     */
    private static String post(String url,Map<String,String> map){
        CloseableHttpClient httpClient = null;
        HttpPost httpPost = null;
        CloseableHttpResponse response = null;
        String content = null;
        try{
            httpClient = getCloseableHttpClient();
            httpPost = new HttpPost(url);
            //封装参数
            httpPost.addHeader("Content-type","application/json; charset=utf-8");
            httpPost.setHeader("Accept", "application/json");
            List<NameValuePair> list = new ArrayList<NameValuePair>();
            Set<String> keys = map.keySet();
            for (String key : keys) {
                list.add(new BasicNameValuePair(key,map.get(key)));
            }
            if(list.size() > 0){
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list,"UTF-8");
                httpPost.setEntity(entity);
            }
            response = httpClient.execute(httpPost);
            if (response.getStatusLine().getStatusCode() == 200) {
                content = EntityUtils.toString(response.getEntity(),"utf-8");
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    public static void main(String[] args) {
        System.out.println(getItemInfoByItemCode("46020000SY-XK-0703"));
    }
}
