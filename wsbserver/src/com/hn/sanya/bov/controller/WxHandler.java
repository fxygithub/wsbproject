package com.hn.sanya.bov.controller;

import com.hn.sanya.bov.wchat.util.HttpHelper;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller()
@RequestMapping("weixin")
public class WxHandler {
	//总入口 CheckUrlServlet=》回调url/weixin/oauth.html
	private static final  String APPID ="wxb413f2b9aab82300";
	private static final String SECRECT="7bb289bd8c9e5bc76db1c8000c52fd4b";

	@RequestMapping("oauth")
   public String oauth(HttpServletRequest request){
		String code = request.getParameter("code");//我们要的code
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
		String url1 = url.replace("CODE",code);
		String url2 = url1.replace("APPID",APPID);
		String url3 =  url2.replace("SECRET",SECRECT);//到这里把三个参数都换上值

		JSONObject json = HttpHelper.httpsRequest(url3,"GET",null);
		System.out.println("json:"+json);
		try{
			String access_token = json.getString("access_token");
			String openId = json.getString("openid");
			request.getSession().setAttribute("openId",openId);
			System.out.println("openid:"+openId);
			return "redirect:/user/checkUser.html";
		}catch (NullPointerException e){
			System.out.println("拿不到微信用户授权令牌");
		}catch (JSONException e){
			System.out.println("json异常");
		}
		return null;
	}
	/**正确的返回接口json:
	{"access_token":"7_6GijbA72lJ9e6IwpcqIdHjoZa_t-dTm9VRjxhSiSj1_lceHdArG0SqIp30lpVq4pXagVzZGJfW4szRNIqHonrskrUKzNlFYanCL5_WivdYA","expires_in":7200,"refresh_token":"7_lXf9a2wf0rnTLhMSJqHy1lQjR8P9kMkKGiqwkxxSCghPC_PlSDS5YjK_WkyideqHcEuZInZNKrvqZLqKANKhFshmkWWmo4ta0BXyCBI348g","openid":"o52aew7ajl8-MHQHk_B0gxFmPmVo","scope":"snsapi_base"}
	 */
}
