package com.hn.sanya.bov.service.mongodb.service.Imp;


import com.hn.sanya.bov.service.mongodb.dao.ItemDao;
import com.hn.sanya.bov.service.mongodb.exception.DocumentHasExistException;
import com.hn.sanya.bov.service.mongodb.exception.MinusException;
import com.hn.sanya.bov.service.mongodb.exception.TableNotExistException;
import com.hn.sanya.bov.service.mongodb.service.ItemService;
import org.bson.Document;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("itemService")
public class ItemServiceImp implements ItemService {
    private static final Logger logger= LoggerFactory.getLogger(ItemService.class);

    @Autowired
    private ItemDao itemDao;

//查找所有
    public List<Document> findAll(String colName){
        if(colName==null||"".equals(colName)){
            throw new TableNotExistException("查询所有时，表名不能为空！");
        }
        return itemDao.findAll(colName);

    }

//查询当前页数要显示的数据
    public List<Document> findByPage(int page, String colName){
        if(page<0){
            logger.error("==========根据页码查询出错=====");
            throw new MinusException("分页查询时，页码不能为负数！");
        }
        if (colName == null && "".equals(colName)){
            throw  new TableNotExistException("分页查询时，表名不能为空！");
        }
       return itemDao.findByPage(page,colName);
    }

//根据条件查询所有
    public List<Document> findItemBy(Query query, String colName){
        if(colName==null||"".equals(colName)) {
            throw new TableNotExistException("表名不能为空！");
        }
        return itemDao.findItems(query, colName);
    }

//根据条件找一个
    public Document findOne(Query query, String colName){
        if(colName==null||"".equals(colName)){
            throw new  TableNotExistException("查询所有时，表名不能为空！");
        }
        return itemDao.findOne(query,colName);
    }

//删除
    public int deleteItem(Query query, String colName){
        if(colName==null||"".equals(colName)){
            throw new  TableNotExistException("查询所有时，表名不能为空！");
        }
        return itemDao.deleteItem(query,colName);
    }

//插入，不存在才能插入
    public int insertOneItem(Document document, String collectionName){
        int i=0;
        if (collectionName != null && !"".equals(collectionName) && document != null) {//都不为空
            if (documentIsExist(document,collectionName)) {//数据库中存在这条记录 已存在抛出异常
                logger.error("==========数据库已经存在==========");
                throw  new DocumentHasExistException("数据库已经存在要插入的数据!");
            }
            i = itemDao.insertOne(document,collectionName);
        }
        return i;
    }

//更新，存在才能更新
    public void updateFirstItem(String collectionName, Query query, Document document){
        if(collectionName != null && !"".equals(collectionName) && query != null && document !=null ){
           Document doc = itemDao.findOne(query,collectionName);
            if (doc != null ){
                Update update = new Update();
                for (String key : document.keySet()) {
                    update.set(key,document.get(key));
                }
                itemDao.updateOne(query,update,collectionName);
                logger.info("更新数据成功!");
            }else logger.error("==========根据条件找不到数据，无法实现更新操作！==========");
        }
    }

    //更新，存在就更新，不存在就添加
    public void updateByIFindAndDel(String collectionName, Query query, Document document) {
        Document d = itemDao.findOne(query,collectionName);
        if(d!=null) {
            itemDao.deleteItem(query,collectionName);
            logger.info("数据之前存在，先删除！");
        }
        itemDao.insertOne(document,collectionName);
        logger.info("成功更新数据！");
    }

    @Override
    public boolean updateOnePropertyByUsername(String queryPro,String queryVal,String updatePro, String updateVal,String colName) {
        return itemDao.updateOnePropertyByOtherProperty(queryPro,queryVal,updatePro,updateVal,colName);
    }


    protected boolean documentIsExist(Document document, String collectionName){
        return itemDao.findOne(getQuery(document),collectionName) == null ? false : true;
    }

    protected Query getQuery(Document document){//返回类似：Query: { "metail" : "one" , "name" : "tom"}
        Query query = new Query();
        for (String key : document.keySet()) {
            query.addCriteria(Criteria.where(key).is(document.get(key)));
        }
        return query;
    }

}
