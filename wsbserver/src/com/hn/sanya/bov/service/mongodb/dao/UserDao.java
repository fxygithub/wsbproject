package com.hn.sanya.bov.service.mongodb.dao;

import org.bson.Document;
import org.springframework.data.mongodb.core.query.Query;

public interface UserDao {
	int insert(Document document, String colName);//插入

	Document findUserByQuery(Query query,String colName);//根据条件查询

	boolean updateUserByQuery(Query query,Document document,String colName);//根据条件更新文档

	boolean updateUserStatusByUsername(String userName,String colName);//更新状态为1
	//找到属性就更新，找不到就添加属性
	boolean updateUserOnePropertyByUsername(String userName,String propertyName,Object o,String colName);
}
