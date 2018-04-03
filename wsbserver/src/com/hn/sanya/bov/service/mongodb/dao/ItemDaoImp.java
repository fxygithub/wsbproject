package com.hn.sanya.bov.service.mongodb.dao;

import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ItemDaoImp implements ItemDao {

    private static final Logger logger = LoggerFactory.getLogger(ItemDaoImp.class);

    @Autowired
    private MongoTemplate mongoTemplate;

    public List<Document> findAll(String colName)  {
        return mongoTemplate.findAll(Document.class, colName);
    }

//这里固定每页显示五条数据
    public List<Document> findByPage(int page, String colName) {
        Query query = new Query();
        query.skip((page - 1) * 5);
        query.limit(5);
        return mongoTemplate.find(query, Document.class, colName);
    }

    public List<Document> findItems(Query query, String colName) {
        return mongoTemplate.find(query, Document.class, colName);
    }

    public Document findOne(Query query, String colName)  {
        return mongoTemplate.findOne(query, Document.class, colName);
    }

    public int insertOne(Document document, String colName) {
        if(colName!=null||!"".equals(colName)){
            mongoTemplate.insert(document, colName);
            return 1;
        }

        return 0;
    }

    public int deleteItem(Query query, String colName) {//先找，找到再执行删除
        Document document = findOne(query,colName);
        if(document!=null){
            mongoTemplate.remove(query,colName);
            return 1;
        }
        return 0;

    }

    public void updateOne(Query query, Update update, String collectionName) {
        mongoTemplate.updateFirst(query, update, Document.class,collectionName);
    }

    @Override
    public boolean updateOnePropertyByOtherProperty(String queryPro,String queryVal,String propertyName,String newVal,String colName) {
        try{
            Query query = Query.query(Criteria.where(queryPro).is(queryVal));
            Update update = Update.update(propertyName, newVal);
            mongoTemplate.updateFirst(query,update,Document.class,colName);
            return true;
        }catch (Exception e){
            logger.error("更新字段失败"+e.getMessage());
            return false;}
    }


}
