package com.hn.sanya.bov.service.mongodb.dao;
import com.hn.sanya.bov.service.mongodb.exception.DocumentNotExist;
import com.hn.sanya.bov.service.mongodb.exception.TableNotExistException;
import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImp implements UserDao {
	private static final Logger logger = LoggerFactory.getLogger(UserDaoImp.class);

	@Autowired
	private MongoTemplate mongoTemplate;

	@Override
	public int insert(Document document, String colName) {
		if(colName == null || "".equals(colName)){
			logger.error("输入的表名不存在，无法执行插入");
			return 0;
		}else if(document == null ||"".equals(document) ||document.size()<=0){
			logger.error("要插入的数据必须有值");
			return 0;
		}else{
			mongoTemplate.insert(document,colName);
			return 1;
		}

	}

	@Override
	public Document findUserByQuery(Query query, String colName) {
		if(colName == null || "".equals(colName)){
			logger.error("输入的表名必须存在");
			return null;
		}else{
			return mongoTemplate.findOne(query,Document.class,colName);
		}
	}

	@Override
	public boolean updateUserOnePropertyByUsername(String userName,String propertyName, Object o, String colName) {
		Query query = Query.query(Criteria.where("userName").is(userName));
		if(findUserByQuery(query,colName)!=null){
			Update update = Update.update(propertyName, o);
			mongoTemplate.updateFirst(query,update,Document.class,colName);
			return true;
		}else {
			logger.error("找不到用户，无法执行更新操作！");
			return false;
		}
	}

	@Override
	public boolean updateUserStatusByUsername(String userName, String colName) {
		Query query = Query.query(Criteria.where("userName").is(userName));
		if (findUserByQuery(query, colName) != null) {
			Update update = Update.update("status", "1");
			mongoTemplate.updateFirst(query, update, Document.class, colName);
			return true;
		} else {
			logger.error("找不到用户，更新状态属性失败");
			return false;
		}
	}
	@Override
	public boolean updateUserByQuery(Query query,Document document, String colName) {
		if(findUserByQuery(query,colName)!=null){
			for(String key:document.keySet()){
				Update update = Update.update(key,document.getString(key));
				mongoTemplate.updateFirst(query,update,Document.class,colName);
			}
			return true;
		}else {
			logger.error("找不到用户，无法执行更新");
		}
		return false;
	}

}
