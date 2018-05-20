<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 설정(모바일 화면 설정) -->
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />

<!-- jQuery mobile관련 CDN 연결  -->
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
<link rel="stylesheet" href="<c:url value='/css/theme-classic.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/list.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/base.css'/>" />

<!-- jQuery 라이브러리 연결후 jQuery mobile 라이버러리 연결 -->
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>

<title>조달관리 시스템</title>
<%@ include file="/include/session.jsp"%>
</head>


<body>
	<div id="detail-page" data-role="page" data-theme="a" >
		<div data-role="header" data-position="fixed">
			<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left"  data-direction="reverse">이전</a>
			<h1>가격산정하기</h1>
		</div>
		
		
		<div data-role="main" class="ui-content">
			<div class="ui-body ui-body-c ui-corner-all" id="ui-body-test" style="margin-bottom: 1em;font-size: 0.75em">
				<table class="dtl_table">
					<tr>
						<td class="title ui-corner-all" style="width: 30%;max-width: 200px"><label for="name3">기초금액</label></td>
						<td>
							<div style="float: left;width: 90%;">
								<input name="base_price" id="base_price" type="text" value="" placeholder="기초금액" data-clear-btn="true" onKeypress="return isNumberKey(this,event)" onKeyUp="test(this)" >
							</div>
							<label style="float: right;">원</label>
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td class="title ui-corner-all" style="width: 30%;max-width: 200px"><label for="name3">예정가격</label></td> -->
<!-- 						<td> -->
<!-- 							<input name="pre_price" id="pre_price" type="text" value="" placeholder="예정가격" data-clear-btn="true" >원 -->
<!-- 						</td> -->
<!-- 					</tr> -->
					<tr>
						<td class="title ui-corner-all" style="width: 30%;max-width: 200px"><label for="name3">낙찰하한율</label></td>
						<td>
							<div style="float: left;width: 90%;">
								<input name="cont_point" id="cont_point" type="text" value="" placeholder="낙찰하한율" data-clear-btn="true" onKeypress="return isNumberKey(this,event)"  onkeyup="sum()">
							</div>
							<label style="float: right;">%</label>
						</td>
					</tr>
					<tr>
						<td class="title ui-corner-all" style="width: 30%;max-width: 200px"><label for="name3">사정율</label></td>
						<td>
							<div style="display: inline;">
								<input name="point" id="point" type="text" value="" placeholder="**사정율 : 예비가격/기초금액" data-clear-btn="true" onKeypress="return isNumberKey(this,event)" onkeyup="sum()">
								<label>**사정율 : 예비가격/기초금액</label>
							</div>
						</td>
					</tr>
				</table>
				<script>

				function savePrice(){
					$.mobile.loading( "show" );
					
					$.ajax({ 
					    type: "GET"
					   ,url: "<c:url value='/bid/saveBid.do'/>"
					   ,async: false 
					   ,data : {
							bid_notice_no : "${bidInfo.bid_notice_no}",
							bid_notice_cha_no :"${bidInfo.bid_notice_cha_no}",
							confirm_yn : 'Y',
							choice_price : $("#value").text().replaceAll(",","")
						}
					   ,dataType: "json"
					   ,success:function(json){
							$.mobile.loading( "hide" );
						   location.href = "<c:url value='/bid/list.do'/>";
					   }
					});
				}
				</script>
			</div>
			<font style="font-size: 1.2em">투찰금액 :<font id="value" color="#ff0000" style="font-weight: bold; "></font>원</font>
			<label style="font-size: 0.8em;color: gray">**투찰금액 = 기초금액 × 사정율 × 낙찰하한율</label>
		</div>
		<div class="ui-footer ui-bar-a ui-footer-fixed slideup" role="contentinfo" data-role="footer" data-theme="a" data-position="fixed">
			<div class="ui-navbar" role="navigation" data-role="navbar" data-iconpos="top">
				<ul class="ui-grid-c">
					<li class="ui-block-a"><a class="ui-btn" data-icon="info" href="#" onclick="location.href='<c:url value='/notice/list.do'/>'">공지사항</a></li>
					<li class="ui-block-b"><a class="ui-btn" data-icon="mail" href="#" onclick="location.href='<c:url value='/msg/list.do'/>'">문서함</a></li>
					<li class="ui-block-c"><a class="ui-btn ui-btn-active" data-icon="search" href="#" onclick="location.href='<c:url value='/bid/list.do'/>'">공고현황</a></li>
					<li class="ui-block-d"><a class="ui-btn" data-icon="power" data-transition="pop" data-rel="popup" data-position-to="window" href="#logoutDialog">로그아웃</a></li>
				</ul>
			</div><!-- /navbar -->
		</div>
		<%@ include file="/include/logout.jsp"%>
	</div>
</body>
</html>
