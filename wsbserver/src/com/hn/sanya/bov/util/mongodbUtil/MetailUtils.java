package com.hn.sanya.bov.util.mongodbUtil;

import com.mongodb.util.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MetailUtils {
    private final static Logger logger = LoggerFactory.getLogger(MetailUtils.class);

    private final static String file_type = "1";//1电子，0纸

    /**功能：把上传的文件组都放到List<Map<String,String>里，并把文件传到浪潮去
     * 把上传的文件整合，一个map装一个文件的信息 :原文件名 fileName，上传后返回的标志信息 uuid ，下载地址：docid
     * 一个map一个文件，一个list是一组文件（list里都是map）
     * @param file
     * @param userId
     * @return
     */
    public static List<Map<String, String>> getUploadFile(MultipartFile[] file, String userId){
        List<Map<String, String>> files = new ArrayList<>();//一个材料里放文件组
        try{}catch (StringIndexOutOfBoundsException e){}
        for (MultipartFile f : file) {//把上传的文件都写到map集合中
            String fn = f.getOriginalFilename();
            String suffix = null;
            try{
                suffix = fn.substring(fn.lastIndexOf("."));
            }catch (StringIndexOutOfBoundsException e){
                logger.error("没有选中文件就上传");
                return null;
            }
            Map<String, String> m = new HashMap<String, String>();//存文件信息
            String fileName = System.currentTimeMillis() + suffix; //System.currentTimeMillis() +
            File upFile = new File(fileName);
            try {
                f.transferTo(upFile);
            } catch (IOException e) {
                logger.debug("=============写入临时文件失败=================");
                return null;
            }
            Map<String, String> params = new HashMap<String, String>();//上传材料所需要的参数
            params.put("uid", userId);//用户id
            params.put("type", "doc");//写死
            params.put("folder_name", "//");//写死
            String upInfo = UploadUtil.up(params, upFile);//调用浪潮接口
            JSONObject json = JSONObject.fromObject(JSON.parse(upInfo));
            if (!"0000".equals(json.getString("code"))) {
                logger.error("上传数据到浪潮失败！");
            }
            String uuid = json.getString("uuid");
            String docid = json.getString("docid");
            m.put("fileName", fileName);
            m.put("uuid", uuid);
            m.put("docid", docid);
            files.add(m);//把文件信息遍历放到list中
        }
        return files;
    }

    //方便回显已经上传过的材料有那些 ，存文件名
    public static List<Map<String, String>> getFileNameList(MultipartFile[] file, List<Map<String, String>> beforeList){
        for (MultipartFile f : file) {//把上传的文件都写到map集合中
            Map<String, String> map =  new HashMap<>();
            String fn = f.getOriginalFilename();
            if("".equalsIgnoreCase(fn)) return  null;
            map.put("fileName",fn);
            if(beforeList==null) {
                beforeList = new ArrayList<>();
            }
            beforeList.add(map);
        }
        return beforeList;
    }

    //遍历材料放到文件数据组中：metails材料信息组，具体材料编码，上传的文件组，存放文件到文件组 ；（第一次上传材料）
    public static void getFilesInfoTFirstSave(JSONArray metails, String metailCode, List<Map<String, String>> files, List<Document> metailList) {
        for (int i = 0; i < metails.size(); i++) {//根据code查出的材料信息
            JSONObject obj = metails.getJSONObject(i);//一个材料信息
            if (obj.containsValue(metailCode)) {//找到文件上传所属的材料，则开始遍历文件组，并存到 list集合
                for (Map<String, String> tempMap : files) {
                    Document metail = new Document();
                    metail.put("id", metailCode);
                    metail.put("name", obj.getString("NAME"));
                    metail.put("fileName", tempMap.get("fileName"));
                    metail.put("uptime", System.currentTimeMillis());
                    metail.put("docId", tempMap.get("docid"));
                    metail.put("type", file_type);
                    metail.put("uuid", tempMap.get("uuid"));
                    metail.put("docPath", UploadUtil.SERVER_LOAD + "?doc_id=" + tempMap.get("docid"));
                    metailList.add(metail);//存文件到文件组中
                }
                break;//结束文件的遍历
            }
        }
    }

//第二次上传 ，把上传从材料整合成要存到数据库的形式 ，files：上传的文件组，metailCode：材料编码 ，temp：材料信息，metailList：最后整合成的材料数组
    public static void getFilesInfoToSecondSave(List<Map<String, String>> files, String metailCode, JSONObject temp, List<Map<String, String>> metailList){
        for (Map<String, String> docMap : files) {//遍历上传的文件，保存到metailList中
            Map<String, String> metail = new HashMap<String, String>();
            metail.put("id", metailCode);
            metail.put("name", temp.getString("NAME"));
            metail.put("fileName", docMap.get("fileName"));
            metail.put("uptime", String.valueOf(System.currentTimeMillis()));
            metail.put("docId", docMap.get("docid"));
            metail.put("type", file_type);
            metail.put("uuid", docMap.get("uuid"));
            metail.put("docPath", UploadUtil.SERVER_LOAD + "?doc_id=" + docMap.get("docid"));
            metailList.add(metail);
        }
    }
}
