package com.dao;

import com.model.UserInfo;

/**
 * @author mVentus
 *
 */
public interface UserInfoDao extends GenericDao<UserInfo, String>{
	
	public UserInfo getUserInfoFromUserId(String userId);
	
}
