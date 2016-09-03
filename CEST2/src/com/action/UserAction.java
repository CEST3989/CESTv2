package com.action;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.dao.ReportDao;
import com.dao.UserInfoDao;
import com.dao.ZoneDao;
import com.model.Location;
import com.model.Report;
import com.model.UserInfo;
import com.model.Zone;
import com.opensymphony.xwork2.Preparable;
import com.pojo.MapPojo;
import com.pojo.ReportPojo;
import com.util.Config;
import com.util.Log;

public class UserAction extends BaseAction implements Preparable {
	
	private UserInfo userInfo;
	private Logger logger = org.apache.log4j.Logger.getLogger(UserAction.class);
	private Log log = Log.getInstance(UserAction.class);
	private Report report;
	private File reportFile;
	private String reportFileContentType;
	private String reportFileFileName;
	
	private List<UserInfo> userInfoList;
	private List<Zone> zoneList;
	private List<MapPojo>  mapPojos;
	
	
	private Double latitude;
	private Double longitude;
	private List<ReportPojo>  reportPojos; 
	 

	public List<ReportPojo> getReportPojos() {
		return reportPojos;
	}

	public void setReportPojos(List<ReportPojo> reportPojos) {
		this.reportPojos = reportPojos;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public List<MapPojo> getMapPojos() {
		return mapPojos;
	}

	public void setMapPojos(List<MapPojo> mapPojos) {
		this.mapPojos = mapPojos;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public List<UserInfo> getUserInfoList() {
		return userInfoList;
	}

	public void setUserInfoList(List<UserInfo> userInfoList) {
		this.userInfoList = userInfoList;
	}

	public List<Zone> getZoneList() {
		return zoneList;
	}

	public void setZoneList(List<Zone> zoneList) {
		this.zoneList = zoneList;
	}
	
	

	public Report getReport() {
		return report;
	}

	public void setReport(Report report) {
		this.report = report;
	}

	public File getReportFile() {
		return reportFile;
	}

	public void setReportFile(File reportFile) {
		this.reportFile = reportFile;
	}

	public String getReportFileContentType() {
		return reportFileContentType;
	}

	public void setReportFileContentType(String reportFileContentType) {
		this.reportFileContentType = reportFileContentType;
	}

	public String getReportFileFileName() {
		return reportFileFileName;
	}

	public void setReportFileFileName(String reportFileFileName) {
		this.reportFileFileName = reportFileFileName;
	}

	@Override
	public void prepare() throws Exception {
		
	}

	public String login(){
		logger.debug("inside login");
		log.debug("inside login---");
		HttpSession session = getSession();
		String username= (String) session.getAttribute("username");
		if(StringUtils.isNotBlank(username)){
			logger.debug("user is already logined");
			return LOGIN;
		}
		
		UserInfoDao  userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
		logger.debug("userInfoDao:" +userInfoDao);
		List<UserInfo> infos = userInfoDao.getAll();
		boolean login = false;
		logger.debug("userInfo:" + userInfo + ", infos:" + infos);
		if(infos != null && userInfo != null){
			logger.debug("userInfo is not null");
			for(UserInfo info:infos){
				if(info.getUserId().equalsIgnoreCase(userInfo.getUserId()) && info.getPassword().equalsIgnoreCase(userInfo.getPassword())){
					session.setAttribute("username", info.getUserId());
					session.setAttribute("role", info.getType());
					login  = true;
					logger.debug("SUCCESS");
					break;
				}
			}
			
			if(login){
				return SUCCESS;
			}else{
				addActionError("Kindly enter valid username and password");
				logger.debug("FAIL");
			}
			
		}
		
		
		return ERROR;
		
	}
	
	public String viewUsers(){
		logger.debug("inside viewUsers");
		ZoneDao zoneDao = (ZoneDao) Config.getConfig().getBean("zoneDao");
		zoneList = zoneDao.getAll();
		
		UserInfoDao  userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
		userInfoList = userInfoDao.getAll();
		
		return SUCCESS;
		
	}
	// Added by Arpit 		
	public String viewUserReports(){
		logger.debug("inside viewUserReports");
		String userId = (String) getSession().getAttribute("username");
		String role = (String) getSession().getAttribute("role");
		ReportDao reportDao = (ReportDao) Config.getConfig().getBean("reportDao");
		UserInfoDao userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
		try{
			UserInfo userInfo= userInfoDao.getUserInfoFromUserId(userId);
			List<Report>  reports = null;
			if(role.equalsIgnoreCase("A")){
				reports = reportDao.getAll();
			}else if(role.equalsIgnoreCase("U")){
				reports = reportDao.gerReportsByUserPrimaryId(userInfo.getId());
			} 
			
			
			if(reports != null && reports.size() > 0){
				reportPojos = new ArrayList<ReportPojo>();
				for(Report report : reports){
					ReportPojo reportPojo = new ReportPojo();
					reportPojo.setId(String.valueOf(report.getId()));
					reportPojo.setUnit(report.getUnit());
					reportPojo.setYear(report.getYear());
					reportPojo.setComment(report.getComment());
//					reportPojo.setUrl(report.get)
					reportPojos.add(reportPojo);
				}
			}
			
			
			
			
		}catch (Exception e) {
			logger.error("Exception", e);
		}
		return SUCCESS;
	}
	

	public String addUserForm(){
		logger.debug("inside addUserForm, userinfo:" + userInfo);
		
		
		
		return SUCCESS;
		
	}
	public String addUserReport(){
		logger.debug("inside addUserReport, report" + report + ", reportFile "+ reportFile);
		try{
			String userId = (String) getSession().getAttribute("username");
			ReportDao reportDao = (ReportDao) Config.getConfig().getBean("reportDao");
			UserInfoDao userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
			
			UserInfo userInfo= userInfoDao.getUserInfoFromUserId(userId);
			if(userInfo != null){
				logger.debug("userInfo is not null");
				report.setUserInfo(userInfo);
				Location location = new Location();
				location.setType("R");
				location.setLatitude(latitude);
				location.setLongitude(longitude);
				location.setUserInfo(userInfo);
				report.setLocation(location);
				reportDao.save(report);
				logger.debug("Report saved....");
			}
			
			
			
		}catch (Exception e) {
			logger.error("Exception", e);
		}
		return SUCCESS;
	}
	
	public String addUser(){
		logger.debug("inside addUser, userinfo:" + userInfo);
		
		UserInfoDao  userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
		userInfoDao.save(userInfo);
		
		return SUCCESS;
		
	}
	public String searchUser(){
		logger.debug("inside searchUser, userinfo:" + userInfo);
		UserInfoDao  userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
		Map<String,Object> queryParams = new HashMap<String,Object>();

		queryParams.put("name", userInfo.getName().toUpperCase()+"%");

		queryParams.put("type", userInfo.getType().toUpperCase()+"%");

		if(StringUtils.equalsIgnoreCase(userInfo.getParam1(), "select")){
			userInfo.setParam1(StringUtils.EMPTY); 
		}
		queryParams.put("param1", userInfo.getParam1().toUpperCase()+"%");

		queryParams.put("userId", userInfo.getUserId().toUpperCase()+"%");
		
		if(StringUtils.equalsIgnoreCase(userInfo.getZone().getName(), "select")){
			userInfo.getZone().setName(StringUtils.EMPTY); 
		}
		queryParams.put("zone", userInfo.getZone().getName().toUpperCase()+"%");
		
		userInfoList = userInfoDao.findByNamedQuery("findUserRecord", queryParams);
		
		return SUCCESS;
			
	}
	
	public String deleteUser(){
		logger.debug("inside deleteUser, userinfo:" + userInfo);
		UserInfoDao  userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
		userInfoDao.remove(userInfo.getId().toString());
//		viewUsers();
		return SUCCESS;
			
	}
	
	public String viewOnMap(){
		logger.debug("inside viewOnMap, userinfo:" + userInfo);
		
//		UserInfoDao  userInfoDao = (UserInfoDao) Config.getConfig().getBean("userInfoDao");
//		LocationDao  locationDao = (LocationDao) Config.getConfig().getBean("locationDao");
//		userInfoList =  userInfoDao.getAll();
//		
//		for(UserInfo info:userInfoList){
//			if("U".equalsIgnoreCase(info.getType())){
//				MapPojo  mapPojo =  new MapPojo();
//				List<Location> 
//				
//			}
//		}
		
		MapPojo  mapPojo =  new MapPojo();
		mapPojo.setId("2");
		mapPojo.setInfo("Sanjay");
		mapPojo.setLongitude("-87.661236");
		mapPojo.setLatitude("42.002707");
		

		MapPojo  mapPojo1 =  new MapPojo();
		mapPojo1.setId("3");
		mapPojo1.setInfo("Arpit");
		mapPojo1.setLongitude("-87.655167");
		mapPojo1.setLatitude("41.939670");
		

		MapPojo  mapPojo2 =  new MapPojo();
		mapPojo2.setId("4");
		mapPojo2.setInfo("saurav");
		mapPojo2.setLongitude("-87.659916");
		mapPojo2.setLatitude("41.976816");
		
		mapPojos = new ArrayList<MapPojo>();
		mapPojos.add(mapPojo);
		mapPojos.add(mapPojo1);
		mapPojos.add(mapPojo2);
		
		
		
		
		return SUCCESS;
	}
	
	public String addUserReportForm(){
		return  SUCCESS;
	}
}
