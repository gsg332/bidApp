<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%
 String loginId=(String)session.getAttribute("loginid");
 String loginok=(String)session.getAttribute("loginOK");
  
  %>
  
<link rel="shortcut icon" href="<c:url value='/images/favicon.ico'/>" type="image/x-icon">

<script type="text/javascript" src='<c:url value='/jquery/formatter.js'/>' ></script>
<script>
	var typelogin = '<%=loginok%>';
	if(typelogin=='null' || typelogin=='false'){
		location.href="<c:url value='/login.jsp'/>";
	}
</script>
