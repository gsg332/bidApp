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
<script>
	//나라장터 링크 팝업
	function popupDetail(link){
		var xleft= screen.width * 0.4;
		var xmid= screen.height * 0.4;
		window.open(link, "popup", "width=850,height=800,scrollbars=1", true)
	}
</script>
</head>


<body>
	<div id="detail-page" data-role="page" data-theme="a" >
		<div data-role="header" data-position="fixed">
			<a href="<c:url value="/bid/list.do"/>" class="ui-btn ui-corner-all ui-shadow ui-icon-carat-l ui-btn-icon-left" onclick="" data-ajax="true">이전</a>
			<h1>공고상세</h1>
		</div>
		
		<div data-role="main" class="ui-content">
			<table style="margin: 0px">
				<tr>
					<td style="text-align: center;line-height: 10px">
						<c:choose>
							<c:when test="${bidInfo.bid_site.indexOf('001') >=0}">
						        <img src="<c:url value='/images/bid_title_icon1.png'/>" style="width: 80px;">
							</c:when>
							<c:when test="${bidInfo.bid_site.indexOf('002') >=0}">
						        <img src="<c:url value='/images/bid_title_icon2.png'/>" style="width: 80px;">
							</c:when>
							<c:when test="${bidInfo.bid_site.indexOf('003') >=0}">
						        <img src="<c:url value='/images/bid_title_icon3.png'/>" style="width: 80px;">
							</c:when>
							<c:when test="${bidInfo.bid_site.indexOf('004') >=0}">
						        <img src="<c:url value='/images/bid_title_icon4.png'/>" style="width: 80px;">
							</c:when>
							<c:when test="${bidInfo.bid_site.indexOf('005') >=0}">
						        <img src="<c:url value='/images/bid_title_icon5.png'/>" style="width: 80px;">
							</c:when>
							<c:when test="${bidInfo.bid_site.indexOf('006') >=0}">
						        <img src="<c:url value='/images/bid_title_icon6.png'/>" style="width: 80px;">
							</c:when>
							<c:otherwise>
						        <img src="<c:url value='/images/bid_title_icon8.png'/>" style="width: 80px;">
							</c:otherwise>
						</c:choose>
						<br/>
						<a href="javascript:void(0)" style="font-size: 13px;" onclick="popupDetail('${bidInfo.notice_detail_link}')">자세히 보기</a>
					</td>
					<td style="font-size: 16px;font-weight: bold;vertical-align: top;">
						[제 <fmt:formatNumber value="${bidInfo.rank}" pattern="#######"/> 호]<br/>
						${bidInfo.bid_notice_nm}
					</td>
				</tr>
			</table>
			<c:if test="${bidInfo.finish_status =='F'}">
	        	<img src="<c:url value='/images/end.png'/>" style="position: absolute;top: 40px;left: 0px;width: 60px" >
	       	</c:if>
	       	<c:if test="${bidInfo.finish_status =='C'}">
	        	<img src="<c:url value='/images/ing.png'/>" style="position: absolute;top: 40px;left: 0px;width: 60px" >
	     	</c:if>
			<c:if test="${bidInfo.finish_status =='B'}">
	        	<img src="<c:url value='/images/before.png'/>" style="position: absolute;top: 40px;left: 0px;width: 60px" >
      		</c:if>
			<div style="font-size: 0.75em">
				<div data-role="collapsible" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b">
			        <h3>과업내용</h3>
			        <p>${bidInfo.bid_cont}</p>
				</div>
				<div data-role="collapsible" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b">
			        <h3>일반사항</h3>
					<table class="dtl_table">
						<tr>
							<td class="title ui-corner-all ui-shadow">공고번호</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.bid_notice_no}-${bidInfo.bid_notice_cha_no}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">건명</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.bid_notice_nm}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">물품분류명</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.detail_goods_nm}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">물품분류번호</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.detail_goods_no}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all ui-shadow">공고기관</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.order_agency_nm}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all ui-shadow">수요기관</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.demand_nm}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all ui-shadow">참가가능지역</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.use_area_info}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all ui-shadow">업종제한</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.permit_biz_type_info}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">입찰기간</td>
							<td class="cont ui-corner-all ui-shadow">
								<fmt:parseDate var="bidStartDt" value="${bidInfo.bid_start_dt}" pattern="yyyyMMddHHmm"/>
								<fmt:parseDate var="bidEndDt" value="${bidInfo.bid_end_dt}" pattern="yyyyMMddHHmm"/>
								<fmt:formatDate value="${bidStartDt}" pattern="yyyy.MM.dd HH:mm"/>
								~
								<fmt:formatDate value="${bidEndDt}" pattern="yyyy.MM.dd HH:mm"/>
							</td>
						</tr>
						
						<tr>
							<td class="title ui-corner-all ui-shadow">참가신청마감일시</td>
							<td class="cont ui-corner-all ui-shadow">
								<fmt:parseDate var="bidLicRegDt" value="${bidInfo.bid_lic_reg_dt}" pattern="yyyyMMddHHmm"/>
								<fmt:formatDate value="${bidLicRegDt}" pattern="yyyy.MM.dd HH:mm"/>
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all ui-shadow">개찰일시</td>
							<td class="cont ui-corner-all ui-shadow">
								<fmt:parseDate var="bidOpenDt" value="${bidInfo.bid_open_dt}" pattern="yyyyMMddHHmm"/>
								<fmt:formatDate value="${bidOpenDt}" pattern="yyyy.MM.dd HH:mm"/>
							</td>
						</tr>
					</table>
				</div>
			
				<div data-role="collapsible" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b">
			        <h3>분석요약</h3>
					<table class="dtl_table">
						<tr>
							<td class="title ui-corner-all">추정가격</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.pre_price}
							</td>
						</tr>
						
						<tr>
							<td class="title ui-corner-all">기초금액</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.base_price}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">예가범위</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.s_range} ~ ${bidInfo.e_range} %
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">낙찰하한</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.column5} %
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">리스크요약</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.bid_risk_nm}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">제조사<br/>증권발급여부</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.bid_stock_issue_yn}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">과업기간</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.bid_term}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">업체추정<br/>과업일수</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.bid_num_of_days}
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">투찰기준금액</td>
							<td class="cont ui-corner-all ui-shadow">
								<fmt:formatNumber value="${bidInfo.bid_money}" type="currency" currencySymbol=""/>
							</td>
						</tr>
						<%-- 
						<tr>
							<td class="title ui-corner-all">예상지급조건</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.choice_reason}
							</td>
						</tr>
						 --%>
						<tr>
							<td class="title ui-corner-all">예상마진율</td>
							<td class="cont ui-corner-all ui-shadow">
								수주후 개별공개
							</td>
						</tr>
						<tr>
							<td class="title ui-corner-all">특이사항</td>
							<td class="cont ui-corner-all ui-shadow">
								${bidInfo.bid_sp_cont}
							</td>
						</tr>
					</table>
				</div>
				<div data-role="collapsible" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b">
			        <h3>심사총평</h3>
			        <p>
						${bidInfo.bid_tot_cont}
					</p>
				</div>
				
				<div data-role="collapsible" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="true" data-content-theme="b">
			        <h3>리스크 분석</h3>
					<table class="dtl_table">
						<tr>
							<td class="title ui-corner-all" style="width: 10%">항목</td>
							<td class="title ui-corner-all" style="width: 65%">내용</td>
							<td class="title ui-corner-all" style="width: 10%">확인</td>
							<!-- <td class="title ui-corner-all" style="width: 15%">비고</td> -->
						</tr>
						<tr>
							<td class="title ui-corner-all" rowspan="6">규격<br/>관련</td>
							<td class="cont ui-corner-all ui-shadow">○ 특정 규격, 특정 제조사 제품이 아님</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn1}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 수요처와 규격을 확인함</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn2}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 제조사와 규격을 확인함</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn11}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 인증서, 시험성적서 제출이 필요없음
								확인</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn3}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 필요시 이미 제조사에 서류가 구비되어 있음</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn4}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 필요시 해당 물품 제조와 더불어 발급 예정임</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn5}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="title ui-corner-all" rowspan="4">납품<br/>관련</td>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 실행 담당자와 납기의 적절성 확인</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn6}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 납품장소(납지)가 과다하거나 격오지가 아님</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn7}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 납품조건(상차도, 도착도, 하차도) 확인함</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn8}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 납품시 추가비용 확인함</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn9}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="title ui-corner-all" rowspan="3">기타<br/>리스크 </td>						
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 입찰참가시 특이절차 여부</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn10}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 지난 개찰결과를 확인함</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn14}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
						
						<tr>
							<td class="cont ui-corner-all ui-shadow" style="width: 55%">○ 실행업체의 신용도 분석</td>
							<td class="cont ui-corner-all ui-shadow" style="text-align: center">${riskInfo.risk_yn15}</td>
							<!-- <td class="cont ui-corner-all ui-shadow"></td> -->
						</tr>
					</table>
				</div>
			
				</script>
					<c:if test="${bidInfo.finish_status !='F'}">
						<div>
							<p style="font-weight: bold;">투찰의향</p>
						</div>
						<div style="text-align: center">
							<a class="ui-btn ui-corner-all ui-shadow ui-btn-inline" href="#" onClick="detailPage(1)">네, 가격을 산정하겠습니다.</a>
							<a class="ui-btn ui-corner-all ui-shadow ui-btn-inline" href="#" onClick="detailPage(2)">네, 추천구간을 확인하겠습니다.</a>
							<a class="ui-btn ui-corner-all ui-shadow ui-btn-inline" href="#" onclick="nonChk()">아니오, 투찰하지 않겠습니다.</a>
						</div>
						<script>

		
							function detailPage(type){
								location.href = "<c:url value='/bid/detail"+type+".do?bid_notice_no=${bidInfo.bid_notice_no}&bid_notice_cha_no=${bidInfo.bid_notice_cha_no}'/>"
							}
							
							function nonChk(){
								$.mobile.loading( "show" );
								
								$.ajax({ 
								    type: "GET"
								   ,url: "<c:url value='/bid/nonBid.do'/>"
								   ,async: false 
								   ,data : {
										bid_notice_no : "${bidInfo.bid_notice_no}",
										bid_notice_cha_no :"${bidInfo.bid_notice_cha_no}",
										confirm_yn : 'N'
									}
								   ,dataType: "json"
								   ,success:function(json){
										$.mobile.loading( "hide" );
									   location.href = "<c:url value='/bid/list.do'/>";
								   }
								});
							}
							</script>
			       	</c:if>
					
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
</body>
</html>
