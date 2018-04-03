package com.hn.sanya.bov.service.mongodb.service.Imp;



import com.hn.sanya.bov.service.mongodb.dao.UserDao;
import com.hn.sanya.bov.service.mongodb.exception.TableNotExistException;
import com.hn.sanya.bov.service.mongodb.service.UserService;
import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service("userServiceImp")
public class UserServiceImp implements UserService {
	private static final Logger logger = LoggerFactory.getLogger(UserServiceImp.class);

	@Autowired
	private UserDao userDao;

	@Override
	public int insert(Document document, String colName) {
	   return  userDao.insert(document,colName);
	}

	@Override
	public Document findUserByOpenId(String openId, String colName) {
		Query query = new Query();
		query.addCriteria(Criteria.where("openId").is(openId));
		return userDao.findUserByQuery(query,colName);
	}

	@Override
	public Document findUserByUserName(String userName, String colName) {
		Query query = new Query();
		query.addCriteria(Criteria.where("userName").is(userName));
		return userDao.findUserByQuery(query,colName);
	}

	@Override
	public Document findUserByQuery(Query query, String colName) {
		return userDao.findUserByQuery(query,colName);
	}


	@Override
	public boolean updateUserStatusByUserName(String userName, String colName) {
		return userDao.updateUserStatusByUsername(userName,colName);
	}

	@Override
	public boolean updateUserOnePropertyByUsername(String userName,String propertyName, String newValue, String colName) {
		return userDao.updateUserOnePropertyByUsername(userName,propertyName,newValue,colName);
	}
}
