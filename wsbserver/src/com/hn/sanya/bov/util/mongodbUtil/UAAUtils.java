package com.hn.sanya.bov.util.mongodbUtil;

import com.hn.sanya.bov.controller.ItemController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import okhttp3.*;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Component
public class UAAUtils {

    private static final String UAA_TOKEN_URL = "http://199.224.20.214:8080/oauth/token";


    private static final String UAA_ONEUSER_URL = "http://199.224.20.214:8081/api/users/";
    private static final String UAA_ONEUSERVERIFY = "http://199.224.20.214:8081/api/account/realName/";
    private static final String UAA_MODIFYPHONE = "http://199.224.20.214:8081/api/account/resetPhone";
    private static final String UAA_CHANGEPWD = "http://199.224.20.214:8081/api/account/change-password";
    private static final String UAA_REGISTERUSER = "http://199.224.20.214:8081/api/outerRegister/finish";
    private static final String UAA_CERTIFICATION = "http://199.224.20.214:8081/api/account/realName";
    private static final String UAA_GETCODE = "http://199.224.20.214:8081/api/outerRegister/init";
    private static final String UAA_BINDCOMPANY = "http://199.224.20.214:8081/api/account/bindEnterprise";
    private static final String UAA_GETBINDCOMPANYINFO = "http://199.224.20.214:8081/api/account/bindEnterprise?login.equals=";
    private static final String UAA_COMPANYLICENSEPHOTO = "http://199.224.20.214:8081/api/account/bindEnterprise/";
    private static final String UAA_GETBINDCOMPANYINFOBYCODE = "http://199.224.20.214:8081/api/account/bindEnterprise?";



    //根据用户名密码获取token值
    public JSONObject getTokenJSON(String username, String password){
        JSONObject result = new JSONObject();
        JSONObject tokens = new JSONObject();
        RequestBody formBody = new FormBody.Builder()
                .add("grant_type", "password")
                .add("username",username)
                .add("password",password)
                .build();

        OkHttpClient client = new OkHttpClient.Builder().addInterceptor(new BasicAuthInterceptor(OAuth2Client.USER.getValue(),OAuth2Client.PASSWORD.getValue())).build();
        Request request = new Request.Builder()
                .url(UAA_TOKEN_URL)
                .post(formBody)//
//                .addHeader("Content-Type", "application/json")//
                .addHeader("Accept", "application/json")//
                .addHeader("Authorization","Basic dGVzdDoxMjM=")//
                .build();

        try {
            Response response = client.newCall(request).execute();
            int code = response.code();//获取返回状态码
            String responseBody = response.body().string();
            switch (code) {
                case 200 :
                    JSONObject json = JSONObject.fromObject(responseBody);
                    tokens.put("token",json.getString("access_token"));
                    tokens.put("refresh_token",json.getString("refresh_token"));
                    result.put("code","200");
                    result.put("tokens",tokens);
                    result.put("error","");
                    break;
                case 401 :
                    result.put("code","401");
                    result.put("error","获取token值时失败，401->未授权");
                    break;
                case 400 :
                    result.put("code","400");
                    result.put("error","获取token值时失败，400->参数错误");
                    break;
                case 500 :
                    result.put("code","500");
                    result.put("error","获取token值时失败，500->访问远程服务失败");
                    break;
                default :
                    break;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }



    //不根据用户名密码获取token值,用不了 {"error":"invalid_request","error_description":"Missing grant type"}
    public JSONObject getToken(){
        JSONObject result = null;
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost post = new HttpPost(UAA_TOKEN_URL);
        post.setHeader("Accept","application/json");
        post.setHeader("Authorization","Basic dGVzdDoxMjM=");
        post.setHeader("Content-Type","application/json; charset=utf-8");

        JSONObject data = new JSONObject();
        data.put("grant_type","client_credentials");
        StringEntity entity = new StringEntity(data.toString(),"UTF-8");
        post.setEntity(entity);
        try {
            HttpResponse response = client.execute(post);
            if (response.getStatusLine().getStatusCode() == 200) {
                String content = EntityUtils.toString(response.getEntity(),"UTF-8");
                result = JSONObject.fromObject(content);
            }
            if (response.getStatusLine().getStatusCode() == 400) {
                String content = EntityUtils.toString(response.getEntity(),"UTF-8");
                result = JSONObject.fromObject(content);
            }
            client.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

//使用用户名和token 获取信息
    public JSONObject getUserInfo(String username,String token){
        String url = UAA_ONEUSER_URL + username;
        return httpGet(url,token);
    }

    //用户修改手机号
    public boolean modifyPhone(String username,String phone,String token){
        String url = UAA_MODIFYPHONE;
        JSONObject data = new JSONObject();
        data.put("login",username);
        data.put("phone",phone);
        return put(url,token,data);
    }

    //用户修改密码
    public boolean changePassword(String username,String password,String token){
        JSONObject data = new JSONObject();
        data.put("login",username);
        data.put("password",password);
        return httpPOST(UAA_CHANGEPWD,token,data);
    }
    //获取用户认证信息
    public JSONObject getUserVerifiyInfo(String username,String token) {
        String url = UAA_ONEUSERVERIFY + username;
        return httpGet(url,token);
    }

    //获取短信验证码
    public void getCode(String phone){
        JSONObject data = new JSONObject();
        data.put("phone",phone);
        postCode(UAA_GETCODE,data);
    }

    //注册新用户 不需要用token的外部注册 ，用此
   public boolean registerNewUser(JSONObject user) {
        JSONArray authorities = new JSONArray();
        authorities.add("ROLE_USER");
        user.put("authorities",authorities);
        return postWithoutToken(UAA_REGISTERUSER,user);
   }

    //用户实名认证
    public boolean certificationUser(String access_token,JSONObject info,Map<String,File> files){
        return postWithFile(UAA_CERTIFICATION,access_token,info,files);
    }


    //获取实名认证身份证图片
    public byte[] getCertificationIDCardImage(String url,String token){
        return getImage(url,token);
    }

    //绑定公司信息
    public boolean bindCompany(JSONObject companyInfo,String token,File companyLicensePhoto){
        Map<String,File> map = new HashMap<>();
        map.put("businessLicenseFile",companyLicensePhoto);
        return postWithFile(UAA_BINDCOMPANY,token,companyInfo,map);
    }

    //获取用户全部的企业绑定信息
    public JSONObject getBindCompanyInfo(String username,String token){
        String url = UAA_GETBINDCOMPANYINFO + username;
        return httpGet(url,token);
    }

    //根据用户名，企业代码获取企业信息
    public JSONObject getBindCompanyInfoByCode(String username,String code,String token){
        String url = UAA_GETBINDCOMPANYINFOBYCODE + "login.equals=" + username + "&creditCode.equals="+code;
        return httpGet(url,token);
    }

    //判断指定用户名是否存在
    //返回null表示不存在,存在就返回数据
    public JSONObject checkUsernameIsExist(String username){
        JSONObject tokenJSON = getTokenJSON(AdminInfo.ADMINNAME,AdminInfo.ADMINPWD);
        if (!"200".equalsIgnoreCase(tokenJSON.getString("code"))){
            return null;
        }
        String token = tokenJSON.getJSONObject("tokens").getString("token");
        return getUserInfo(username,token);
    }

    //重置用户密码
    public void findPassword(String username,String password){
        JSONObject tokenJSON = getTokenJSON(AdminInfo.ADMINNAME,AdminInfo.ADMINPWD);
        String token = tokenJSON.getJSONObject("tokens").getString("token");
        changePassword(username,password,token);
    }

    //获取用户企业绑定的营业执照
    public byte[] getCompanyLicensePhoto(String url,String token){
        return getCompanyPhoto(url,token);
    }



//======================================================================================

    /**
     * get请求
     * @param url
     * @param access_token
     * @return
     */
    private JSONObject httpGet(String url,String access_token){
        //get请求返回结果
        JSONObject jsonResult = null;
        //设置token请求值
        String token="Bearer "+access_token;
        try {
            DefaultHttpClient client = new DefaultHttpClient();
            //发送get请求
            HttpGet request = new HttpGet(url);

            request.addHeader("Content-type","application/json; charset=utf-8");
            request.setHeader("Accept", "application/json");
            request.setHeader("Authorization", token);
            HttpResponse response = client.execute(request);
            /**请求发送成功，并得到响应**/
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                /**读取服务器返回过来的json字符串数据**/
                String strResult = EntityUtils.toString(response.getEntity());
                /**把json字符串转换成json对象**/
                if("".equals(strResult)){
                    jsonResult = null;
                }else {
                    jsonResult = JSONObject.fromObject(strResult);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return jsonResult;
    }

    /**
     * put提交
     * @param url
     * @param access_token
     * @param data
     * @return
     */
    private boolean put(String url,String access_token,JSONObject data){

        CloseableHttpClient client = HttpClients.createDefault();
        HttpPut put = new HttpPut(url);
        put.setHeader("Content-Type","application/json");
        String token="Bearer "+access_token;
        put.setHeader("Authorization",token);
        List<NameValuePair> list = new ArrayList<>();
        Set<String> keys = data.keySet();
        for (String key : keys) {
            list.add(new BasicNameValuePair(key,data.getString(key)));
        }
        try {
            StringEntity entity = new StringEntity(data.toString(),"UTF-8");
//            UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list,"UTF-8");
            put.setEntity(entity);
            HttpResponse response = client.execute(put);
            if (response.getStatusLine().getStatusCode() == 204) {
                return true;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * post提交
     * @param url
     * @param access_token
     * @param data
     * @return
     */
    private boolean httpPOST(String url,String access_token,JSONObject data){

        boolean flag = false;

        //设置token请求值
        String token = "Bearer "+access_token;

        HttpClient httpclient = HttpClientBuilder.create().build();
        HttpPost httpPost = new HttpPost(url);
        httpPost.addHeader("Content-Type","application/json;charset=utf-8");
        httpPost.setHeader("Accept", "application/json");
        httpPost.setHeader("Authorization",token);
        StringEntity entity = new StringEntity(data.toString(),"utf-8");//解决中文乱码问题
        try {
            httpPost.setEntity(entity);
            HttpResponse res =  httpclient.execute(httpPost);
            if (res.getStatusLine().getStatusCode() < 300) {//200
                /**读取服务器返回过来的json字符串数据**/
                String strResult = EntityUtils.toString(res.getEntity(), "UTF-8");
                flag = true;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 带文件提交post
     * @param url
     * @param access_token
     * @param info
     * @param files
     * @return
     */
    private boolean postWithFile(String url, String access_token, JSONObject info, Map<String,File> files){
        boolean flag = false;
        String token = "Bearer "+access_token;
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost post = new HttpPost(url);
        post.setHeader("Accept","application/json");
        post.setHeader("Authorization",token);
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        Set<String> stringKeys = info.keySet();
        try {
            for (String key : stringKeys) {
            builder.addTextBody(key,info.getString(key),ContentType.MULTIPART_FORM_DATA.withCharset("UTF-8"));
            }
        }catch (Exception e) {
            e.printStackTrace();
        }

        Set<String> fileKeys = files.keySet();
        for (String key : fileKeys) {
            builder.addBinaryBody(key, files.get(key));
        }
        HttpEntity entity = builder.build();
        post.setEntity(entity);
        try {
            HttpResponse response = client.execute(post);
            if (response.getStatusLine().getStatusCode() == 201) {
                flag = true;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                client.close();
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
        return flag;
    }

    /**
     *
     * @param url
     * @param data
     */
    private void postCode(String url,JSONObject data){
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost post = new HttpPost(url);
        post.setHeader("Content-Type","application/json");
        StringEntity entity = new StringEntity(data.toString(),"utf-8");
        post.setEntity(entity);
        try {
            client.execute(post);
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                client.close();
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 不同token进行提交post请求
     * @param url
     * @param user
     * @return
     */
    private boolean postWithoutToken(String url,JSONObject user){
        boolean flag = false;
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost post = new HttpPost(url);
        post.setHeader("Content-Type","application/json");
        StringEntity entity = new StringEntity(user.toString(),"utf-8");
        post.setEntity(entity);
        try {
            HttpResponse response = client.execute(post);
            if (response.getStatusLine().getStatusCode() == 200) {
                flag = true;
            }else{
                System.out.println(response.getStatusLine().getStatusCode());
            }
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                client.close();
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
        return flag;
    }

    /**
     * 获取图片
     * @param url
     * @param access_token
     * @return 流
     */
    private byte[] getImage(String url,String access_token){
        String token = "Bearer "+ access_token;
        CloseableHttpClient client = HttpClients.createDefault();
        HttpGet get = new HttpGet(url);
        get.setHeader("Authorization",token);
        try {
            HttpResponse response = client.execute(get);
            if (response.getStatusLine().getStatusCode() == 200) {
                byte[] image = EntityUtils.toByteArray(response.getEntity());
                return image;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            try {
                client.close();
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * 获取公司图片方法
     * @param url
     * @param access_token
     * @return 流
     */
    private byte[] getCompanyPhoto(String url,String access_token){
        byte[] photo = null;
        CloseableHttpClient client = HttpClients.createDefault();
        CloseableHttpResponse response = null;
        HttpGet get = new HttpGet(url);
        String token = "Bearer " + access_token;
        get.setHeader("Authorization",token);
        try {
            response = client.execute(get);
            if (response.getStatusLine().getStatusCode() == 200) {
                photo = EntityUtils.toByteArray(response.getEntity());
            }
        }catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (client != null) {
                try {
                    client.close();
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (response != null) {
                try {
                    response.close();
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return photo;
    }

    public static void main(String[] args) {
        UAAUtils uaaUtils = new UAAUtils();
        System.out.println(uaaUtils.getToken());
       /* String userName = "test2017";
        String password = "yuanshi";
        JSONObject jsonToken = new UAAUtils().getTokenJSON(userName,password);
        String access_token = jsonToken.getJSONObject("tokens").getString("token");
        JSONObject user  = uaaUtils.getUserVerifiyInfo(userName,access_token);
        uaaUtils.checkUsernameIsExist(userName);
        uaaUtils.getBindCompanyInfo(userName,access_token);
        uaaUtils.findPassword(userName,"");//重置密码
        System.out.println(user);*/

      /*  String url  = "https://www.baidu.com?code=CODE&name=NAME";

        String urlOne = url.replace("CODE","one");
        String urlTwo = url.replace("NAME","tom");
        String urlThree = urlOne.replace("NAME","tom");

        System.out.println("url:"+url);
        System.out.println("urlOne:"+urlOne);
        System.out.println("urlTwo:"+urlTwo);
        System.out.println("urlThree:"+urlThree);*/

      //  Exception in thread "main" net.sf.json.JSONException: Found starting '{' but missing '}' at the end. at character 0 of null
        String joStr = "{name:\"张三\",age:\"20\"";
        String first = "{";
        String last = "}";
        int i = joStr.indexOf("{");
        JSONObject jsonObject = null;
        if(i>joStr.indexOf("{")){
            System.out.println(first);
            jsonObject = JSONObject.fromObject(first);

        }else if(i>joStr.indexOf("}")) {
            joStr+=last;
            System.out.println(joStr);
             jsonObject = JSONObject.fromObject(joStr);
        }else{
            jsonObject = JSONObject.fromObject(joStr);
        }
        //将json字符串转化为JSONObject

        //通过getString("")分别取出里面的信息
        String name = jsonObject.getString("name");
        String age = jsonObject.getString("age");
        //输出  张三 20
        System.out.println(name+" "+age);


    }

}
