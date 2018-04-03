package com.hn.sanya.bov.service.mongodb.service;

import org.bson.Document;
import org.springframework.data.mongodb.core.query.Query;

import java.util.List;

public interface ItemService {
   List<Document> findAll(String colName) ;//查询所有
   List<Document> findByPage(int page, String colName) ;//根据当前页找下一页数据
   List<Document> findItemBy(Query query, String colName) ;//根据条件查询所有
   Document findOne (Query query, String colName) ;//根据条件查询一个
   int insertOneItem(Document document, String collectionName) ;//插入一个
   void updateFirstItem(String collectionName, Query query, Document document) ;//更新
   void updateByIFindAndDel(String collectionName, Query query, Document document);//更新，实现机制：先删除存在的再插入
   boolean updateOnePropertyByUsername(String queryPro,String queryVal,String propertyName,String newVal,String colName);//更新字段


}
