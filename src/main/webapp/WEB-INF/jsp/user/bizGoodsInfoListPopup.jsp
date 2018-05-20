<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="<c:url value='/css/login.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/jquery.mobile.datepicker.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/jquery.mobile.datepicker.theme.css'/>" />
<!-- jQuery 라이브러리 연결후 jQuery mobile 라이버러리 연결 -->
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>
<script src="<c:url value='/jquery/jquery-ui/datepicker.js'/>"></script>

<title>회원 가입</title>
<script>
	$(function(){
		
		$("#bizGoodsInfoListPopup").page({
			history : false
		});
		$("#bizGoodsInfoListPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				initGoodsInfoList();
			},
			"pagehide":function(event,ui){
				$(event.target).remove();
			}
		});
	});
</script>
</head>

<body>
	
	<div id="bizGoodsInfoListPopup" data-role="page" data-changeHash="false" data-change-hash="false" data-reverse="false" data-changeHash="false" data-ajax="false" data-history="false">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-position="fixed" data-theme="a">
        <h1>등록세부품명</h1>
        </div>
        <div role="main" class="ui-content">
			<div data-role="content">
				<div>
					<div class="ui-grid-b">
						<div class="ui-block-a" style="width:38%; float:left;">
							<label for="goodsNo" class="ui-hidden-accessible">세부품명번호</label>
							<input type="text" name="goodsNo" id="goodsNo" placeholder="세부품명번호" value="">
						</div>
						<div class="ui-block-b" style="width:38%; margin-left:10px;">
							<label for="goodsNn" class="ui-hidden-accessible">세부품명</label>
							<input type="text" name="goodsNm" id="goodsNm" placeholder="세부품명" value="">
						</div>
						<div class="ui-block-c" style="width:10%; margin-left:10px;">
							<a href="#" onclick="searchBizGoodsInfoList()" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b" style="position: relative; top: 5px;">검색</a>
						</div>
					</div>
					<div data-role="controlgroup" data-type="horizontal" data-mini="true" style="text-align: right;">
						<a href="#goodsInfoListPopup" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b" data-prefetch="true" data-direction="reverse" data-role="button" data-transition="flow">추가</a>
					    <a href="#" onclick="deleteGoodsInfoList();" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-minus ui-btn-b">삭제</a>
					</div>
				</div> 
			    <ul id="bizGoodsInfoListView" data-role="listview" data-inset="true" data-filter="false" data-filter-placeholder="" data-theme="a"></ul>
			    <div style="text-align: center;">
					<button onclick="saveGoodsInfoList();" class="ui-btn ui-btn-b">저장</button>
				</div>
			</div>
        </div>
    </div>
    
</body>
</html>
