/**
 * 
 */
package com.dao.hibernate;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dao.ReportDao;
import com.model.Report;


/**
 * @author Sanjay
 *
 */
public class ReportDaoHibernate extends GenericDaoHibernate<Report, Integer> implements ReportDao{
	
	private static Log log = LogFactory.getLog(ReportDaoHibernate.class);
	
	public ReportDaoHibernate() {
		super(Report.class);
	}

	@Override
	public List<Report> gerReportsByUserPrimaryId(Integer id) {
		List<Report> list =  getHibernateTemplate().find("from Report where userInfo.id = ?", id);
		
		return list;
	}

	
	
}
