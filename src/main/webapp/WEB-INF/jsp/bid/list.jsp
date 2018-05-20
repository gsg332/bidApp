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

	var cName;
	var bid_notice_no;
	var bid_notice_cha_no;
	var bid_yn ="N";
	function setParam(className,bidNoticeNo, bidNoticeChaNo){
		cName=className;
		bid_notice_no=bidNoticeNo;
		bid_notice_cha_no=bidNoticeChaNo;
		if($(className).hasClass("ui-icon-check")){
			bid_yn = "Y";
		}else{
			bid_yn = "N";
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
		   ,url: "<c:url value='/bid/saveBid.do'/>"
		   ,async: false 
		   ,data : {
				bid_notice_no : bid_notice_no,
				bid_notice_cha_no :bid_notice_cha_no,
				bid_yn :(val=="yes"?"Y":"N")
			}
		   ,dataType: "json"
		   ,success:function(json){
				$.mobile.loading( "hide" );
				//$('#eventBidCnt').text(json.eventBidCnt);
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
	
	//나라장터 링크 팝업
	function popupDetail(link){
		var xleft= screen.width * 0.4;
		var xmid= screen.height * 0.4;
		window.open(link, "popup", "width=850,height=800,scrollbars=1", true)
	}
</script>
</head>


<body>
	<div class="my-page" id="demo-page" data-role="page" data-theme="a" >
		<div data-role="header" data-position="fixed">
<%-- 			<a href="<c:url value='/login.jsp'/>" class="ui-btn ui-corner-all ui-shadow ui-icon-home ui-btn-icon-left">메인</a> --%>
		    <h1>공고현황</h1>
		    <a href="<c:url value='/bid/detail3.do'/>" class="ui-btn-left ui-btn ui-corner-all ui-shadow ui-btn-icon-left ui-icon-info" onclick="">가격산정툴</a>
		    <a href="#" class="ui-btn-right ui-btn ui-corner-all ui-shadow ui-btn-icon-left ui-icon-refresh" onclick="location.reload()">새로고침</a>
		</div>
		<div data-role="main" class="ui-content">
			<%-- 
			<div>
				<span>누적 투찰 개수 :</span>
				<span id="eventBidCnt">${eventBidCnt}</span>
				<span>
					<span>[</span>
					<span id="eventStartDate"><fmt:formatDate value="${lastEventInfo.start_date}" pattern="yyyy.MM.dd"/></span>
					<span>~</span>
					<span id="eventEndDate"><fmt:formatDate value="${lastEventInfo.end_date}" pattern="yyyy.MM.dd"/></span>
					<span>]</span>
				</span>
			</div>
			 --%>
		    <ul data-role="listview" data-inset="true" data-split-theme="a" data-split-icon="" >
		      <c:forEach var="bidList" items="${bidList}" varStatus="status" step="1">
			      <li <c:if test="${bidList.important_yn eq 'Y'}">data-theme="e"</c:if>>
			        <a href="<c:url value='/bid/detail.do?bid_notice_no=${bidList.bid_notice_no}&bid_notice_cha_no=${bidList.bid_notice_cha_no}'/>">
				        <c:choose>
							<c:when test="${bidList.bid_site.indexOf('001') >=0}">
						        <img src="<c:url value='/images/bid_title_icon1.png'/>" style="top: 30px;left: 10px;width: 100px;" >
							</c:when>
							<c:when test="${bidList.bid_site.indexOf('002') >=0}">
						        <img src="<c:url value='/images/bid_title_icon2.png'/>" style="top: 30px;left: 10px;width: 100px;"  >
							</c:when>
							<c:when test="${bidList.bid_site.indexOf('003') >=0}">
						        <img src="<c:url value='/images/bid_title_icon3.png'/>" style="top: 30px;left: 10px;width: 100px;"  >
							</c:when>
							<c:when test="${bidList.bid_site.indexOf('004') >=0}">
						        <img src="<c:url value='/images/bid_title_icon4.png'/>" style="top: 30px;left: 10px;width: 100px;"  >
							</c:when>
							<c:when test="${bidList.bid_site.indexOf('005') >=0}">
						        <img src="<c:url value='/images/bid_title_icon5.png'/>" style="top: 30px;left: 10px;width: 100px;"  >
							</c:when>
							<c:when test="${bidList.bid_site.indexOf('006') >=0}">
						        <img src="<c:url value='/images/bid_title_icon6.png'/>" style="top: 30px;left: 10px;width: 100px;"  >
							</c:when>
							<c:otherwise>
						        <img src="<c:url value='/images/bid_title_icon8.png'/>" style="top: 30px;left: 10px;width: 100px;"  >
							</c:otherwise>
						</c:choose>
						<div style="width: 100px;text-align: center;">
							<font style="width: 100px;position: absolute;top: 110px;left: 0px;font-size: 12px;color: yellow">
								<c:if test="${bidList.confirm_yn == 'Y'}">
									<fmt:formatNumber value="${bidList.choice_price}" type="currency" currencySymbol=""/>
								</c:if>
								<c:if test="${bidList.confirm_yn == 'N'}">
								X
								</c:if>
							</font>
						</div>
						<c:if test="${bidList.finish_status =='F'}">
				        	<img src="<c:url value='/images/end.png'/>" style="position: absolute;top: 0px;left: 0px;width: 60px" >
			        	</c:if>
			        	<c:if test="${bidList.finish_status =='C'}">
				        	<img src="<c:url value='/images/ing.png'/>" style="position: absolute;top: 0px;left: 0px;width: 60px" >
			      		</c:if>
			        	<c:if test="${bidList.finish_status =='B'}">
				        	<img src="<c:url value='/images/before.png'/>" style="position: absolute;top: 0px;left: 0px;width: 60px" >
			      		</c:if>
						<c:if test="${ fn:length(bidList.note)>0}">
				        	<font style="position: absolute;top: 5px;left: 100px;font-size: 12px;color: red">
				        		${bidList.note}
				        	</font>	
			        	</c:if>
						<c:if test="${ fn:length(bidList.open_rank)>0}">
				        	<font style="position: absolute;top: 5px;left: 100px;font-size: 12px;color: yellow">
				        		${bidList.open_rank} 위
				        	</font>	
			        	</c:if>
				        <h2>${bidList.bid_notice_nm}</h2>
				        <p style="float: left;white-space: normal;">
				        	공고번호: ${bidList.bid_notice_no}-${bidList.bid_notice_cha_no}<br/>
				        	발주처명 : ${bidList.order_agency_nm}<br/>
				        	입찰마감 : 
			        	    <fmt:parseDate var="bidStartDt" value="${bidList.bid_start_dt}" pattern="yyyyMMddHHmm"/>
							<fmt:parseDate var="bidEndDt" value="${bidList.bid_end_dt}" pattern="yyyyMMddHHmm"/>
							<fmt:formatDate value="${bidEndDt}" pattern="yyyy.MM.dd HH:mm"/><br/>
							비고 : ${bidList.company_bigo}
				        </p>
			        </a>
			        <a href="#popupDialog" id="chkBtn${status.count}" data-theme="<c:if test="${bidList.important_yn eq 'Y'}">e</c:if>" data-rel="popup" data-position-to="window" onClick="setParam(this,'${bidList.bid_notice_no}','${bidList.bid_notice_cha_no}')"></a>
			        <c:if test="${bidList.bid_yn == 'Y'}">
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
		    <h1>투찰상태변경</h1>
		    </div>
		    <div class="ui-content" role="main">
		        <h3 class="ui-title">투찰여부를 변경하시겠습니까?</h3>
<!-- 		    	<p>This action cannot be undone.</p> -->
					<div class="ui-grid-a">
					    <div class="ui-block-a"><a class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-check ui-btn-icon-left " href="#" data-transition="flow" data-rel="back" onClick="saveConfirm('yes')">투찰</a></div>
					    <div class="ui-block-b"><a class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left " href="#" data-rel="back" onClick="saveConfirm('cancel')">취소</a></div>
					</div>	
		    </div>
		</div>
				
		<div class="ui-footer ui-bar-a ui-footer-fixed slideup" role="contentinfo" data-role="footer" data-theme="a" data-position="fixed">
			<div class="ui-navbar" role="navigation" data-role="navbar" data-iconpos="top">
				<ul class="ui-grid-c">
					<li class="ui-block-a"><a class="ui-btn" data-icon="info" href="<c:url value='/notice/list.do'/>" data-ajax="false">공지사항</a></li>
					<li class="ui-block-b"><a class="ui-btn" data-icon="mail" href="<c:url value='/msg/list.do'/>" data-ajax="false">문서함</a></li>
					<li class="ui-block-c"><a class="ui-btn ui-btn-active" data-icon="search" href="<c:url value='/bid/list.do'/>" data-ajax="false">공고현황</a></li>
					<li class="ui-block-d"><a class="ui-btn" data-icon="power" data-transition="pop" data-rel="popup" data-position-to="window" href="#logoutDialog">로그아웃</a></li>
				</ul>
			</div><!-- /navbar -->
		</div>
		<%@ include file="/include/logout.jsp"%>
	</div>
</body>
</html>
