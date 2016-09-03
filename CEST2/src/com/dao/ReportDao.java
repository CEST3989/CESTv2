package com.dao;

import java.util.List;

import com.model.Report;


/**
 * @author Sanjay
 *
 */
public interface ReportDao extends GenericDao<Report, Integer>{
	
	public List<Report> gerReportsByUserPrimaryId(Integer id);
}
