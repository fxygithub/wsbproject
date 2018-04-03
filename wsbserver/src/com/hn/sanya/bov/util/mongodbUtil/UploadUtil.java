package com.hn.sanya.bov.util.mongodbUtil;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.HttpVersion;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.params.ConnManagerParams;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.ContentBody;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.params.*;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


public class UploadUtil {

    private static final String CHARSET = HTTP.UTF_8;
    private static HttpClient customerHttpClient;
    private static final String TAG = "UploadUtil";
    //文件上传路径
    public static final String SERVER_UP = "http://199.224.253.5:8084/WebDiskServerDemo/upload";
    //文件下载查看路径
    public static final String SERVER_LOAD = "http://199.224.253.5:8084/WebDiskServerDemo/doc";
    private UploadUtil() {
    }


    /**
     * 初始化httpclient
     *
     * @return
     */
    private static synchronized HttpClient getHttpClient() {
        if (null == customerHttpClient) {
            HttpParams params = new BasicHttpParams();
            // 设置一些基本参数
            HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
            HttpProtocolParams.setContentCharset(params, CHARSET);
            HttpProtocolParams.setUseExpectContinue(params, true);
            HttpProtocolParams
                    .setUserAgent(
                            params,
                            "Mozilla/5.0(Linux;U;Android 2.2.1;en-us;Nexus One Build.FRG83) "
                                    + "AppleWebKit/553.1(KHTML,like Gecko) Version/4.0 Mobile Safari/533.1");
            // 超时设置
			/* 从连接池中取连接的超时时间 */
            ConnManagerParams.setTimeout(params, 10000);
			/* 连接超时 */
            HttpConnectionParams.setConnectionTimeout(params, 20000);
			/* 请求超时 */
            HttpConnectionParams.setSoTimeout(params, 20000);

            // 设置我们的HttpClient支持HTTP和HTTPS两种模式
            SchemeRegistry schReg = new SchemeRegistry();
            schReg.register(new Scheme("http", PlainSocketFactory
                    .getSocketFactory(), 80));
            schReg.register(new Scheme("https", SSLSocketFactory
                    .getSocketFactory(), 443));

            // 使用线程安全的连接管理来创建HttpClient
            ClientConnectionManager conMgr = new ThreadSafeClientConnManager(
                    params, schReg);
            customerHttpClient = new DefaultHttpClient(conMgr, params);
        }
        return customerHttpClient;
    }

    /**
     * httpclient+MultipartEntity方式上传
     *
     * @param    params
     * @param   fileURL_list
     * @param   urlServer
     * @return  返回null表示没有文件上传 成功返回String
     * @throws ClientProtocolException
     * @throws IOException
     */
    private static String post(final Map<String, String> params,
                              final ArrayList<String> fileURL_list, final String urlServer) {

        if (fileURL_list == null || fileURL_list.equals("")) {
            return null;
        }
        int list_size = fileURL_list.size();
        if (list_size<=0) {
            return null;
        }
        ExecutorService executorService =null;
        try {
            // 上传队列
            executorService = Executors.newFixedThreadPool(list_size);
            for ( int i = 0; i < list_size; i++) {
                final String fileUrl = fileURL_list.get(i);
                executorService.submit(new Runnable() {
                    public void run() {
                        String result = startUploadService(params,fileUrl,urlServer);
//						System.out.println(result);
//						sendMessage(NetThread.UPLOAD_FILES, DiskService.changeToObject(result), handler);
                    }
                });
            }
            executorService.shutdown();
        } catch (Exception e) {
            System.out.println("UploadUtils-->post:"+e.getMessage());
        }finally{

        }
        return "测试";
    }


    /**
     * 向服务器发送文件   单个文件上传 文件地址
     *
     * @param  params
     * @param file_url
     * @param server_url
     * @return
     */
    private static String startUploadService(Map<String, String> params,
                                            String file_url, String server_url) {
        try {
            // 开启上传队列
            File file = new File(file_url);
            HttpClient httpclient = new DefaultHttpClient();
            // 设置通信协议版本
            httpclient.getParams().setParameter(
                    CoreProtocolPNames.PROTOCOL_VERSION, HttpVersion.HTTP_1_1);
            // 文件参数设置
            HttpPost httppost = new HttpPost(server_url);
            MultipartEntity mpEntity = new MultipartEntity(
                    HttpMultipartMode.BROWSER_COMPATIBLE, null, Charset.forName(CHARSET));
            if (params != null && !params.isEmpty()) {
                // 编码参数
                for (String k : params.keySet()) {
                    StringBody valueBody = new StringBody(params.get(k),Charset.forName(CHARSET));
                    mpEntity.addPart(k, valueBody);
                }
            }
            ContentBody cbFile = new FileBody(file);
            mpEntity.addPart("file", cbFile);
            httppost.setEntity(mpEntity);
            HttpResponse response = httpclient.execute(httppost);
            HttpEntity resEntity = response.getEntity();

            if (response.getStatusLine().getStatusCode() != HttpStatus.SC_OK) {
                String sss = EntityUtils
                        .toString(response.getEntity(), CHARSET);
                // throw new RuntimeException("请求失败");
                return "{\"code\":\"4000\", \"msg\":\"URL请求失败\", \"result\":\'"
                        + response.getStatusLine().toString() + "\'}";
            }
            String result = (resEntity == null) ? null : EntityUtils.toString(resEntity,
                    CHARSET);
            return result;
        } catch (UnsupportedEncodingException e) {
            System.out.println( e.getMessage());
            return "{\"code\":\"4002\", \"msg\":\"URL请求失败\", \"result\":\'UnsupportedEncodingException:"
                    + e.getMessage() + "\'}";
        } catch (ClientProtocolException e) {
            System.out.println(e.getMessage());
            return "{\"code\":\"4003\", \"msg\":\"URL请求失败\", \"result\":\'ClientProtocolException:"
                    + e.getMessage() + "\'}";
        } catch (IOException e) {
            System.out.println(e.getMessage());
            return "{\"code\":\"4001\", \"msg\":\"URL请求失败\", \"result\":\'IOException:"
                    + e.getMessage() + "\'}";
        }
    }


    public static String up(Map<String, String> params,File file){
        return startUploadService(params,file,SERVER_UP);
    }

    public static byte[] load(Map<String, String> params) {//下载
        return getAsByteArray(SERVER_LOAD,params);
    }

//传文件
    private static String startUploadService(Map<String, String> params,
                                            File file, String server_url) {
        try {
            // 开启上传队列
            HttpClient httpclient = new DefaultHttpClient();
            // 设置通信协议版本
            httpclient.getParams().setParameter(
                    CoreProtocolPNames.PROTOCOL_VERSION, HttpVersion.HTTP_1_1);
            // 文件参数设置
            HttpPost httppost = new HttpPost(server_url);
            MultipartEntity mpEntity = new MultipartEntity(
                    HttpMultipartMode.BROWSER_COMPATIBLE, null, Charset.forName(CHARSET));
            if (params != null && !params.isEmpty()) {
                // 编码参数
                for (String k : params.keySet()) {
                    StringBody valueBody = new StringBody(params.get(k),Charset.forName(CHARSET));
                    mpEntity.addPart(k, valueBody);
                }
            }
            ContentBody cbFile = new FileBody(file);
            mpEntity.addPart("file", cbFile);
            httppost.setEntity(mpEntity);
            HttpResponse response = httpclient.execute(httppost);
            HttpEntity resEntity = response.getEntity();

            if (response.getStatusLine().getStatusCode() != HttpStatus.SC_OK) {
                String sss = EntityUtils
                        .toString(response.getEntity(), CHARSET);
                // throw new RuntimeException("请求失败");
                return "{\"code\":\"4000\", \"msg\":\"URL请求失败\", \"result\":\'"
                        + response.getStatusLine().toString() + "\'}";
            }
            String result = (resEntity == null) ? null : EntityUtils.toString(resEntity,
                    CHARSET);
            return result;
        } catch (UnsupportedEncodingException e) {
            System.out.println( e.getMessage());
            return "{\"code\":\"4002\", \"msg\":\"URL请求失败\", \"result\":\'UnsupportedEncodingException:"
                    + e.getMessage() + "\'}";
        } catch (ClientProtocolException e) {
            System.out.println(e.getMessage());
            return "{\"code\":\"4003\", \"msg\":\"URL请求失败\", \"result\":\'ClientProtocolException:"
                    + e.getMessage() + "\'}";
        } catch (IOException e) {
            System.out.println(e.getMessage());
            return "{\"code\":\"4001\", \"msg\":\"URL请求失败\", \"result\":\'IOException:"
                    + e.getMessage() + "\'}";
        }
    }


    public static byte[] getAsByteArray(String url) {
        return getAsByteArray(url,null);
    }

    public static byte[] getAsByteArray(String urlPath,Map<String,String> params){
        CloseableHttpClient httpclient = null;
        CloseableHttpResponse httpResponse = null;
        byte[] data = null;
        try {
            httpclient = HttpClients.createDefault();
            URIBuilder builder = new URIBuilder(urlPath);
            if (null != params){
                for (String key : params.keySet()) {
                    builder.setParameter(key,params.get(key));
                }
            }
            URI uri = builder.build();
            HttpGet httpGet = new HttpGet(uri);
            httpResponse = httpclient.execute(httpGet);
            if (httpResponse.getStatusLine().getStatusCode() == 200) {
                HttpEntity entity = httpResponse.getEntity();
                data = EntityUtils.toByteArray(entity);
            }
        }catch (Exception e) {
            System.out.println("==========请求失败========");
            e.printStackTrace();
        }finally {
            if (httpResponse != null)
                try {
                    httpResponse.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            if (httpclient != null)
                try {
                    httpclient.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
        return data;
    }



    public static void main(String[] args) throws Exception{



//        //3336
     /*  Map<String,String> params = new HashMap<String,String>();
       params.put("uid", "73");//用户Id
       params.put("type", "doc");//不变
       params.put("folder_name", "//");//不变

       String scc = UploadUtil.up(params,new File("C:\\Users\\Administrator\\Pictures\\Camera Roll\\mt4.jpg"));//保证文件名唯一
       String file_url = "C:\\Users\\Administrator\\Pictures\\Camera Roll\\mt3.jpg";
        String server_url = "http://199.224.253.11:8083/WebDiskServerDemo/upload";
        String scc = UploadUtil.startUploadService(params, file_url, server_url);
        System.out.println(scc);*/

//        params.put("type","thumbnail");
    }
}

//上传成功返回的数据
//{"msg":"OK","code":"0000","docid":2476,"uuid":"28710297-bfa0-11e7-847e-00ffc9760158"}
//{"msg":"OK","code":"0000","docid":2477,"uuid":"29017b4e-bfa6-11e7-847e-00ffc9760158"}
//{"msg":"OK","code":"0000","docid":2478,"uuid":"f0daaff3-c035-11e7-b44d-00ffc9760158"}
//{"msg":"OK","code":"0000","docid":2481,"uuid":"5ce1d8b0-c046-11e7-b44d-00ffc9760158"}
