package com.hn.sanya.bov.controller;

import com.hn.sanya.bov.service.mongodb.service.UserService;
import com.hn.sanya.bov.util.mongodbUtil.*;
import com.mongodb.util.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.*;
import java.util.regex.Pattern;
import  com.hn.sanya.bov.service.mongodb.service.ItemService;
@Controller
@RequestMapping("/item")
public class ItemController {
    private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

    private static final String ZHSL_ITEM_INFO = "zhsl_item_info";//事项信息
    private static final String ZHSL_GSJ_INFO = "zhsl_gsj_info";//归属局信息
    private static final String ZHSL_MY_BANJIAN_INFO = "zhsl_my_banjian_info";//办件信息
    private static final String ZHSL_ITEM_STATE_INFO = "zhsl_item_state_info";//办件状态信息
    private static final String ZHSL_ITEM_METAIL_INFO = "zhsl_item_metail";//办件材料信息
    private static final String ZHSL_ITEM_WEBAPPLY_INFO = "zhsl_item_webapply_info";//办件材料信息

    private static final String USER_INOF = "user_info";//用户部分重要信息

    private static final int everyPageShowDataAccount = 5;//每页显示是条数

    @Autowired
    private  ItemService itemService;

    @Autowired
    private UAAUtils uaaUtils;

    @Autowired
    private UserService userService;

    /**
     * 整理归属局和事项，把结果放到request域中,就可以实现三级联动
     * @return
     */
    protected List<JSONObject> getSanJiLianData(){
        List<Document> list = itemService.findAll(ZHSL_ITEM_INFO);
        List<JSONObject> listJson = new ArrayList<>();//存放最终数组
        for(int i=0;i<list.size();i++){
            String gsj = list.get(i).getString("gsj").toString();
            String itemName = list.get(i).getString("name").toString();
            String itemValue = list.get(i).getString("code").toString();

            if(listJson.size()<0){//第一次添加
                JSONObject jsonSheng = new JSONObject();//省
                jsonSheng.put("name",gsj);

                JSONObject jsonCity = new JSONObject();//一个市
                jsonCity.put("name",itemName);
                jsonCity.put("value",itemValue);
                List<JSONObject> cityList = new ArrayList<>();
                cityList.add(jsonCity);

                jsonSheng.put("city",cityList);
                listJson.add(jsonSheng);

            }else {
                int index =0;
                boolean flag = false;
                for(int j = 0;j<listJson.size();j++){
                    String  gsjJson= listJson.get(j).get("name").toString();
                    if(gsj.equals(gsjJson)){//里面存有相同的归属局，把下标保存
                        index = j;
                        flag = true;
                        break;
                    }
                }
                if(flag){//存过相同的归属局
                    List<JSONObject> listItem = (List)listJson.get(index).get("city");
                    JSONObject jsonItem = new JSONObject();
                    jsonItem.put("name",itemName);
                    jsonItem.put("value",itemValue);
                    listItem.add(jsonItem);
                }else{
                    JSONObject shengjson = new JSONObject();
                    shengjson.put("name",gsj);

                    List<JSONObject> itemlist = new ArrayList<>();
                    JSONObject itemJson = new JSONObject();
                    itemJson.put("name",itemName);
                    itemJson.put("value",itemValue);
                    itemlist.add(itemJson);

                    shengjson.put("city",itemlist);
                    listJson.add(shengjson);
                }
            }
        }
        System.out.println(listJson);
        return listJson;
    }

    //通过用户名获取access_token
    public String getAccessToken(String userName){
        Document  docUser = userService.findUserByUserName(userName,USER_INOF);
        String access_token = null;
        if(docUser!=null){
            String password = docUser.getString("password");
            try{
                JSONObject tokens = uaaUtils.getTokenJSON(userName,password).getJSONObject("tokens");
                access_token = tokens.getString("token");
            }catch (Exception e){
                logger.error("通过用户名和密码获取token出错！\n"+e.getMessage());
            }
        }
        return access_token;
    }
    /**
     * 首页
     * @return 返回一个首页
     */
    @RequestMapping(value="index",method = RequestMethod.GET)
    public String homePage() {
        return "jsp/item/index.jsp";
    }



    /**
     * 进入不见面审批页面
     * @return
     */
    @RequestMapping(value="approveList",method = RequestMethod.GET)
    public String approveList(ModelMap map, HttpServletRequest request){
        try {
            map.addAttribute("gsjList", itemService.findAll(ZHSL_GSJ_INFO));
            map.addAttribute("itemList", itemService.findAll(ZHSL_ITEM_INFO));
            List<JSONObject> json = getSanJiLianData();//调用实现三级联动数据API
            request.setAttribute("json",json);
        } catch (Exception e) {
            logger.error("查询归属局和事项信息的数据出错！\n错误信息："+e);
        }
        return "jsp/item/tableLists.jsp";
    }

    /**
     * ajax发送get请求，动态加载可申报事项列表
     * @param response
     * @param request
     */
    @RequestMapping(value="data" ,method = RequestMethod.GET)
    @ResponseBody
    public void getItemData(HttpServletResponse response, HttpServletRequest request) {
        List<Document> listItem = new ArrayList<Document>();
        List<String> list = new ArrayList<String>();

        try {
            int index = 1;
            int sumCount = itemService.findAll(ZHSL_ITEM_INFO).size();//总的数据条数
            String page = request.getParameter("page");//当前页
            if (page != null || !"".equals(page)) index = Integer.valueOf(page);
            if(index<=sumCount/everyPageShowDataAccount+1){
                listItem = itemService.findByPage(index, ZHSL_ITEM_INFO);
                if (listItem != null||!"".equals(listItem)) {
                    for (int i = 0; i < listItem.size(); i++) {
                        String json = listItem.get(i).toJson();
                        list.add(json);
                    }
                }
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(list);
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("加载不见面审批事项出错！\n错误信息为："+e);
        }
    }

    /**
     *三级联动条件查询事项
     * @param request
     * @param response
     */
    @RequestMapping(value = "findByGI",method = RequestMethod.GET)
    @ResponseBody
    public void findByGI(HttpServletRequest request, HttpServletResponse response) {
        try {
            String gsj = request.getParameter("gsj");
            String code = request.getParameter("item");
            Query q = new Query();
            if (code.equalsIgnoreCase("请选择")) {//根据归属局查
                if (gsj.equals("全部")) {
                    q.addCriteria(Criteria.where("gsj").ne("").ne(null));
                } else q.addCriteria(Criteria.where("gsj").is(gsj));
            } else {//根据归属局和事项查询
                if (gsj.equals("全部")) {
                    q.addCriteria(Criteria.where("code").is(code));
                } else q.addCriteria(Criteria.where("gsj").is(gsj).and("code").is(code));
            }
            List<Document> items = itemService.findItemBy(q, ZHSL_ITEM_INFO);
            List<String> list = new ArrayList<String>();
            for (int i = 0; i < items.size(); i++) {
                String json = items.get(i).toJson();
                list.add(json);
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(list);
            response.getWriter().flush();
            response.getWriter().close();
        } catch (UnsupportedEncodingException e) {
            logger.error("==========三级联动查询条件重新编码出错!==========\n错误信息："+e);
        } catch (NullPointerException e) {
            logger.error("==========三级联动查询出现！空指针异常==========\n错误信息："+e);
        } catch (IOException e) {
            logger.error("==========三级联动IO异常==========\n错误信息："+e);
        } catch (Exception e) {
            logger.error("==========三级联动异常==========\n错误信息："+e);
        }
    }

    /**
     * 根据条件查询可申报事项（连续的关键字查询）
     * 说明：这里的办事指南链接个别的链接上的事项编码和实际用的有些不同，（但是办事指南是一样的）
     * @return
     */
    @RequestMapping(value = "search",method = RequestMethod.POST)
    public String searchItem(HttpServletRequest request, ModelMap map) {
        List<Document> list = new ArrayList<Document>();
        String search = null;
        try {
            search = request.getParameter("search").replace(" ","");
            if (null == search||search.equalsIgnoreCase("")) {//为空时，查询所有
                list = itemService.findAll(ZHSL_ITEM_INFO);
            } else{
                Query query = new Query();
                Pattern pattern = Pattern.compile("^.*" + search + ".*$", Pattern.CASE_INSENSITIVE);
                Criteria criteria = new Criteria();
                criteria.orOperator(Criteria.where("code").regex(pattern),Criteria.where("name").regex(pattern));
                query.addCriteria(criteria);
                list = itemService.findItemBy(query, ZHSL_ITEM_INFO);
            }
            if (list!=null||!"".equals(list)) {//把办事指南连接加到相对应的Document中
                for (int i = 0; i < list.size(); i++) {
                    String code = list.get(i).getString("code");
                    String banshiGuide = null;
                    if (code.equals("46020000SY-XK-0703")) {//1首次发放
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000SY-XK-2520";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000YG-FW-0101")) {//2停业
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0109";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000YG-FW-0102")) {//3歇业
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0107";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000YG-FW-0103")) {//4补办
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0108";
                        list.get(i).put("guide", banshiGuide);
                    }
                    if (code.equals("46020000YG-FW-0104")) {//5恢复营业
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0110";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000YG-XK-0101")) {//6新办
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0102";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000YG-XK-0102")) {//7延续
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0104";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000YG-XK-0103")) {//8变更
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0106";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000ZF-XK-0402")) {//9广告
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000ZF-XK-0201";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                    if (code.equals("46020000ZF-XK-0501")) {//10道路
                        banshiGuide = "http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000ZF-XK-0102";
                        list.get(i).put("guide", banshiGuide);
                        break;
                    }
                }
            }
        } catch (NullPointerException e) {
            logger.error("==========查询不见面审批，出现空指针异常==========\n错误信息："+e);
        }catch (Exception e) {
            logger.error("==========不见面审批事项查询出现异常==========\n错误信息："+e);
        }
        map.addAttribute("search", search);
        map.addAttribute("list", list);

        request.setAttribute("json",getSanJiLianData());//三级联动数据
        return "jsp/item/search.jsp";
    }

    /**进入申报页面
     * 说明：把事项code放到session，方便保存表单和上传材料操作使用
     * 进行事项申报填表页面
     * @return
     */
    @RequestMapping(value = "shenbao",method = RequestMethod.GET)
    public String shenbao(HttpServletRequest request, ModelMap map) {
        String view = "jsp/item/form/saveForm/";
        String code = request.getParameter("code");

        String userName = request.getSession().getAttribute("userName").toString();
        String access_token = getAccessToken(userName);//Oauth授权的令牌

        if(access_token!=null){
            JSONObject jsonCompanys =  uaaUtils.getBindCompanyInfo(userName,access_token);//绑定企业信息
            JSONArray jsonCompanyArray =(JSONArray) jsonCompanys.get("content");//所有企业信息
            JSONObject jsonCompany =jsonCompanyArray.getJSONObject(0);//第一个企业信息

            JSONObject userVertifyInfo = uaaUtils.getUserVerifiyInfo(userName,access_token);//认证信息
            JSONObject loginUserInfo = uaaUtils.getUserInfo(userName,access_token);//用户信息
            userVertifyInfo.put("tel",loginUserInfo.getString("tel"));//添加电话到用户信息中

            map.addAttribute("company",jsonCompany);//企业信息
            map.addAttribute("userVertifyInfo",loginUserInfo);//用户信息

            System.out.println("企业信息："+jsonCompany+"\n");
            System.out.println("个人信息："+userVertifyInfo+"\n");
        }

        view = ViewUtils.getView(view,code);//根据编码和路径返回页面路径, ViewUtils工具类

        Document d = itemService.findOne(new Query().addCriteria(Criteria.where("code").is(code)), ZHSL_ITEM_INFO);
        if(d == null){
            return "redirect:approveList.html";
        }
        map.addAttribute("doc", d);
        request.getSession().setAttribute("code", code);
        return view;
    }

    /**
     * 提交申报事项操作
     * 说明：成功就把返回 的dataId放到session,方便上传材料时使用
     * @param request
     * @param param 序列化的保存表单数据
     * @return
     */
    @RequestMapping(value = "saveItem", method = RequestMethod.POST)
    @ResponseBody
    public String saveItem(HttpServletRequest request, @RequestBody String param) {
        Document document = new Document();
        Date saveTime = new Date();//上传时间
        String dataId = null;
        String result = "failure";
        try {
            String userId = request.getSession().getAttribute("userId").toString();//touch
            String code = request.getSession().getAttribute("code").toString();

            String strParam = param;//2、上传序列化表单数据
            JSONObject json = JSONObject.fromObject(JSON.parse(strParam));

            String moren = json.getString("moren");
            if ("0".equals(moren)) {//服务清单默认时（调用用户信息当做服务清单*）
                String userName = request.getSession().getAttribute("userName").toString();
                String access_token = this.getAccessToken(userName);

                String ApplicationName = "";//申请人姓名
                String ApplicationID = "";//申请人身份证
                String ApplicationMobile ="";//申请人电话
                String ApplicationAddress ="";//申请人住址

                if(access_token!=null){
                    JSONObject  userInfo = uaaUtils.getUserInfo(userName,access_token);
                    ApplicationName  =userInfo.getString("name");
                    ApplicationID = userInfo.getString("identity");
                    ApplicationMobile = userInfo.getString("tel");
                  // ApplicationAddress = userInfo.getString("name");//这里调用的接口就没有保存此字段，所有没有,只能穿空

                }
                json.put("ApplicationName", ApplicationName);
                json.put("ApplicationID", ApplicationID);
                json.put("ApplicationMobile", ApplicationMobile);
                json.put("ApplicationAddress", ApplicationAddress);

            }
            Query query = new Query();
            query.addCriteria(Criteria.where("code").is(code));
            Document itemDoc = itemService.findOne(query,ZHSL_ITEM_INFO);
            String name = itemDoc.getString("name");
            String gsj = itemDoc.getString("gsj");
            String formId = itemDoc.getString("formId");

            String saveResult = LangChaoService.saveData(formId, strParam);//调用接口

            if(saveResult==null||"".equals(saveResult)){
                logger.info("=====调用保存接口保存数据失败=====");
            }else{
                JSONObject saveData = JSONObject.fromObject(JSON.parse(saveResult));//整理保存的需要的所有
                System.out.println("saveResult::"+saveResult);
                dataId = saveData.getString("dataId");
                document.put("userId", userId);//touch
                document.put("code", code);
                document.put("name", name);
                document.put("gsj", gsj);
                document.put("savetime", saveTime);
                document.put("dataId", dataId);
                document.put("receiveNum", "");
                document.put("data", json);
                int i = itemService.insertOneItem(document, ZHSL_MY_BANJIAN_INFO);
                if (i == 1) {//添加成功，则把办件状态也添加进库
                    Document dState = new Document();
                    dState.put("userId", userId);//touch
                    dState.put("dataId", dataId);
                    dState.put("state", "保存");
                    dState.put("receiveNum", "");
                    int j = itemService.insertOneItem(dState, ZHSL_ITEM_STATE_INFO);
                    if (j == 1) {//成功
                        result = "success";
                    }
                }
            }
        } catch (Exception e) {
            logger.error("保存数据出现异常了,无法保存数据！\n"+e);
        }
        request.getSession().setAttribute("dataId", dataId);
        return result;
    }

    /**
     * @return 返回一个材料上传页面
     */
    @RequestMapping(value = "uploadPage",method = RequestMethod.GET)
    public String UploadPage(HttpServletRequest request, ModelMap map) {
        String code = request.getSession().getAttribute("code").toString();//通过code动态获取上传材料信息
        JSONArray fileInfoArr = LCService.getItemInfoByItemCodeJSONArray(code);//调用接口（获取表单材料信息）
        map.addAttribute("fileInfoArr", fileInfoArr);
        return "jsp/item/Uploadfiles.jsp";
    }

    /**
     * 上传材料处理
     * @param file 材料组中某一材料的文件组
     * @return
     */
    @RequestMapping(value = "upload",method = RequestMethod.POST)
    public String upload(HttpServletRequest request, @RequestParam("UploadFile") MultipartFile[] file) {

        String view = "uploadPage.html";
        List<Map<String,String>> beforeList = null;
        try {
            beforeList = (List)request.getSession().getAttribute("filesList");//获取之前上传的材料
           // System.out.println("之前上传的材料::"+beforeList);

            beforeList = MetailUtils.getFileNameList(file,beforeList);//存放上传过所有文件的名字（旧的加上信息的）
            System.out.println("之前加现在上传的材料::"+beforeList);
            String dataId = null;
            try{
                 dataId = request.getSession().getAttribute("dataId").toString();//
            }catch (NullPointerException e){
                logger.error("拿不到dataId");
                return "redirect:index.html";
            }
            Document d =itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(dataId)),ZHSL_MY_BANJIAN_INFO);
            String itemCode = d.getString("code");//事项编码
            String itemName = d.getString("name");//事项名称

            String metailCode = request.getParameter("otherParam");//材料CODE，通过隐藏域和表单一起闯过来
            //String type = "1";//默认为电子版的

            String userId = request.getSession().getAttribute("userId").toString();//touch
            List<Map<String, String>> files = new ArrayList<Map<String, String>>();//一个材料里放文件组
            files = MetailUtils.getUploadFile(file,userId);//把上传的材料遍历放到list集合中，并上传到浪潮

            //获取所有材料信息（用itemCode调用接口拿）
            JSONArray metails = LCService.getItemInfoByItemCodeJSONArray(itemCode);

            //判断此事项是否已经有材料（用dataId去材料表metail_info拿数据）
            Query query = new Query().addCriteria(Criteria.where("dataId").is(dataId));
            Document docMetail = itemService.findOne(query, ZHSL_ITEM_METAIL_INFO);

            if (docMetail == null) {//首个材料（第一次存）
                //事项基本信息
                Document document = new Document();//所有数据
                document.put("userId", userId);//用户唯一标志
                document.put("dataId", dataId);//办件唯一标志
                document.put("code", itemCode);//事项编码
                document.put("itemName", itemName);//事项名称

                //材料信息
                JSONArray doc_array = new JSONArray();//材料组
                List<Document> metailList = new ArrayList<Document>();//用来存文件组

                MetailUtils.getFilesInfoTFirstSave(metails,metailCode,files,metailList);//调用接口，此接口以把文件上传到浪潮中

                doc_array.add(metailList);//把文件组加入到材料组中
               // int num = metailList.size();//如，一个材料上传了两个文件，则num==2
                document.put("metail", doc_array);//将材料放入整个文档
                itemService.insertOneItem(document, ZHSL_ITEM_METAIL_INFO);
                logger.info("第一次上传材料成功！");

                request.getSession().setAttribute("filesList",beforeList);//展示上传过的材料名在

                return "redirect:" + view;
            }


            //已经存在材料(即上传过的材料信息)
            List<List<Map<String, String>>> array = (List<List<Map<String, String>>>) docMetail.get("metail");
            //遍历数组，判断当前上传的材料是否已经存在
            boolean isExist = false;
            //若是存在，保存索引值
            int index = 0;
            for (int i = 0; i < array.size(); i++) {//从数据库里拿出存的材料的索引位置,如果已存在，则后面会删掉再添加进去新的
                List<Map<String, String>> list = array.get(i);
                if (list.get(0).containsValue(metailCode)) {
                    isExist = true;
                    index = i;
                    break;
                }
            }
            List<Map<String, String>> metailList = new ArrayList<Map<String, String>>();//文件组
            //获取该材料id的所有信息 temp
            JSONObject temp = new JSONObject();
            for (int i = 0; i < metails.size(); i++) {//所有材料(JSONArray)
                JSONObject obj = metails.getJSONObject(i);//
                if (obj.containsValue(metailCode)) {//传进来的文件属于此材料，然后把材料信息放到temp中
                    temp = obj;//一个材料信息
                    break;
                }
            }

            MetailUtils.getFilesInfoToSecondSave(files,metailCode,temp,metailList);//调用接口

            if (isExist) { //已经存在，先删除（原来的文件已将保存到临时JSONObject中了）
                array.remove(index);
            }
            array.add(metailList);//把新上传从材料文件组保存进之前上传过的材料组

            docMetail.put("metail", array);

            itemService.updateFirstItem(ZHSL_ITEM_METAIL_INFO,query,docMetail);//更新材料

            request.getSession().setAttribute("filesList",beforeList);//展示上传过的材料名

            logger.info("=====上传材料成功！=====");
            return "redirect:" + view;
        } catch (Exception e) {
            logger.error("=====上传失败======\n"+e);
            return "redirect:" + view;//重定向到上传页面
        }
    }

    /******************************************************我的办件模块**************
     * 进入我的办件页面
     * @return
     */
    @RequestMapping(value = "myItem", method= RequestMethod.GET)
    public String myItem() {
        logger.info("进入我的办件");
        return "jsp/item/wdbanjian.jsp";
    }

    /**
     * ajax动态加载我的办件信息
     * @param request
     * @param response
     */
    @RequestMapping(value = "dynloadItem",method = RequestMethod.GET)
    @ResponseBody
    public void dynloadItem(HttpServletRequest request, HttpServletResponse response) {
        String userId = request.getParameter("userId");//touch
        String page = request.getParameter("page");
        int index = 1;
        if (page != null ||"".equals(page)) index = Integer.valueOf(page);
        List<Document> listBJ = new ArrayList<Document>();//存办件信息
        List<String> list = new ArrayList<String>();//存办件的json格式信息
        try {
            Query query = new Query().addCriteria(Criteria.where("userId").is(userId)).skip((index - 1) * everyPageShowDataAccount).limit(everyPageShowDataAccount);//touch
            listBJ = itemService.findItemBy(query, ZHSL_MY_BANJIAN_INFO);//我的办件
            for (int j = 0; j < listBJ.size(); j++) {//添加状态
                Document dItem = listBJ.get(j);
                String dataId = dItem.getString("dataId");
                Document dState = itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(dataId)), ZHSL_ITEM_STATE_INFO);
                String state = dState.getString("state");//获取状态
                dItem.put("state", state);
                String json = dItem.toJson();//变json
                list.add(json);
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(list.toString());
            response.getWriter().flush();
            response.getWriter().close();
            logger.info("======成功的去动态加载我的办件信息！====");
        } catch (Exception e) {
            logger.error("=====加载我的办件出错=====\n"+e);
        }
    }

    /**
     * 查询我的办件(根据事项名称,code或状态)
     * @return
     */
    @RequestMapping(value = "searchMyItem" ,method = RequestMethod.POST)
    public String searchMyItem(HttpServletRequest request, ModelMap map) {
        List<Document> listMyItems = new ArrayList<Document>();
        List<Document> listItemsResult = new ArrayList<Document>();
        String condition = null;
        try {
            condition  = request.getParameter("search").replaceAll(" ","");
            Pattern pattern = Pattern.compile("^.*" + condition + ".*$", Pattern.CASE_INSENSITIVE);
            String userId = request.getSession().getAttribute("userId").toString();//touch

            if (condition == null || condition.equalsIgnoreCase("")) {//没有条件就全部查出来
                Query query = new Query().addCriteria(Criteria.where("userId").is(userId));//touch
                listMyItems = itemService.findItemBy(query, ZHSL_MY_BANJIAN_INFO);
            } else {//先根据事项名称查
                Criteria cByName = Criteria.where("name").regex(pattern).and("userId").is(userId);//touch
                Criteria cByCode = Criteria.where("code").regex(pattern).and("userId").is(userId);//touch
                Query query1 = new Query(new Criteria().orOperator(cByName,cByCode));
                listMyItems = itemService.findItemBy(query1, ZHSL_MY_BANJIAN_INFO);
                if (listMyItems.size() <= 0) {//根据状态
                    Query query3 = new Query().addCriteria(Criteria.where("state").regex(pattern).and("userId").is(userId));//touch
                    List<Document> stateList = itemService.findItemBy(query3, ZHSL_ITEM_STATE_INFO);
                    if(stateList.size()>0){
                        for (int i = 0; i <stateList.size(); i++) {
                            String dataId = stateList.get(i).getString("dataId");
                            Query query4 = new Query().addCriteria(Criteria.where("dataId").is(dataId).and("userId").is(userId));//touch
                            Document d4 = itemService.findOne(query4, ZHSL_MY_BANJIAN_INFO);
                            if(d4!=null){
                                d4.put("state", stateList.get(i).getString("state"));
                                listMyItems.add(d4);
                            }
                        }
                    }
                    map.addAttribute("search",condition);
                    map.addAttribute("listMyItems", listMyItems);
                    return "jsp/item/searchmybanjian.jsp";
                }
            }
            for (int i = 0; i < listMyItems.size(); i++) {//根据dataId去拿状态 提交表单才有dataId
                Document itemDoc = listMyItems.get(i);
                String dataId = itemDoc.getString("dataId");
                Document d = itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(dataId)), ZHSL_ITEM_STATE_INFO);
                itemDoc.put("state", d.getString("state"));//加入状态
                listItemsResult.add(itemDoc);
            }
        } catch (Exception e) {
            logger.error("=====查询我的办件出错====\n"+e);
        }
        map.addAttribute("search",condition);
        map.addAttribute("listMyItems", listItemsResult);
        System.out.println(("条件==========="+condition));
        return "jsp/item/searchmybanjian.jsp";
    }

    /**
     * 查看办件的状态信息
     * 取状态：本地的+浪潮的
     * @return 经历过的所有状态信息
     */
    @RequestMapping(value = "lookStatus",method = RequestMethod.GET)
    public String lookStatus(HttpServletRequest request, ModelMap map) {
        logger.info("开始查询办件所有状态信息：");//状态 意见 时间(去)
        JSONArray jsonArray = new JSONArray();
        String receiveNum = "";//46020000ZF-XK-04021711200003
        String dataId = "";
        JSONObject jsonObject = new JSONObject();
        try {
            receiveNum = request.getParameter("receiveNum").toString();
            dataId = request.getParameter("dataId").toString();
            Query query = new Query();
            query.addCriteria(Criteria.where("dataId").is(dataId));
            Document d = itemService.findOne(query, ZHSL_MY_BANJIAN_INFO);

            jsonObject.put("CURRENT_NODE_NAME", "保存");
            jsonObject.put("OPINION", "去申报");
            jsonObject.put("RECEIVE_TIME", DateUtil.DateBianString6(d.getDate("savetime")));
            if(!"".equals(receiveNum)){
                jsonArray = LCService.getBusinessInfoJSONArray(receiveNum);//调用浪潮接口
                jsonObject.put("OPINION","无");
                JSONObject jsonObject2 = new JSONObject();
                jsonObject2.put("CURRENT_NODE_NAME", "申报");
                jsonObject2.put("OPINION", "无");
                jsonObject2.put("RECEIVE_TIME", DateUtil.DateBianString6(d.getDate("sbtime")));//
                jsonArray.add(jsonObject2);
            }
        } catch (JSONException e) {
            logger.error("查看状态出现空指针异常！\n"+e);
        }
        catch (Exception e) {
            logger.error("查询事项状态信息出错!\n"+e);
        }
        jsonArray.add(jsonObject);//保存状态
        map.addAttribute("stateList", jsonArray);
        return "jsp/item/banshistatus.jsp";
    }

    /**
     * 网上申报
     * @param dataId
     * @param request
     * @return
     */
    @RequestMapping(value = "webapply",method = RequestMethod.GET)
    public String webapply(@RequestParam String dataId, HttpServletRequest request) {
        Map<String,Object> postdata = new HashMap<String, Object>();//准备申报需要上传的材料，
        try {
            List<List<Map<String, String>>> metail = new ArrayList<List<Map<String, String>>>();
            //办件信息
            Document banjianDoc = itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(dataId)), ZHSL_MY_BANJIAN_INFO);
            //材料信息
            Document metailDoc = itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(dataId)), ZHSL_ITEM_METAIL_INFO);

            String userId = request.getSession().getAttribute("userId").toString();//touch
            String userName = request.getSession().getAttribute("userName").toString();

            Object dataObject =  banjianDoc.get("data");//表单信息
            JSONObject data = JSONObject.fromObject(dataObject);
            JSONObject servicelist = new JSONObject();

            String access_token = this.getAccessToken(userName);//token令牌

            //TODO 企业信息 这里的企业信息到时候去根据userId调用接口拿
            JSONObject jsonObject = uaaUtils.getBindCompanyInfo(userName,access_token);
            JSONArray companyList = (JSONArray) jsonObject.get("content");//一组企业信息
            JSONObject oneCompanyInfo =(JSONObject) companyList.get(0);//一个企业信息(包含经办人部分信息)
            JSONObject applicant = oneCompanyInfo.getJSONObject("user");

            JSONObject info = new JSONObject();
            if(jsonObject!=null){
                info.put("orgName", oneCompanyInfo.getString("enterpriseName"));//组织机构名称
                info.put("orgCode", oneCompanyInfo.getString("creditCode"));//组织机构代码
                info.put("legalPerson", oneCompanyInfo.getString("legalPersonName")); //法定代表人
                info.put("registerAddress",oneCompanyInfo.getString( "enterpriserAddress"));//注册地址
                info.put("linkMan", applicant.getString("name"));//联系人
                info.put("contactPhone", applicant.getString("tel"));//联系人电话
            }else{
                JSONObject userVertify = uaaUtils.getUserInfo(userName,access_token);//调用接口获取用户信息
                info.put("orgName", "");//组织机构名称
                info.put("orgCode", "");//组织机构代码
                info.put("legalPerson", ""); //法定代表人
                info.put("registerAddress",oneCompanyInfo.getString( "enterpriserAddress"));//注册地址
                info.put("linkMan", userVertify.getString("name"));//联系人
                info.put("contactPhone", userVertify.getString("tel"));//联系人电话
            }

            //服务清单 自定义就从表单数据拿
            if("1".equals(data.getString("moren"))){
                servicelist.put("ApplicantName", data.getString("ApplicantName"));
                servicelist.put("ApplicantID", data.getString("ApplicantID"));
                servicelist.put("ApplicantMobile", data.getString("ApplicantMobile"));
                servicelist.put("ApplicantAddress", data.getString("ApplicantAddress"));
            }else{//调用接口拿
                if(access_token!=null){
                    JSONObject jsonUser = uaaUtils.getUserInfo(userName,access_token);
                    if(jsonUser!=null){
                        servicelist.put("ApplicantName",jsonUser.getString("name"));
                        servicelist.put("ApplicantID",jsonUser.getString("identity"));
                        servicelist.put("ApplicantMobile",jsonUser.getString("tel"));
                        servicelist.put("ApplicantAddress", "");
                    }
                }
            }

            //投递与否
            if ("1".equals(data.getString("SendType"))) {//投递时，再把邮寄相关信息传过去
                servicelist.put("SendMobile",data.getString("receiverPhone"));
                servicelist.put("SendCityCode", data.getString("HallCode"));
                servicelist.put("SendName", data.getString("HallName"));
                servicelist.put("SendAddressee", data.getString("MailAddress"));
            }else{
                servicelist.put("SendType",data.getString("SendType"));
            }


            //办件其他基础信息
            String itemCode = banjianDoc.getString("code");//事项编码
            String ItemName = banjianDoc.getString("name");//事项名称
            String OrgName = banjianDoc.getString("gsj");//归属局名称
            String DataId = banjianDoc.getString("dataId");//数据Id
            String OrgCode = itemService.findOne(new Query().addCriteria(Criteria.where("name").is(OrgName)), ZHSL_GSJ_INFO).getString("gsj_id");
            Document itemDoc = itemService.findOne(new Query().addCriteria(Criteria.where("code").is(itemCode)), ZHSL_ITEM_INFO);
            String ItemId = itemDoc.getString("itemId");//事项Id，（去事项信息表拿的）
            String FormId = itemDoc.getString("formId");//表单Id，（通过事项编码去事项表拿）

            //把所有材料文件遍历出来放到文件组中
            metail = (List) metailDoc.get("metail");//材料信息
            List<Map<String,String>> fileList = new ArrayList<Map<String, String>>();
            for(int i=0;i<metail.size();i++){
                List<Map<String,String>> oneMetail =  metail.get(i);//第一个材料
                for(int j=0;j<oneMetail.size();j++){
                    Map<String,String> onefile = oneMetail.get(j);
                    Map<String,String> file = new HashMap<String, String>();
                    file.put("OPERATOR_ID",userId);
                    file.put("OPERATOR_NAME",userName);
                    file.put("DOCUMENT_ID",onefile.get("id"));
                    file.put("DOCUMENT_NAME",onefile.get("name"));
                    file.put("TYPE",onefile.get("type"));
                    file.put("FILE_NAME",onefile.get("fileName"));
                    file.put("FILE_PATH",onefile.get("docPath"));
                    fileList.add(file);
                }
            }
            String IsPrejudication = "11";//预审 12 跳过预审
            String ObjectType = "3";
            //String ReceiveNum =  banjianDoc.getString("receiveNum");
            // postdata.put("ReceiveNum",ReceiveNum ==""? "" : ReceiveNum);//1
            // postdata.put("State",ReceiveNum ==""? "sp" : "bqbz");//bqbz编辑的时候用
            postdata.put("ReceiveNum","");
            postdata.put("State","sp");//这里直接写死，因为申报之后就没有申报按钮，即无二次提交一说
            postdata.put("ItemCode", itemCode);//
            postdata.put("servicelist", servicelist);//4
            postdata.put("OrgName", OrgName);//5
            postdata.put("ItemId", ItemId);//6
            postdata.put("metail", fileList);//7
            postdata.put("IsPrejudication", IsPrejudication);
            postdata.put("OrgCode", OrgCode);
            postdata.put("ObjectType", ObjectType);
            postdata.put("DataId", DataId);
            postdata.put("ItemName", ItemName);
            postdata.put("FormId", FormId);
            postdata.put("info", info);
            System.out.println("申报的数据："+postdata);

            //调用浪潮申报接口，返回流水号为成功
            JSONObject postDataJson = JSONObject.fromObject(postdata);
            String result = LangChaoService.webApply(postDataJson.toString());//调用浪潮接口
            System.out.println("申报接口::"+result);
            if(result == null||"".equals(result)){
                logger.error("调用接口返回结果为空");
            } else {//成功的时候
                JSONObject resultJson = JSONObject.fromObject(JSON.parse(result));//有时候回出现这个错
                if("200".equals(resultJson.getString("state"))){//申报成功，把状态修改一下
                    // 添加申报时间，申报流水号，更新状态表,本地保存一份
                    Date sbtime = new Date();
                    String receiveNum = resultJson.getString("receiveNum");
                    Document webApplyInfoDoc = new Document();
                    webApplyInfoDoc.put("userId",userId);
                    webApplyInfoDoc.put("receiveNum",receiveNum);
                    webApplyInfoDoc.put("dataId",DataId);
                    webApplyInfoDoc.put("postdata",postdata);
                    itemService.insertOneItem(webApplyInfoDoc,ZHSL_ITEM_WEBAPPLY_INFO);

                    Document stateDoc = itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(DataId)),ZHSL_ITEM_STATE_INFO);
                    stateDoc.put("state","申报");
                    stateDoc.put("receiveNum",receiveNum);
                    banjianDoc.put("sbtime",sbtime);
                    banjianDoc.put("receiveNum",receiveNum);
                    itemService.updateFirstItem(ZHSL_ITEM_STATE_INFO,new Query().addCriteria(Criteria.where("dataId").is(DataId)),stateDoc);
                    itemService.updateFirstItem(ZHSL_MY_BANJIAN_INFO,new Query().addCriteria(Criteria.where("dataId").is(DataId)),banjianDoc);
                    logger.info("=====申报成功=====");
                }else{
                    logger.error("=====申报接口返回非200状态码=====\n"+"错误信息："+result);
                }
            }
        } catch (Exception e) {
            logger.error("=====申报出错！=====\n"+e);
        }
        return "redirect:myItem.html";
    }

    /**
     * 查看办件信息 基础信息+材料信息
     * @param dataId
     * @param code
     * @param map
     * @return
     */
    @RequestMapping(value = "lookItem",method = RequestMethod.GET)
    public String lookItem(@RequestParam String dataId, @RequestParam String code, ModelMap map) {
        String view = "jsp/item/form/displayForm/";
        Document banjianInof = new Document();
        view = ViewUtils.getView(view,code);
        try {
            Document banjianStuffInfo = new Document();
            List listMetail = new ArrayList();
            Query query = new Query().addCriteria(Criteria.where("dataId").is(dataId));
            banjianInof = itemService.findOne(query, ZHSL_MY_BANJIAN_INFO);

            banjianStuffInfo = itemService.findOne(query, ZHSL_ITEM_METAIL_INFO);
            if(banjianStuffInfo ==null || "".equals(banjianStuffInfo)){
                logger.error("该事项还没上传过材料！");
            }else {
                listMetail = (List) banjianStuffInfo.get("metail");//异常
                banjianInof.put("metail", listMetail);
                for (int i = 0; i < listMetail.size(); i++) {
                    System.out.println("材料：" + listMetail);
                    List oneList = (List) listMetail.get(i);//第一组材料
                    for (int j = 0; j < oneList.size(); j++) {
                        Map<String, String> oneFile = (HashMap) oneList.get(j);//用map接受文件
                        String docidOne = oneFile.get("docPath");
                        int docIdInt = docidOne.lastIndexOf("=");
                        String docId = docidOne.substring(docIdInt + 1);
                        String fileName = oneFile.get("fileName");
                        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
                        oneFile.put("docid", docId);
                        oneFile.put("suffix", suffix);
                    }
                }
            }

        } catch (Exception e) {
            logger.error("======查看办件信息异常=====\n"+e);
        }
        map.addAttribute("banjianInof", banjianInof);
        return view;
    }

    /**
     * 查看文件，如果是图片可以直接查看，如果是文件需下载
     * @param request
     * @param response
     */
    @RequestMapping(value = "lookMetail",method = RequestMethod.GET)
    @ResponseBody
    public void lookMetail(HttpServletRequest request, HttpServletResponse response) {
        String displayFileName = null;
        String url =null;
        String suffix =null;
        OutputStream out = null;
        try {
            displayFileName = request.getParameter("fileName").replace(" ","");
            url = request.getParameter("docPath").replace(" ","");
            if(displayFileName.contains(".")){
                int index = displayFileName.lastIndexOf(".");
                suffix = displayFileName.substring(index + 1);
            }
            byte bFile[] = UploadUtil.getAsByteArray(url);
            if (bFile != null){
                if ("png".equals(suffix) || "jpg".equals(suffix) || "gif".equals(suffix)) {//图片
                    response.setContentType("image/jpeg");
                }
                if ("doc".equals(suffix) || "docx".equals(suffix) || "xlsx".equals(suffix) || "xls".equals(suffix) || "txt".equals(suffix)) {//不是图片
                    response.addHeader("content-type", "application/x-msdownload");
                    response.addHeader("Content-Disposition", "attachment;filename=" + displayFileName);
                    response.addHeader("Content-Transfer-Encoding", "binary");//设置传输方式，默认是压缩
                    response.setContentLength(bFile.length);
                }
                out = response.getOutputStream();
                out.write(bFile);
                out.flush();
                out.close();
            }
        } catch (NullPointerException e){
            logger.error("===========文件名或文件路径没有传参数============="+e);
        }catch (IOException e) {
            logger.error("===========获取输出流失败============="+e);
        }
    }

    /**
     * 编辑页面
     * @param request
     * @param map
     * @return
     */
    @RequestMapping(value = "editItem",method = RequestMethod.GET)
    public String editItemPage(HttpServletRequest request, ModelMap map) {
        String view = "jsp/item/form/editForm/";
        String code = "";
        String dataId = "";
        String flag = "first";//用来标志没有上传过的材料 （就没有查看功能）
        try{
            code = request.getParameter("code");
            dataId = request.getParameter("dataId");
            view = ViewUtils.getView(view, code);

            List<List<Map<String,String>>> metail = new ArrayList<List<Map<String, String>>>();//材料信息

            JSONArray metailJsonArray =  LCService.getItemInfoByItemCodeJSONArray(code);//调用浪潮接口
            for(int k=0;k<metailJsonArray.size();k++){//把材料信息都遍历在这里 metail集合里
                JSONObject oneFileJson = (JSONObject)metailJsonArray.get(k);
                Map<String,String> oneFile = new HashMap<String, String>();
                String id =oneFileJson.getString("CODE");
                String metailName = oneFileJson.getString("NAME");
                oneFile.put("id",id);
                oneFile.put("name",metailName);
                oneFile.put("flag",flag);
                List<Map<String,String>> listFiles = new LinkedList<Map<String, String>>();
                listFiles.add(oneFile);
                metail.add(listFiles);
            }
            System.out.println("需要上传的材料信息::"+metail);

            Query query = new Query();
            query.addCriteria(Criteria.where("dataId").is(dataId));
            Document banjianDoc = new Document();
            Document docMetail = new Document();

            docMetail = itemService.findOne(query, ZHSL_ITEM_METAIL_INFO);
            banjianDoc =itemService.findOne(query, ZHSL_MY_BANJIAN_INFO);
            if(docMetail==null ||"".equals(docMetail)){//上传过材料
                logger.error("该事项没上传过材料，所有没材料显示！");
            }else if(banjianDoc!=null||!"".equals(banjianDoc)){
                List<List<Map<String,String>>> metailList =(List) docMetail.get("metail");//已上传的材料
                for(int k=0;k<metailList.size();k++){
                    List<Map<String,String>> uploadOneMetail= metailList.get(k);//第一组材料信息
                    String id = uploadOneMetail.get(0).get("id");//材料唯一标志
                    for(int j=0;j<metail.size();j++){//遍历
                        if(id.equals(metail.get(j).get(0).get("id"))){
                            metail.set(j,uploadOneMetail);//把材料添加到
                        }
                    }
                }
            }
            banjianDoc.append("metail", metail);
            request.getSession().setAttribute("dataId", dataId);
            request.getSession().setAttribute("code", code);
            map.addAttribute("banjianInof", banjianDoc);
            System.out.println("办件信息::"+banjianDoc);
        }catch (Exception e){
            logger.error("=====编辑页面的跳转出现异常====="+e);
        }
        return view;
    }
//todo 手机文件上传很慢，接着测
    /**
     * 编辑操作
     * @param request
     * @param param
     * @return
     */
    @RequestMapping(value = "editItemAction",method = RequestMethod.POST)
    @ResponseBody
    public String editItemAction(HttpServletRequest request, @RequestBody String param){
        String resultFlag = "failure";
        String dataId = request.getSession().getAttribute("dataId").toString();
        Query query = new Query();
        query.addCriteria(Criteria.where("dataId").is(dataId));
        JSONObject jsonParam = JSONObject.fromObject(param);
        Document oldDoc = itemService.findOne(query,ZHSL_MY_BANJIAN_INFO);
        if(oldDoc!=null||!"".equals(oldDoc)){
            oldDoc.put("data",jsonParam);
            itemService.updateFirstItem(ZHSL_MY_BANJIAN_INFO,query,oldDoc);//更新我的办件的表单信息，
            resultFlag = "success";
            logger.info("成功修改数据编码为"+dataId+"的办件要素信息");
        }
        return resultFlag;
    }

    /**
     * 编辑页面里提交的文件
     * @param request
     * @param file
     * @return
     */
    @RequestMapping(value = "updateFiles",method = RequestMethod.POST)
    public String updateFiles(HttpServletRequest request,@RequestParam("UploadFile") MultipartFile[] file) {
        String metailCode = request.getParameter("otherParam").replace(" ","");//材料CODE
        String dataId = request.getSession().getAttribute("dataId").toString().replace(" ","");
        String userId = request.getSession().getAttribute("userId").toString().replace(" ","");//touch
        String itemCode = "";

        Document banjianDoc= new Document();//办件
        Document docMetail = new Document();//材料
        JSONArray metailJsonArray = new JSONArray();//材料信息，调用接口
        List<Map<String, String>> files = new ArrayList<Map<String, String>>();//一个材料里放文件组
        files = MetailUtils.getUploadFile(file,userId);//把上传的文件都放在这个list集合里
        try{
            banjianDoc = itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(dataId)), ZHSL_MY_BANJIAN_INFO);
            itemCode = banjianDoc.getString("code");
            metailJsonArray = LCService.getItemInfoByItemCodeJSONArray(itemCode);
            docMetail = itemService.findOne(new Query().addCriteria(Criteria.where("dataId").is(dataId)), ZHSL_ITEM_METAIL_INFO);

            if(docMetail==null||"".equals(docMetail)){//第一次提交材料,(是没有任何的材料文件)
                Document docMetailTemp = new Document();
                docMetailTemp.put("userId",userId);//这里的docMetail为空，使用就会出现空指针异常
                docMetailTemp.put("dataId",dataId);
                docMetailTemp.put("code",banjianDoc.getString("code"));
                docMetailTemp.put("itemName",banjianDoc.getString("name"));


                JSONArray doc_array = new JSONArray();//
                List<Document> fileList = new ArrayList<Document>();//
                MetailUtils.getFilesInfoTFirstSave(metailJsonArray,metailCode,files,fileList);//调用接口
                doc_array.add(fileList);
                docMetailTemp.put("metail",doc_array);
                itemService.insertOneItem(docMetailTemp,ZHSL_ITEM_METAIL_INFO);
                return "redirect:editItem.html?code="+itemCode+"&&dataId="+dataId;

            }else{//第二次提交（即编辑材料）
                List<List<Map<String, String>>> array = new LinkedList<List<Map<String, String>>>();//材料组
                List<Map<String, String>> metailList = new ArrayList<Map<String, String>>();//文件组
                array = (List<List<Map<String, String>>>) docMetail.get("metail");

                //若是存在，保存索引值
                int index = 0;
                boolean isExist = false;
                for (int i = 0; i < array.size(); i++) {//从数据库里拿出存的材料的索引位置
                    List<Map<String, String>> list = array.get(i);//一个材料文件组
                    if (list.get(0).containsValue(metailCode)) {//遍历文件组
                        index = i;
                        isExist = true;
                        break;
                    }
                }

                JSONObject temp = new JSONObject();
                for (int i = 0; i < metailJsonArray.size(); i++) {//遍历材料信息，并把要修改的材料信息保存并放到temp中
                    JSONObject obj = metailJsonArray.getJSONObject(i);//
                    if (obj.containsValue(metailCode)) {
                        temp = obj;//一个材料信息
                        break;
                    }
                }
                MetailUtils.getFilesInfoToSecondSave(files,metailCode,temp,metailList);//调用接口

                if (isExist) { //上传过此材料的文件，删除旧的，添加新的
                    array.remove(index);
                    array.add(index,metailList);
                }else array.add(metailList);

                //把要修改的材料放到了材料组里
                docMetail.put("metail",array);
                itemService.updateFirstItem(ZHSL_ITEM_METAIL_INFO,new Query().addCriteria(Criteria.where("dataId").is(dataId)),docMetail);
                logger.info("成功修改办件的材料信息");
               // JOptionPane.showMessageDialog(null,"上传成功！");
            }
        }catch (Exception e){
            logger.error("更新材料失败\n"+e);
        }
        return "redirect:editItem.html?code="+itemCode+"&&dataId="+dataId;
    }


}
