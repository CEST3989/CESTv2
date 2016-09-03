/**
 * 
 */
package com.dao.hibernate;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dao.ZoneDao;
import com.model.Zone;


/**
 * @author Sanjay
 *
 */
public class ZoneDaoHibernate extends GenericDaoHibernate<Zone, Integer> implements ZoneDao{
	
	private static Log log = LogFactory.getLog(ZoneDaoHibernate.class);
	
	public ZoneDaoHibernate() {
		
		super(Zone.class);
	}
	
	
}
