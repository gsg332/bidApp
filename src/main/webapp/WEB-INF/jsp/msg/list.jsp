<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<a href="<c:url value='/login.jsp'/>" class="ui-btn ui-corner-all ui-shadow ui-icon-home ui-btn-icon-left">메인</a>
		    <h1>문서함</h1>
		    <a href="#" class="ui-btn-right ui-btn ui-corner-all ui-shadow ui-btn-icon-left ui-icon-refresh" onclick="location.reload()">새로고침</a>
		</div>
		<div data-role="main" class="ui-content"  data-theme="a">
	       <c:forEach var="msgList" items="${msgList}" varStatus="status">
				<div class="ui-body ui-body-c ui-corner-all" id="ui-body-test" style="margin-bottom: 1em;">
					 <p style="font-size: 0.8em">${msgList.msg}</p>
					 <p class="ui-li-aside" style="font-size: 0.8em"><strong>발신일시 : ${msgList.send_dt}</strong></p>
				</div>
			</c:forEach>
			<font color="red">참가신청은 투찰 요청 드리는 것이 아닙니다.<br />투찰공고는 공고현황에서 확인 부탁드립니다.</font>
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
 --%>
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
<link rel="stylesheet"	href="<c:url value='/css/jquery.mobile-1.4.0.css'/>" />
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
	
	function msgView(msgId){
		location.href = "/bidmobile/msg/view.do?message_id="+msgId;
	}

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

	var cName;
	var message_id;
	var bid_notice_no;
	var bid_notice_cha_no;
	var confirm_yn ="N";
	function setParam(className,messageId,bidNoticeNo, bidNoticeChaNo){
		cName=className;
		message_id=messageId;
		bid_notice_no=bidNoticeNo;
		bid_notice_cha_no=bidNoticeChaNo;
		if(className.hasClass("ui-icon-check")){
			confirm_yn = "Y";
		}else{
			confirm_yn = "N";
		}
	}
	
	
	function chgChk(val){
		if(val=='yes'){
			$(cName).removeClass("ui-btn-a");
			$(cName).addClass("ui-btn-e");
			$(cName).addClass("ui-icon-check");
		}else{
			$(cName).removeClass("ui-btn-e");
			$(cName).addClass("ui-btn-a");
			$(cName).removeClass("ui-icon-check");
		}
	}
	
	function saveConfirm(val){
		$.mobile.loading( "show" );
		
		$.ajax({ 
		    type: "GET"
		   ,url: "<c:url value='/msg/saveMsg.do'/>"
		   ,async: false 
		   ,data : {
			   	message_id : message_id,
				bid_notice_no : bid_notice_no,
				bid_notice_cha_no :bid_notice_cha_no,
				confirm_yn :(val=="yes"?"Y":"N")
			}
		   ,dataType: "json"
		   ,success:function(json){
				$.mobile.loading( "hide" );
				chgChk(val);
		   }
		});
	}
	
	function chkSet(cs,val){
		if(val=="Y"){
			$(cs).removeClass("ui-btn-a");
			$(cs).addClass("ui-btn-e");
			$(cs).addClass("ui-icon-check");
		}else{
			$(cs).removeClass("ui-btn-e");
			$(cs).addClass("ui-btn-a");
			$(cs).removeClass("ui-icon-check");
		}
	}
	
</script>
</head>


<body>
	<div class="my-page" id="demo-page" data-role="page" data-theme="a" >
		<div data-role="header"data-position="fixed">
			<a href="<c:url value='/bid/list.do'/>" class="ui-btn ui-corner-all ui-shadow ui-icon-home ui-btn-icon-left">메인</a>
		    <h1>문서함</h1>
		    <a href="#" class="ui-btn-right ui-btn ui-corner-all ui-shadow ui-btn-icon-left ui-icon-refresh" onclick="location.reload()">새로고침</a>
		</div>
		<div data-role="main" class="ui-content">
			<font color="yellow">참가신청은 투찰 요청 드리는 것이 아닙니다.<br />투찰공고는 공고현황에서 확인 부탁드립니다.</font>
		    <ul data-role="listview" data-inset="true" data-split-theme="a" data-split-icon="" >
		      <c:forEach var="msgList" items="${msgList}" varStatus="status" step="1">
			      <li <c:if test="${msgList.important_yn eq 'Y'}">data-theme="e"</c:if>>
			        <a href="javascript:msgView('${msgList.message_id}');" data-transition="pop" data-rel="popup" data-position-to="window">
				        <p style="float: left;white-space: normal;">
				        	${msgList.msg}<br /><strong>발신일시 : ${msgList.send_dt}</strong>
				        </p>
			        </a>
			        <a href="#popupDialog" id="chkBtn${status.count}" data-transition="pop" data-rel="popup" data-position-to="window" onClick="setParam(this,'${msgList.message_id}','${msgList.bid_notice_no}','${msgList.bid_notice_cha_no}')"></a>
			        <c:if test="${msgList.confirm_yn == 'Y'}">
				        <script>
				        	$("#chkBtn"+${status.count}).removeClass("ui-btn-b");
							$("#chkBtn"+${status.count}).addClass("ui-btn-e");
							$("#chkBtn"+${status.count}).addClass("ui-icon-check");
				        </script>
			        </c:if>
			      </li>
			</c:forEach>
		    </ul>	    
		</div>
		<div id="popupDialog" style="max-width: 400px;" data-role="popup" data-theme="c" data-overlay-theme="a" data-dismissible="false">
		    <div data-role="header" data-theme="a">
		    <h1>문서확인</h1>
		    </div>
		    <div class="ui-content" role="main">
		        <h3 class="ui-title">문서를 확인하시겠습니까?</h3>
<!-- 		    	<p>This action cannot be undone.</p> -->
					<div class="ui-grid-a">
					    <div class="ui-block-a"><a class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-check ui-btn-icon-left " href="#" data-transition="flow" data-rel="back" onClick="saveConfirm('yes')">확인</a></div>
					    <div class="ui-block-b"><a class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left " href="#" data-rel="back" onClick="saveConfirm('cancel')">취소</a></div>
					</div>	
		    </div>
		</div>
				
		<div class="ui-footer ui-bar-a ui-footer-fixed slideup" role="contentinfo" data-role="footer" data-theme="a" data-position="fixed">
			<div class="ui-navbar" role="navigation" data-role="navbar" data-iconpos="top">
				<ul class="ui-grid-c">
					<li class="ui-block-a"><a class="ui-btn" data-icon="info" href="<c:url value='/notice/list.do'/>" data-ajax="false">공지사항</a></li>
					<li class="ui-block-b"><a class="ui-btn ui-btn-active" data-icon="mail" href="<c:url value='/msg/list.do'/>" data-ajax="false">문서함</a></li>
					<li class="ui-block-c"><a class="ui-btn" data-icon="search" href="<c:url value='/bid/list.do'/>" data-ajax="false">공고현황</a></li>
					<li class="ui-block-d"><a class="ui-btn" data-icon="power" data-transition="pop" data-rel="popup" data-position-to="window" href="#logoutDialog">로그아웃</a></li>
				</ul>
			</div><!-- /navbar -->
		</div>
		<%@ include file="/include/logout.jsp"%>
	</div>
</body>
</html>
 