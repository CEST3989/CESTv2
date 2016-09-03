/**
 * 
 */
package com.dao.hibernate;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dao.UserInfoDao;
import com.model.UserInfo;

/**
 * @author mVentus
 *
 */
public class UserInfoDaoHibernate extends GenericDaoHibernate<UserInfo, String> implements UserInfoDao{
	
	private static Log log = LogFactory.getLog(UserInfoDaoHibernate.class);
	
	public UserInfoDaoHibernate() {
		super(UserInfo.class);
	}

	@Override
	public UserInfo getUserInfoFromUserId(String userId) {
		List<UserInfo> infos =  getHibernateTemplate().find("from UserInfo where userId = ?", userId);
		if(infos != null && infos.size() > 0){
			return infos.get(0);
		}
		return null;
	}
	
	
}
