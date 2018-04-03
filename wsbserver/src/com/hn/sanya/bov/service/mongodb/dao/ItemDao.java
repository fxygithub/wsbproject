package com.hn.sanya.bov.service.mongodb.dao;

import org.bson.Document;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import java.util.List;

public interface ItemDao {
   /**@param colName
    * 无条件查询所有
    * */
   List<Document> findAll(String colName) ;
   /***
    * @param page
    * @param colName
    * 查询当前页的显示数据
    */
   List<Document> findByPage(int page, String colName) ;

   /**
    *
    * @param query
    * @param colName
    * @return
    * @throws Exception
    * 根据条件查询所有
    */
   List<Document> findItems(Query query, String colName) ;

   /**
    *
    * @param query
    * @param colName
    * @return
    * @throws Exception
    * 根据当前条件查询一个
    */
   Document findOne(Query query, String colName);

   /**
    *
    * @param document
    * @param colName
    * @return
    * @throws Exception
    * 插入一个
    */

  int insertOne(Document document, String colName) ;

   /**
    *
    * @param query
    * @param colName
    * @return
    * @throws Exception
    * 删除满足条件的数据
    *
    */
   int deleteItem(Query query, String colName) ;

   /**
    *
    * @param query
    * @param update
    * @param collectionName
    */
   void updateOne(Query query, Update update, String collectionName) ;

    /**
     * 根据条件查出并更新字段
     * @param queryPro 条件字段名
     * @param queryVal 条件值
     * @param updatePro 更新字段
     * @param updateVal 更新字段值
     * @param colName 更新的表名
     * @return
     */
    boolean updateOnePropertyByOtherProperty(String queryPro,String queryVal,String updatePro, String updateVal,String colName);
}
