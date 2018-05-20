<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script>
	//나라장터 링크 팝업
	function popupDetail(link){
		var xleft= screen.width * 0.4;
		var xmid= screen.height * 0.4;
		window.open(link, "popup", "width=850,height=800,scrollbars=1", true)
	}
	
	function range(type){
		if(type==2){
			$("#rangeTxt").text("98 ~ 102%");
		}else if(type==3){
			$("#rangeTxt").text("97 ~ 103%");
		}
	}
	
	function choiceArea(className, type){
		$("a[name=point]").removeClass("ui-btn-a");
		
		if(type==1){
			$("#pointArea1").css("display","");
			$("#pointArea2").css("display","none");
			$("#pointArea3").css("display","none");
		}else if(type==2){
			$("#pointArea1").css("display","none");
			$("#pointArea2").css("display","");
			$("#pointArea3").css("display","none");
		}else if(type==3){
			$("#pointArea1").css("display","none");
			$("#pointArea2").css("display","none");
			$("#pointArea3").css("display","");
		}
	}
	
	var interval;
	function btnInOut(){
		interval = setInterval(function(){
			$("#autoBtn").fadeIn(500);
			$("#autoBtn").fadeOut(500);
		},1000);
	}
	
	function setPoint(className, val){
		
		$("a").removeClass("ui-btn-e");
		$(className).addClass("ui-btn-e");
		
		$("#point").val(val);
	
		point = val;
		
		sum();
		
		btnInOut();
	}
	
	function setRandam(){
		
		var ran = Math.ceil(Math.random()*1000);
		
		if((""+ran).length==1){
			point2 = "00"+ran;
		}else if((""+ran).length==2){
			point2 = "0"+ran;
		}else{
			point2 = ""+ran;
		}
		
		$("#point").val(point+point2);
		
		sum();
	}
	
	function sum(){
		var base = eval($("#base_price").text().replaceAll(",",""));
		var pre = eval($("#pre_price").text().replaceAll(",",""));
		var cont_point = eval($("#cont_point").text().replaceAll(",",""));
		var point = eval($("#point").val().replaceAll(",",""));
		
		var value = base * parseFloat(point/100) * parseFloat(cont_point/100);
		
		$("#value").text(numberComma(value,","));
	}
	
	var point = "100.0";
	var point2 = "000";
	
</script>
</head>


<body>
	<div id="detail-page" data-role="page" data-theme="a" >
		<div data-role="header" data-position="fixed">
			<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left"  data-direction="reverse">이전</a>
			<h1>가격산정하기</h1>
		</div>
		
		
		<div data-role="main" class="ui-content">
			<ul data-role="listview" data-theme="a" data-inset="true" data-split-theme="a" data-split-icon="info" style="font-size: 0.8em">
			    <li onClick="choiceArea(this,1)">
			        <a href="#">
					<img src="<c:url value='/images/1.png'/>" style="top: 10px;left: 10px;">
			        <h2 style="white-space: normal;">본 구간은 <font color="yellow">49%</font>의 비교적 많은 낙찰자가 선정되는 반면, 
참여 입찰자수가 가장 많은 구간입니다.<br/>
 <font color="yellow">(경쟁률 30:1~80:1)</font>
</h2></a>
			        <a href="#purchase" data-transition="pop" data-rel="popup" data-position-to="window"></a>
			    </li>
			    <li onClick="choiceArea(this,2)">
			        <a href="#">
				    <img src="<c:url value='/images/2.png'/>" style="top: 10px;left: 10px;">
			        <h2 style="white-space: normal;">본 구간은 <font color="yellow">20%</font>의 낙찰자가 가 선정되며, 
참여 입찰자수가 또한 보통인 구간입니다.<br/>
 <font color="yellow">(경쟁률 5:1~30:1)</font>
</h2></a>
			        <a href="#purchase" data-theme="a" data-transition="pop" data-rel="popup" data-position-to="window"></a>
			    </li>
			    <li onClick="choiceArea(this,3)">
			        <a href="#">
				    <img src="<c:url value='/images/3.png'/>" style="top: 10px;left: 10px;">
			        <h2 style="white-space: normal;">본 구간은 <font color="yellow">10%</font>의 비교적 적은 낙찰자가 선정되는 반면, 
참여 입찰자수가 가장 적은 구간입니다.<br/>
 <font color="yellow">(경쟁률 30:1~80:1)</font>
</h2></a>
			        <a href="#purchase" data-theme="a" data-transition="pop" data-rel="popup" data-position-to="window"></a>
			    </li>
			</ul>
			<div id="pointArea1" style="font-size: 0.6em">
				<div class="ui-grid-d">
				    <div class="ui-block-a"><a name="point" val="99.5" class="ui-shadow ui-btn ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.5')">99.5</a></div>
				    <div class="ui-block-b"><a name="point" val="99.6" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.6')">99.6</a></div>
				    <div class="ui-block-c"><a name="point" val="99.7" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.7')">99.7</a></div>
				    <div class="ui-block-d"><a name="point" val="99.8" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.8')">99.8</a></div>
				    <div class="ui-block-e"><a name="point" val="99.9" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.9')">99.9</a></div>
				</div>
				<div class="ui-grid-d">
				    <div class="ui-block-a"><a name="point" val="100.0" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.0')">100.0</a></div>
				    <div class="ui-block-b"><a name="point" val="100.1" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.1')">100.1</a></div>
				    <div class="ui-block-c"><a name="point" val="100.2" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.2')">100.2</a></div>
				    <div class="ui-block-d"><a name="point" val="100.3" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.3')">100.3</a></div>
				    <div class="ui-block-e"><a name="point" val="100.4" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.4')">100.4</a></div>
				</div>
			</div>
			<div id="pointArea2" style="display: none;font-size: 0.6em ">
				<div class="ui-grid-d">
				    <div class="ui-block-a"><a name="point" val="99.0" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.0')">99.0</a></div>
				    <div class="ui-block-b"><a name="point" val="99.1" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.1')">99.1</a></div>
				    <div class="ui-block-c"><a name="point" val="99.2" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.2')">99.2</a></div>
				    <div class="ui-block-d"><a name="point" val="99.3" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.3')">99.3</a></div>
				    <div class="ui-block-e"><a name="point" val="99.4" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'99.4')">99.4</a></div>
				</div>
				<div class="ui-grid-d">
				    <div class="ui-block-a"><a name="point" val="100.5" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.5')">100.5</a></div>
				    <div class="ui-block-b"><a name="point" val="100.6" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.6')">100.6</a></div>
				    <div class="ui-block-c"><a name="point" val="100.7" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.7')">100.7</a></div>
				    <div class="ui-block-d"><a name="point" val="100.8" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.8')">100.8</a></div>
				    <div class="ui-block-e"><a name="point" val="100.9" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'100.9')">100.9</a></div>
				</div>
			</div>
			<div id="pointArea3" style="display: none;font-size: 0.6em ">
				<div class="ui-grid-d">
				    <div class="ui-block-a"><a name="point" val="98.0" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.0')">98.0</a></div>
				    <div class="ui-block-b"><a name="point" val="98.1" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.1')">98.1</a></div>
				    <div class="ui-block-c"><a name="point" val="98.2" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.2')">98.2</a></div>
				    <div class="ui-block-d"><a name="point" val="98.3" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.3')">98.3</a></div>
				    <div class="ui-block-e"><a name="point" val="98.4" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.4')">98.4</a></div>
				</div>
				<div class="ui-grid-d">
				    <div class="ui-block-a"><a name="point" val="98.5" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.5')">98.5</a></div>
				    <div class="ui-block-b"><a name="point" val="98.6" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.6')">98.6</a></div>
				    <div class="ui-block-c"><a name="point" val="98.7" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.7')">98.7</a></div>
				    <div class="ui-block-d"><a name="point" val="98.8" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.8')">98.8</a></div>
				    <div class="ui-block-e"><a name="point" val="98.9" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'98.9')">98.9</a></div>
				</div>
				<div class="ui-grid-d">
				    <div class="ui-block-a"><a name="point" val="101.0" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'101.0')">101.0</a></div>
				    <div class="ui-block-b"><a name="point" val="101.1" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'101.1')">101.1</a></div>
				    <div class="ui-block-c"><a name="point" val="101.2" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'101.2')">101.2</a></div>
				    <div class="ui-block-d"><a name="point" val="101.3" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'101.3')">101.3</a></div>
				    <div class="ui-block-e"><a name="point" val="101.4" class="ui-shadow ui-btn ui-corner-all" href="#" onClick="setPoint(this,'101.4')">101.4</a></div>
				</div>
			</div>
			<script>

			
			</script>
			<div class="ui-body ui-body-b ui-corner-all" id="ui-body-test" style="font-size: 0.9em">
				<table  class="dtl_table">
					<tr>
						<td rowspan="4">
							<a id="autoBtn" class="ui-shadow ui-btn ui-btn-a ui-corner-all "  href="#" style="width:60px;height: 60px;"  onClick="setRandam()">둘째자리 <br/>이하<br/>자동선택</a>
						</td>
						<td style="text-align: center;width: 40%">
							<b>기초금액</b>
						</td>
						<td style="width: 40%">
							<font id="base_price"><fmt:formatNumber value="${fn:replace(bidInfo.base_price, ',', '')}" type="currency" currencySymbol=""/></font>원
						</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<b>예정가격</b>
						</td>
						<td style="width: 40%">
							<font id="pre_price"><fmt:formatNumber value="${fn:replace(bidInfo.pre_price, ',', '')}" type="currency" currencySymbol=""/></font>원
						</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<b>낙찰하한율</b>
						</td>
						<td style="width: 40%">
							<font id="cont_point">${bidInfo.column5}</font>%
						</td>
					</tr>
					<tr>
						<td style="text-align: center;">
							<b>사정율의 범위</b>
						</td>
						<td style="width: 40%">
						<font style="display:inline-block; float: left;vertical-align: middle;margin-right: 5px" id="rangeTxt">
							<font id="sRange">${bidInfo.s_range}</font> ~ <font id="eRange">${bidInfo.e_range}</font>%
						</font>
<!-- 							<select name="slider-flip-m" id="slider-flip-m" data-role="slider" data-mini="true" onchange="range(this.value)"> -->
<!-- 							    <option value="2" selected="">±2</option> -->
<!-- 							    <option value="3">±3</option> -->
<!-- 							</select> -->
						</td>
					</tr>
				</table>
				<div>
					<label class="title ui-corner-all" style="width: 30%;max-width: 200px">사정율</label>
					<input name="point" id="point" type="text" placeholder="** 사정율 : 예비가격/기초금액 " value="" data-clear-btn="true" onkeyup="sum()">
				</div>
				<font style="font-size: 1.2em">투찰금액 :<font id="value" color="#ff0000" style="font-weight: bold; "></font>원</font>
				<label style="font-size: 0.8em;color: gray">**투찰금액 = 기초금액 × 사정율 × 낙찰하한율</label>
					<a class="ui-shadow ui-btn ui-btn-a ui-corner-all" href="#"  onClick="savePrice()">가격저장</a>
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
	<script>

	<c:forEach var="bidRange" items="${bidRange}" varStatus="status" step="1">
				$("[val='${bidRange.range}']").addClass("ui-btn-d");
	</c:forEach>
	</script>
</body>
</html>
