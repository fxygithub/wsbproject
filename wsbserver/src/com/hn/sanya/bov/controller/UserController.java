package com.hn.sanya.bov.controller;

import com.hn.sanya.bov.service.mongodb.service.UserService;
import com.hn.sanya.bov.util.mongodbUtil.UAAUtils;
import net.sf.json.JSONObject;
import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
	private static final Logger logger  = LoggerFactory.getLogger(UserController.class);
	private static final String USER_INFO ="user_info";//用户部分信息

    @Autowired
	private UAAUtils uaaUtils ;

	@Autowired
	private UserService userService ;

	/**
	 * 用户扫码进入-》根据唯一标志查询用户-》如何没查到用户-》注册页面
	 */

    private static final String uniqueFlag= "openId";//用户唯一标志字段

	private  String openId="201803271142";

	@RequestMapping("checkUser")
	public String checkUser(HttpServletRequest request){
		String openIdParam = null;
		try{
		    openIdParam = request.getSession().getAttribute("openId").toString();
		}catch (NullPointerException e){
			logger.error("session中拿不到openId,使用了openId的默认值,\n异常消息为："+e);
			openIdParam=openId;
		}
		request.getSession().setAttribute(uniqueFlag,openIdParam);//这里把userId和openId设置为相同值
		request.getSession().setAttribute("userId",openIdParam);

		Document document = userService.findUserByQuery(new Query().addCriteria(Criteria.where(uniqueFlag).is(openIdParam)),USER_INFO);
		if(document!=null){
			String userName = document.getString("userName");
			request.getSession().setAttribute("userName",userName);

			if("0".equals(document.getString("status"))) {//还没有实名认证就跳到实名认证页面
				return "jsp/user/register1.jsp";
			}
			if("0".equals(document.getString("bindCompanyFlag"))){
				return "jsp/user/register2.jsp";
			}else {
				request.getSession().setAttribute("userId",document.getString("userId"));//
				return "redirect:/item/index.html";}
		}else {
			logger.error("checkUser()方法里，根据openId查不到相对应的用户,为用户跳到注册页面\n");
		}
		return "jsp/user/register.jsp";
	}

	//注册
	@RequestMapping("register")
	public String register(HttpServletRequest request){
		logger.info("=========用户注册==============");
		String openId = request.getSession().getAttribute(uniqueFlag).toString();

		String userName = request.getParameter("username").toString();
		String phone = request.getParameter("tel").toString();
		String password = request.getParameter("password").toString();
		String checkCode = request.getParameter("smsCode").toString();


		JSONObject newUser = new JSONObject();
		newUser.put("login",userName);
		newUser.put("password",password);
		newUser.put("phone",phone);
		newUser.put("smsCode",checkCode);
		newUser.put("authorities","ROLE_USER");

		boolean flag  =uaaUtils.registerNewUser(newUser);//调用注册接口
		if(flag){
			Document user = new Document();
			user.put("userName",userName);
			user.put("password",password);
			user.put(uniqueFlag,openId);//这里把userId和OpenId设置为相同的值
			user.put("userId",openId);
			user.put("flag","1");//1表示已注册
			user.put("status","0");//0:"未实名认证",1："已经实名认证"
			user.put("bindCompanyFlag","0");//0:位绑定企业："已绑定企业"
			user.put("registerDate",new Date());//注册时间

            int i = userService.insert(user,USER_INFO);//插入到本地数据库
			if(i ==1){
				logger.info("用户名："+userName+"实名认证成功！");
				request.getSession().setAttribute("userName",userName);
				return "jsp/user/register1.jsp";//继续实名认证
			}else return "jsp/user/register.jsp";
		}else {logger.error("调用注册接口失败");}
		return "jsp/user/register.jsp";//重新注册
	}

//获取验证码
	@RequestMapping("getCode")
	@ResponseBody
	public String getCode(HttpServletRequest request){
		logger.info("获取手机验证码");
		String  telNum = request.getParameter("phone").toString();
		uaaUtils.getCode(telNum);//调用接口
		return "success";
	}

	//实名认证
	@RequestMapping("authenticate")
	public String authentication(HttpServletRequest request, @RequestParam(value = "before")  MultipartFile idCardbefore,@RequestParam(value = "after")  MultipartFile idCardafter){
		logger.info("=========实名认证==============");

		String xingming = request.getParameter("xingming").toString();//姓名
		String code = request.getParameter("code").toString();//身份证
		String userName = request.getSession().getAttribute("userName").toString();

		JSONObject jsonObject = new JSONObject();//存其他信息
		jsonObject.put("name",xingming);//姓名
		jsonObject.put("identity",code);//身份证
		jsonObject.put("login",userName);//登录名
		jsonObject.put("state","通过");//状态，固定

		Document user =  userService.findUserByUserName(userName,USER_INFO);
		if(user!=null){
			String password  = user.getString("password");
			try{
				JSONObject  token =(JSONObject) uaaUtils.getTokenJSON(userName,password).get("tokens");
				String access_token = token.getString("token");

				Map<String, File> files = new HashMap<>();//存身份证正反面
				File frontFile = new File(idCardbefore.getOriginalFilename());
				idCardbefore.transferTo(frontFile);
				files.put("frontFile",frontFile);

				File backFile = new File(idCardafter.getOriginalFilename());
				idCardafter.transferTo(backFile);
				files.put("backFile",backFile);

				boolean flag = uaaUtils.certificationUser(access_token,jsonObject,files);//调用接口进行实名认证
				if(flag){
					userService.updateUserStatusByUserName(userName,USER_INFO);//更新实名认证状态为“1”
					logger.info("用户名为："+userName+"实名认证成功！");
					return "jsp/user/register2.jsp";
				}
			}catch (NullPointerException e){
				logger.error("获取不到access_token\n"+e);
			}
			catch (IOException e){
				logger.error("transferTo(backFile)方法上传身份证文件到临时文件失败\n"+e);
			}
		}
		return "jsp/user/register1.jsp";
	}

	//企业认证
	@RequestMapping("verifyCompany")
public String verifyCompany(HttpServletRequest request,@RequestParam(value = "licence") MultipartFile  licences ){

		String userName  = request.getSession().getAttribute("userName").toString();

		String enterpriseName  = request.getParameter("qymc").toString();//公司名称
		String creditCode  = request.getParameter("shtydm").toString();//统一社会信用代码

		String enterpriseAddress  = request.getParameter("zcdz").toString();//公司地址
		String legalPersonID  = request.getParameter("frsfz").toString();//法人身份证
		String legalPersonName  = request.getParameter("frxm").toString();//法人姓名
		String legalPersonPhone  = request.getParameter("frlxdh").toString();//法人联系电话

		JSONObject companyPartInfo  = new JSONObject();
		companyPartInfo.put("login",userName);
		companyPartInfo.put("enterpriseName",enterpriseName);
		companyPartInfo.put("creditCode",creditCode);
		companyPartInfo.put("enterpriseAddress",enterpriseAddress);
		companyPartInfo.put("legalPersonID",legalPersonID);
		companyPartInfo.put("legalPersonName",legalPersonName);
		companyPartInfo.put("legalPersonPhone",legalPersonPhone);
		companyPartInfo.put("state","已验证");//固定值

		try{
			String password  = userService.findUserByUserName(userName,USER_INFO).getString("password");

			JSONObject  token =(JSONObject) uaaUtils.getTokenJSON(userName,password).get("tokens");
			String access_token = token.getString("token");

			File licenseFile = new File(licences.getOriginalFilename());
			licences.transferTo(licenseFile);

			boolean flag = uaaUtils.bindCompany(companyPartInfo,access_token,licenseFile);//调用企业认证接口

            if(flag){//企业认证成功则更新绑定标志
            	userService.updateUserOnePropertyByUsername(userName,"bindCompanyFlag","1",USER_INFO);
				userService.updateUserOnePropertyByUsername(userName,"creditCode",creditCode,USER_INFO);
			}
		}catch (NullPointerException e){
			logger.error("出现空指针异常\n"+e);
		    return "jsp/user/register2.jsp";//重新上传
		}catch (IOException e){
			logger.error("上传文件失败！\n"+e);
			return "jsp/user/register2.jsp";//重新上传
		}
		return "jsp/user/register3.jsp";
	}
	@RequestMapping("checkUserIfRegister")
	@ResponseBody
	public String check(HttpServletRequest request, HttpServletResponse response){
		String userName = request.getParameter("userName");
		Document document = userService.findUserByUserName(userName,USER_INFO);
		if(document!= null ){
			return "isExist";
		}else return "notExist";
	}
}
