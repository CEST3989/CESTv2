/**
 * 
 */
package com.dao.hibernate;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dao.LocationDao;
import com.model.Location;


/**
 * @author Sanjay
 *
 */
public class LocationDaoHibernate extends GenericDaoHibernate<Location, Integer> implements LocationDao{
	
	private static Log log = LogFactory.getLog(LocationDaoHibernate.class);
	
	public LocationDaoHibernate() {
		super(Location.class);
	}

	@Override
	public List<Location> getLocationsByUserId(Integer userId) {
		List<Location> list = getHibernateTemplate().find("from com.model.Location where userInfo.id=? ", userId);
		return list;
	}
	
	
}
