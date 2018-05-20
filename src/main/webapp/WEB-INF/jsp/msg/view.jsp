<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 설정(모바일 화면 설정) -->
<meta name="viewport"	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />

<!-- jQuery mobile관련 CDN 연결  -->
<link rel="stylesheet"	href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
<link rel="stylesheet" href="<c:url value='/css/theme-classic.css'/>" />
<link rel="stylesheet"	href="<c:url value='/css/list.css'/>" />
<link rel="stylesheet"	href="<c:url value='/css/base.css'/>" />
<link rel="stylesheet"	href="<c:url value='/css/login.css'/>" />

<!-- jQuery 라이브러리 연결후 jQuery mobile 라이버러리 연결 -->
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>

<title>조달관리 시스템</title>

<%@ include file="/include/session.jsp"%>
<script>
	
	function GetDateFormat(flag, date, zeroplus){
		var result ="";
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		var hour = date.getHours();
		var minute = date.getMinutes();
		var second = date.getSeconds();
		
		if(zeroplus ==1){
			if(parseInt(month) <10)month ='0'+month;
			if(parseInt(day) <10) day = '0' + day;
			if(parseInt(hour) <10) hour = '0' + hour;
			if(parseInt(minute) <10) minute = '0' + minute;
			if(parseInt(second) <10) second = '0' + second;
		}
		
		switch(flag){
			case 1:result = year + "." + month + "." + day; break;
			case 2:result = year + "-" + month + "-" + day; break;
			case 3:result = year + "년 " + month + "월 " + day + "일" ; break;
			case 4:result = year + "." + month + "." + day + " "+ hour +":" +minute; break;
			case 5:result = year + "." + month + "." + day + " "+ hour +":" +minute+":" +second; break;
			default: result = ""; break;
		}
		return result;
	}
	
</script>
</head>


<body>
	<div class="my-page" id="demo-page" data-role="page" data-theme="a" >
		<div data-role="header"data-position="fixed">
			<a href="javascript:history.back();" class="ui-btn ui-corner-all ui-shadow ui-icon-home ui-btn-icon-left">목록</a>
		    <h1>문서함</h1>
		    <a href="#" class="ui-btn-right ui-btn ui-corner-all ui-shadow ui-btn-icon-left ui-icon-refresh" onclick="location.reload()">새로고침</a>
		</div>
		<div data-role="main" class="ui-content"  data-theme="a">
				<div class="ui-body ui-body-c ui-corner-all" id="ui-body-test" style="margin-bottom: 1em;">
					 <p style="font-size: 0.8em">${msgView.msg}</p>
					 <p class="ui-li-aside" style="font-size: 0.8em"><strong>발신일시 : ${msgView.send_dt}</strong></p>
				</div>
		</div>
		<div class="ui-footer ui-bar-a ui-footer-fixed slideup" role="contentinfo" data-role="footer" data-theme="a" data-position="fixed">
			<div class="ui-navbar" role="navigation" data-role="navbar" data-iconpos="top">
				<ul class="ui-grid-c">
					<li class="ui-block-a"><a class="ui-btn" data-icon="info" href="#" onclick="location.href='<c:url value='/notice/list.do'/>'">공지사항</a></li>
					<li class="ui-block-b"><a class="ui-btn ui-btn-active" data-icon="mail" href="#" onclick="location.href='<c:url value='/msg/list.do'/>'">문서함</a></li>
					<li class="ui-block-c"><a class="ui-btn" data-icon="search" href="#" onclick="location.href='<c:url value='/bid/list.do'/>'">공고현황</a></li>
					<li class="ui-block-d"><a class="ui-btn" data-icon="power" data-transition="pop" data-rel="popup" data-position-to="window" href="#logoutDialog">로그아웃</a></li>
				</ul>
			</div><!-- /navbar -->
		</div>
		<%@ include file="/include/logout.jsp"%>
	</div>
</body>
</html>