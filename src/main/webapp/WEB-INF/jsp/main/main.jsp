<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
<%
	String loginId = (String) session.getAttribute("loginid");
	String loginok = (String) session.getAttribute("loginOK");
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 설정(모바일 화면 설정) -->
<meta name="viewport"	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />

<!-- jQuery mobile관련 CDN 연결  -->
<link rel="stylesheet"	href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
<link rel="stylesheet"	href="<c:url value='/css/base.css'/>" />

<!-- jQuery 라이브러리 연결후 jQuery mobile 라이버러리 연결 -->
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>

<title>조달관리 시스템</title>
<script>
var typelogin = '<%=loginok%>';

	$(document).ready(function() {

		if (typelogin == 'true') {
			// 		location.href="<c:url value='/admin/bidnotice/main.do'/>";
		}
	});
</script>
</head>


<body>
	<div data-role="page" id="demo-page">
		<div data-role="header">
			<h1>공고리스트</h1>
		</div>
		<div class="ui-content" role="main">
	        <ul data-role="listview" data-inset="true">
	            <li><a href="#">
	                <img class="ui-li-thumb" src="../_assets/img/apple.png">
	                <h2>공지사항</h2>
<!-- 	                <p>Apple released iOS 6.1</p> -->
<!-- 	                <p class="ui-li-aside">iOS</p> -->
	            </a></li>
	            <li><a href="#">
	                <img class="ui-li-thumb" src="../_assets/img/blackberry_10.png">
	                <h2>공고현황</h2>
<!-- 	                <p>BlackBerry launched the Z10 and Q10 with the new BB10 OS</p> -->
<!-- 	                <p class="ui-li-aside">BlackBerry</p> -->
	            </a></li>
	        </ul>
	    </div><!-- /content -->

	</div>
</body>
</html>
