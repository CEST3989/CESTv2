<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<spring:htmlEscape defaultHtmlEscape="true"></spring:htmlEscape>
<%
   response.setHeader( "Pragma", "no-cache" );
   response.setDateHeader( "Expires", 0 );

   response.setHeader("X-FRAME-OPTIONS","SAMEORIGIN");
   response.setHeader( "Cache-Control" , "no-cache");
%>


<%
   response.setHeader( "Pragma", "no-cache" );
   response.setHeader( "Cache-Control", "no-cache" );
   response.setDateHeader( "Expires", 0 );
   response.setHeader("X-FRAME-OPTIONS","SAMEORIGIN");

 %>


<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="datePattern"><fmt:message key="date.format"/></c:set>