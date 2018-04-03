package com.hn.sanya.bov.service.mongodb.service;

import org.bson.Document;
import org.springframework.data.mongodb.core.query.Query;

public interface UserService {
	int insert(Document document, String colName);//插入数据

    Document findUserByOpenId(String openId,String colName);//通过openId查找用户
	Document findUserByUserName(String userName,String colName);//通过用户名查询用户
	Document findUserByQuery(Query query, String colName);//根据条件查询用户

	boolean updateUserStatusByUserName(String userName,String colName);//根据用户名更新用户状态
	boolean updateUserOnePropertyByUsername(String userName,String propertyName,String newValue,String colName);//根据用户名更新用户某一个属性值
}
