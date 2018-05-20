<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
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
<script src="<c:url value='/jquery/jquery.form.js'/>"></script>
<script src="<c:url value='/jquery/jquery.validate.min.js'/>"></script>
<title>회원 가입</title>
<script>
	var isAddingList = false; 
	
	$(function(){
	    $("#joinForm").validate({
	    	errorPlacement: function(error, element) {
	    		error.css({'cssText':'font-size:11px !important;', 'color':'#ff0000','text-indent':'5px', 'margin-top':'2px'});
	    		var div = $('<div/>',{'class':'invalidTxt'});	    		
	    		div.appendTo(element.parent("div"));
	    		error.appendTo(element.parent("div").find('.invalidTxt'));
	    	},
	        submitHandler : function(){ //유효성 검사를 통과한 후 호출 되는 것 같다.
	            join();
	        },
	        rules : {
	            company_no : {
	            	required : true,
	            	full_num : true,
	            	duplicate : true
	            },
	            company_nm : {
	            	required : true
	            },
	            delegate : {
	            	required : true
	            },
	            address : {
	            	required : true
	            },
	            address_detail : {
	            	required : true
	            },
	            phone_no : {
	            	required : true,
	            	phone_num : true
	            },
	            position : {
	            	required : true
	            },
	            bidmanager : {
	            	required : true
	            },
	            mobile_no : {
	            	required : true,
	            	phone_num : true
	            },
	            email : {
	            	required : true,
	            	email : true
	            },
	            start_dt : {
	            	required : true
	            },
	            bizGoodsInfoList : {
	            	required : true
	            },
	            bizGubunInfoList : {
	            	required : true
	            },
	            bizGoodsDirectList : {
	            	required : true
	            },
	            scale : {
	            	required : true
	            },
	            credit_cd : {
	            	required : true
	            },
	            scale_dt : {
	            	required : true
	            },
	            credit_dt : {
	            	required : true
	            },
	            files : {
	            	required : true
	            }
	        },
	        messages : {
	        	company_no : {
	        		required : '필수입력 사항입니다.',
	        		full_num : $.validator.format("형식에 맞지 않습니다. '-'를 포함해서 입력해 주세요."),
	        		duplicate : '중복확인을 눌러주세요.'
	            },
	            company_nm : {
	            	required : '필수입력 사항입니다.'
	            },
	            delegate : {
	            	required : '필수입력 사항입니다.'
	            },
	            address : {
	            	required : '필수입력 사항입니다.'
	            },
	            address_detail : {
	            	required : '필수입력 사항입니다.'
	            },
	            phone_no : {
	            	required : '필수입력 사항입니다.',
	            	phone_num : $.validator.format("형식에 맞지 않습니다. '-'를 포함해서 입력해 주세요.")
	            },
	            position : {
	            	required : '필수입력 사항입니다.'
	            },
	            bidmanager : {
	            	required : '필수입력 사항입니다.'
	            },
	            mobile_no : {
	            	required : '필수입력 사항입니다.',
	            	phone_num : $.validator.format("형식에 맞지 않습니다. '-'를 포함해서 입력해 주세요.")
	            },
	            email : {
	            	required : '필수입력 사항입니다.',
	            	email : '올바른 이메일 형식이 아닙니다.'
	            },
	            start_dt : {
	            	required : '필수입력 사항입니다.'
	            },
	            bizGoodsInfoList : {
	            	required : '필수입력 사항입니다.'
	            },
	            bizGubunInfoList : {
	            	required : '필수입력 사항입니다.'
	            },
	            bizGoodsDirectList : {
	            	required : '필수입력 사항입니다.'
	            },
	            scale : {
	            	required : '필수입력 사항입니다.'
	            },
	            credit_cd : {
	            	required : '필수입력 사항입니다.'
	            },
	            scale_dt : {
	            	required : '필수입력 사항입니다.'
	            },
	            credit_dt : {
	            	required : '필수입력 사항입니다.'
	            },
	            files : {
	            	required : '필수입력 사항입니다.'
	            }
	        }
	    });
	        
	    $.validator.addMethod("full_num", function (value, element) { 
	        return this.optional(element) || /^[0-9]+[-]+([0-9]+[-]?)*[0-9]$/.test(value);
	    });
	    $.validator.addMethod("phone_num", function (value, element) { 
	        return this.optional(element) || /^\d{2,3}-\d{3,4}-\d{4}$/.test(value);
	    });
	    $.validator.addMethod("duplicate", function (value, element) { 
	        return this.optional(element) || usePossibleBizNo;
	    });
	    
	    $('#files').on('change', function(){
	    	if(this.files.length > 0){
				var error = $('#files').next('.invalidTxt').children('.error');
				error.text('');
				error.hide();
			}
	    });
	    
		$('#checkCompanyNoPopup #company_no').on('keyup', function(){
			var $this = $(this);
			var companyNo = $(this).val();
			
			$('#checkResultTxt').text("");
		   	$('#useCompanyNo').prop('disabled', true);
			$('#checkCompanyNoPopup .invalidTxt').remove();
			
			if(!companyNo){
				var div = $('<div/>',{'class':'invalidTxt'}).css({'cssText':'font-size:11px !important;', 'color':'#ff0000','text-indent':'5px', 'margin-top':'2px'}).text('필수입력 사항입니다.');
				div.appendTo($this.parent("div"));
			}else if(!/^[0-9]+[-]+([0-9]+[-]?)*[0-9]$/.test(companyNo)){
				var div = $('<div/>',{'class':'invalidTxt'}).css({'cssText':'font-size:11px !important;', 'color':'#ff0000','text-indent':'5px', 'margin-top':'2px'}).text("형식에 맞지 않습니다. '-'를 포함해서 입력해 주세요.");
				div.appendTo($this.parent("div"));
			}else{
				checkCompanyNo();
			}
			
		});

		$( document ).bind( 'mobileinit', function(){
			//로딩 위젯에 출력할 임의로 텍스트를 설정합니다.
		 	$.mobile.loader.prototype.options.text = "Loading..."; 
			//로딩위젯에 텍스트를 출력하려면, true 로 해줍니다.
			$.mobile.loader.prototype.options.textVisible = true;
			//a~e 까지 색상테마값을 원하시는 값을 입력합니다.
			$.mobile.loader.prototype.options.theme = "a";
			//html 코드를 넣을 수 있어서, 이미지를 넣거나, 다양한 처리를 하실 수 있습니다.
			$.mobile.loader.prototype.options.html = "<img src=''/>";
		});
		
		$.datepicker.setDefaults({
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear: true,
		    yearSuffix: '년'
		});
		
		$("#start_dt,#scale_dt,#credit_dt,#female_dt").datepicker({
			onSelect : function(dateText, inst){
				var error = $(this).next('.invalidTxt').children('.error');
				error.text('');
				error.hide();
			}
		});

		$("#checkCompanyNoPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				$('#checkCompanyNoPopup #company_no').val($('#joinPage #company_no').val());
				$('#checkCompanyNoPopup #company_no').trigger('keyup');
			},
			"pagehide":function(){
			}
		});

		$("#bizGoodsInfoListPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				initGoodsInfoList();
			},
			"pagehide":function(){
			}
		});
		
		$("#goodsInfoListPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				getGoodsInfoList('pageShow');
				$(window).scroll(function(){
					var scrollHeight = $(window).scrollTop() + $(window).height();
					var documentHeight = $(document).height();
					if(scrollHeight + 300 >= documentHeight){
						if(!isAddingList){
							getGoodsInfoList('addList');
						}
						isAddingList = true;
					}
				});
			},
			"pagehide":function(){
				$('#goodsInfoListPopup #goodsNo').val('');
				$('#goodsInfoListPopup #goodsNm').val('');
				var $goodsInfoListView = $("#goodsInfoListView");
				$goodsInfoListView.empty();
				$goodsInfoListView.listview( "refresh" );
			}
		});
		
		$("#bizGubunInfoListPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				initGubunInfoList();
			},
			"pagehide":function(){
			}
		});
		$("#gubunInfoListPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				getGubunInfoList('pageShow');
				$(window).scroll(function(){
					var scrollHeight = $(window).scrollTop() + $(window).height();
					var documentHeight = $(document).height();
					if(scrollHeight + 300 >= documentHeight){
						if(!isAddingList){
							getGubunInfoList('addList');
						}
						isAddingList = true;
					}
				});
			},
			"pagehide":function(){
				$('#gubunInfoListPopup #cd').val('');
				$('#gubunInfoListPopup #cdNm').val('');
				var $gubunInfoListView = $("#gubunInfoListView");
				$gubunInfoListView.empty();
				$gubunInfoListView.listview( "refresh" );
			}
		});
		
		$("#bizGoodsDirectListPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				initGoodsDirectList();
			},
			"pagehide":function(){
			}
		});
		$("#goodsDirectListPopup").on({
			"pageinit":function(){
			},
			"pageshow":function(){
				getGoodsDirectList('pageShow');
				$(window).scroll(function(){
					var scrollHeight = $(window).scrollTop() + $(window).height();
					var documentHeight = $(document).height();
					if(scrollHeight + 300 >= documentHeight){
						if(!isAddingList){
							getGoodsDirectList('addList');
						}
						isAddingList = true;
					}
				});
			},
			"pagehide":function(){
				$('#goodsDirectListPopup #goodsNo').val('');
				$('#goodsDirectListPopup #goodsNm').val('');
				var $goodsDirectListView = $("#goodsDirectListView");
				$goodsDirectListView.empty();
				$goodsDirectListView.listview( "refresh" );
			}
		});
	});
	
	function checkCompanyNo(){
		$.mobile.loading('show');
		
		$.ajax({ 
		   url: "<c:url value='/user/checkCompanyNo.do'/>"
		   ,async: true 
		   ,data : {company_no:$('#checkCompanyNoPopup #company_no').val()}
		   ,dataType: "json"
		   ,success:function(json){
			   	if(parseInt(json.result) > 0){
				   	$('#checkResultTxt').text("중복된 사업자 번호입니다.");
				   	$('#useCompanyNo').prop('disabled', true);
			   	}else{
					$('#checkResultTxt').text("사용 가능한 사업자 번호입니다.");
					$('#useCompanyNo').prop('disabled', false);
			   	}
				$.mobile.loading( "hide" );
			}
		   ,error: function(request, status, error) {
			   $.mobile.loading( "hide" );
		   }
		});
	}
	
	var usePossibleBizNo;
	function useCompanyNo(){
		$('#joinPage #company_no').val($('#checkCompanyNoPopup #company_no').val());
		usePossibleBizNo = true;
		var error = $('#company_no').next('.invalidTxt').children('.error');
		error.text('');
		error.hide();
		$.mobile.back();
	}

	function initGoodsInfoList(){
		$('#bizGoodsInfoListPopup #goodsNo').val('');
		$('#bizGoodsInfoListPopup #goodsNm').val('');
		var $bizGoodsInfoListView = $('#bizGoodsInfoListPopup ul#bizGoodsInfoListView');
		$bizGoodsInfoListView.empty();
		for(var i=0; i<bizGoodsInfoList.length; i++){
			var goodsNo = bizGoodsInfoList[i].goodsNo;
			var goodsNm = bizGoodsInfoList[i].goodsNm;
			createGoodsInfoList($bizGoodsInfoListView, goodsNo, goodsNm);
		}
		$bizGoodsInfoListView.listview( "refresh" );	
	}
	
	var goodsInfoListPage = 0;
	function getGoodsInfoList(type){
		$.mobile.loading('show');
		var $goodsInfoListView = $("#goodsInfoListView");
		
		if(type == 'pageShow'){
			goodsInfoListPage = 0;
			$goodsInfoListView.empty();
		}else if(type == 'search'){
			goodsInfoListPage = 0;
			$goodsInfoListView.empty();
		}else if(type == 'addList'){
		}
		
		goodsInfoListPage++;
		
		$.ajax({ 
		   url: "<c:url value='/user/goodsInfo.do'/>"
		   ,async: true 
		   ,data : {page:goodsInfoListPage, listCnt:100, goodsNm:$('#goodsInfoListPopup #goodsNm').val(), goodsNo:$('#goodsInfoListPopup #goodsNo').val()}
		   ,dataType: "json"
		   ,success:function(json){
				for(var i=0; i<json.goodsInfoList.length; i++){
					var goodsNo = json.goodsInfoList[i].goods_no;
					var goodsNm = json.goodsInfoList[i].goods_nm;
					createGoodsInfoList($goodsInfoListView, goodsNo, goodsNm);
				}
				$goodsInfoListView.listview( "refresh" );
				isAddingList = false;
				$.mobile.loading( "hide" );
			}
		});
	}

	var bizGoodsInfoList = [];
	function registGoodsInfoList(){
		var $bizGoodsInfoListView = $('#bizGoodsInfoListPopup ul#bizGoodsInfoListView');
		$('#goodsInfoListPopup li').each(function(i,e){
			var $this = $(this);
			if($this.attr('data-icon') == 'minus'){
				var goodsNo = $this.data('goodsNo');
				var goodsNm = $this.data('goodsNm');
				var isDuplicate = false;
				for(var y=0; y<bizGoodsInfoList.length; y++){
					
					if(bizGoodsInfoList[y].goodsNo == goodsNo){
						isDuplicate = true;
					}
				}
				if(!isDuplicate){
					var obj = new Object();
					obj.goodsNo = goodsNo;
					obj.goodsNm = goodsNm;
					bizGoodsInfoList.push(obj);
				}
			}
		});
		$.mobile.back();
	}
	
	function createGoodsInfoList(listView, goodsNo, goodsNm){
		var $li = $('<li/>').attr('data-icon', 'plus');
		var $a = $('<a/>', {href:'#'}).css({'text-align':'center'});
		var $span = $('<span/>', {}).css({'float':'left'});
		var $span2 = $('<span/>', {}).css({'float':'right'});
		$span.appendTo($a);
		$span2.appendTo($a);
		$span.text(goodsNo);
		$span2.text(goodsNm);
		$a.appendTo($li);
		$li.appendTo(listView);
		$li.data('goodsNo', goodsNo);
		$li.data('goodsNm', goodsNm);
		
		function goodsInfoReplaceLi(){
			var $this = $(this);
			
			if($this.attr('data-icon') == 'minus'){
				var $li = $('<li/>').attr('data-icon', 'plus');
				$li.attr('data-theme', 'a')
			}else{
				var $li = $('<li/>').attr('data-icon', 'minus');
				$li.attr('data-theme', 'b')
			}
			$li.on('click', goodsInfoReplaceLi);
			
			var $a = $('<a/>', {href:'#'}).css({'text-align':'center'});
			var $span = $('<span/>', {}).css({'float':'left'});
			var $span2 = $('<span/>', {}).css({'float':'right'});
			$span.appendTo($a);
			$span2.appendTo($a);
			$span.text($this.data('goodsNo'));
			$span2.text($this.data('goodsNm'));
			$a.appendTo($li);
			$li.appendTo(listView);
			$li.data('goodsNo', $this.data('goodsNo'));
			$li.data('goodsNm', $this.data('goodsNm'));
			$this.replaceWith($li);
			listView.listview( "refresh" );
		}
		$li.on('click', goodsInfoReplaceLi);		
	}
	
	function deleteGoodsInfoList(){
		$('#bizGoodsInfoListPopup li').each(function(i,e){
			var $this = $(this);
			if($this.attr('data-icon') == 'minus'){
				var goodsNo = $this.data('goodsNo');
				var goodsNm = $this.data('goodsNm');
				for(var y=0; y<bizGoodsInfoList.length; y++){
					if(bizGoodsInfoList[y].goodsNo == goodsNo){
						bizGoodsInfoList.splice(y,1);
					}
				}
				$this.remove();
			}
		});
	}
	
	function searchBizGoodsInfoList(){
		$('#bizGoodsInfoListPopup li').each(function(i,e){
			var $this = $(this);
			var goodsNo = $this.data('goodsNo');
			var goodsNm = $this.data('goodsNm');
			var $goodsInfoPage = $('#bizGoodsInfoListPopup');
			var goodsNoVal = $goodsInfoPage.find('#goodsNo').val();
			var goodsNmVal = $goodsInfoPage.find('#goodsNm').val();
			if(goodsNo.indexOf(goodsNoVal) > -1 && goodsNm.indexOf(goodsNmVal) > -1){
				$this.show();
			}else{
				$this.hide();
			}
		});
	}
	
	function saveGoodsInfoList(){
		var bizGoodsInfos = ''; 
		for(var i=0; i<bizGoodsInfoList.length; i++){
			bizGoodsInfos += bizGoodsInfoList[i].goodsNm + ', ';
		}
		bizGoodsInfos = bizGoodsInfos.slice(0,-2);
		$('#bizGoodsInfoList').val(bizGoodsInfos);

		if(bizGoodsInfos){
			var error = $('#bizGoodsInfoList').next('.invalidTxt').children('.error');
			error.text('');
			error.hide();
		}
		$.mobile.back();
	}
	
	function deleteAllBizGoodsInfoList(){
		bizGoodsInfoList = [];
		var $bizGoodsInfoListView = $('#bizGoodsInfoListPopup ul#bizGoodsInfoListView');
		$bizGoodsInfoListView.empty();
		$('#bizGoodsInfoList').val('');
	}

	function initGubunInfoList(){
		$('#bizGubunInfoListPopup #cd').val('');
		$('#bizGubunInfoListPopup #cdNm').val('');
		var $bizGubunInfoListView = $('#bizGubunInfoListPopup ul#bizGubunInfoListView');
		$bizGubunInfoListView.empty();
		for(var i=0; i<bizGubunInfoList.length; i++){
			var parentCd = bizGubunInfoList[i].parentCd;
			var parentNm = bizGubunInfoList[i].parentNm;
			var cd = bizGubunInfoList[i].cd;
			var cdNm = bizGubunInfoList[i].cdNm;
			createGubunInfoList($bizGubunInfoListView, parentCd, parentNm, cd, cdNm);
		}
		$bizGubunInfoListView.listview( "refresh" );	
	}
	
	var gubunInfoListPage = 0;
	function getGubunInfoList(type){
		$.mobile.loading( "show" );
		var $gubunInfoListView = $("#gubunInfoListView");
		if(type == 'pageShow'){
			gubunInfoListPage = 0;
			$gubunInfoListView.empty();
		}else if(type == 'search'){
			gubunInfoListPage = 0;
			$gubunInfoListView.empty();
		}else if(type == 'addList'){
		}
		
		gubunInfoListPage++;
		
		$.ajax({ 
		   url: "<c:url value='/user/gubunInfo.do'/>"
		   ,async: true 
		   ,data : {page:gubunInfoListPage, listCnt:100, cdNm:$('#gubunInfoListPopup #cdNm').val(), cd:$('#gubunInfoListPopup #cd').val()}
		   ,dataType: "json"
		   ,success:function(json){
				for(var i=0; i<json.gubunInfoList.length; i++){
					var parentCd = json.gubunInfoList[i].parent_cd;
					var parentNm = json.gubunInfoList[i].parent_nm;
					var cd = json.gubunInfoList[i].cd;
					var cdNm = json.gubunInfoList[i].cd_nm;
					createGubunInfoList($gubunInfoListView, parentCd, parentNm, cd, cdNm);
				}
				$gubunInfoListView.listview( "refresh" );
				isAddingList = false;
				$.mobile.loading( "hide" );
			}
		});
	}

	var bizGubunInfoList = [];
	function registGubunInfoList(){
		var $bizGubunInfoListView = $('#bizGubunInfoListPopup ul#bizGubunInfoListView');
		$('#gubunInfoListPopup li').each(function(i,e){
			var $this = $(this);
			if($this.attr('data-icon') == 'minus'){
				var parentCd = $this.data('parentCd');
				var parentNm = $this.data('parentNm');
				var cd = $this.data('cd');
				var cdNm = $this.data('cdNm');
				var isDuplicate = false;
				for(var y=0; y<bizGubunInfoList.length; y++){
					if(bizGubunInfoList[y].cd == cd){
						isDuplicate = true;
					}
				}
				if(!isDuplicate){
					var obj = new Object();
					obj.parentCd = parentCd;
					obj.parentNm = parentNm;
					obj.cd = cd;
					obj.cdNm = cdNm;
					bizGubunInfoList.push(obj);
				}
			}
		});
		$.mobile.back();
	}
	
	function createGubunInfoList(listView, parentCd, parentNm, cd, cdNm){
		var $li = $('<li/>').attr('data-icon', 'plus');
		var $a = $('<a/>', {href:'#'}).css({'text-align':'center', 'font-size':'12px'});
		//var $span = $('<span/>', {}).css({'width':'18%', 'text-align':'center', 'display':'inline-block', 'float':'left'});
		var $span2 = $('<span/>', {}).css({'width':'20%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
		var $span3 = $('<span/>', {}).css({'width':'25%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
		var $span4 = $('<span/>', {}).css({'width':'50%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
		//$span.appendTo($a);
		$span2.appendTo($a);
		$span3.appendTo($a);
		$span4.appendTo($a);
		//$span.text(parentCd);
		$span2.text(parentNm ? parentNm : + '없음');
		$span3.text(cd);
		$span4.text(cdNm);
		$a.appendTo($li);
		$li.appendTo(listView);
		$li.data('parentCd', parentCd);
		$li.data('parentNm', parentNm);
		$li.data('cd', cd);
		$li.data('cdNm', cdNm);
		
		function gubunInfoReplaceLi(){
			var $this = $(this);
			if($this.attr('data-icon') == 'minus'){
				var $li = $('<li/>').attr('data-icon', 'plus');
				$li.attr('data-theme', 'a')
			}else{
				var $li = $('<li/>').attr('data-icon', 'minus');
				$li.attr('data-theme', 'b')
			}
			$li.on('click', gubunInfoReplaceLi);
			var $a = $('<a/>', {href:'#'}).css({'text-align':'center', 'font-size':'12px'});
			var $span2 = $('<span/>', {}).css({'width':'20%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
			var $span3 = $('<span/>', {}).css({'width':'25%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
			var $span4 = $('<span/>', {}).css({'width':'50%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
			$span2.appendTo($a);
			$span3.appendTo($a);
			$span4.appendTo($a);
			//$span.text($this.data('parentCd'));
			$span2.text($this.data('parentNm') ? $this.data('parentNm') : '없음');
			$span3.text($this.data('cd'));
			$span4.text($this.data('cdNm'));
			$a.appendTo($li);
			$li.appendTo(listView);
			$li.data('parentCd', $this.data('parentCd'));
			$li.data('parentNm', $this.data('parentNm'));
			$li.data('cd', $this.data('cd'));
			$li.data('cdNm', $this.data('cdNm'));
			$this.replaceWith($li);
			listView.listview( "refresh" );
		}
		$li.on('click', gubunInfoReplaceLi);	
	}
	
	function deleteGubunInfoList(){
		$('#bizGubunInfoListPopup li').each(function(i,e){
			var $this = $(this);
			if($this.attr('data-icon') == 'minus'){
				var cd = $this.data('cd');
				var cdNm = $this.data('cdNm');
				for(var y=0; y<bizGubunInfoList.length; y++){
					if(bizGubunInfoList[y].cd == cd){
						bizGubunInfoList.splice(y,1);
					}
				}
				$this.remove();
			}
		});
	}
	
	function searchBizGubunInfoList(){
		$('#bizGubunInfoListPopup li').each(function(i,e){
			var $this = $(this);
			var cd = $this.data('cd');
			var cdNm = $this.data('cdNm');
			var $gubunInfoPage = $('#bizGubunInfoListPopup');
			var cdVal = $gubunInfoPage.find('#cd').val();
			var cdNmVal = $gubunInfoPage.find('#cdNm').val();
			if(cd.indexOf(cdVal) > -1 && cdNm.indexOf(cdNmVal) > -1){
				$this.show();
			}else{
				$this.hide();
			}
		});
	}
	
	function saveGubunInfoList(){
		var bizGubunInfos = ''; 
		for(var i=0; i<bizGubunInfoList.length; i++){
			bizGubunInfos += bizGubunInfoList[i].cdNm + ', ';
		}
		bizGubunInfos = bizGubunInfos.slice(0,-2);
		$('#bizGubunInfoList').val(bizGubunInfos);
		
		if(bizGubunInfos){
			var error = $('#bizGubunInfoList').next('.invalidTxt').children('.error');
			error.text('');
			error.hide();
		}
		$.mobile.back();
	}
	
	function deleteAllBizGubunInfoList(){
		bizGubunInfoList = [];
		var $bizGubunInfoListView = $('#bizGubunInfoListPopup ul#bizGubunInfoListView');
		$bizGubunInfoListView.empty();
		$('#bizGubunInfoList').val('');
	}

	function initGoodsDirectList(){
		$('#bizGoodsDirectListPopup #goodsNo').val('');
		$('#bizGoodsDirectListPopup #goodsNm').val('');
		var $bizGoodsDirectListView = $('#bizGoodsDirectListPopup ul#bizGoodsDirectListView');
		$bizGoodsDirectListView.empty();
		for(var i=0; i<bizGoodsDirectList.length; i++){
			var goodsNo = bizGoodsDirectList[i].goodsNo;
			var goodsNm = bizGoodsDirectList[i].goodsNm;
			var limitDt = bizGoodsDirectList[i].limitDt;
			createGoodsDirectList($bizGoodsDirectListView, goodsNo, goodsNm, limitDt);
		}
		$bizGoodsDirectListView.listview( "refresh" );	
	}
	
	var goodsDirectListPage = 0;
	function getGoodsDirectList(type){
		$.mobile.loading( "show" );
		var $goodsDirectListView = $("#goodsDirectListView");
		if(type == 'pageShow'){
			goodsDirectListPage = 0;
			$goodsDirectListView.empty();
		}else if(type == 'search'){
			goodsDirectListPage = 0;
			$goodsDirectListView.empty();
		}else if(type == 'addList'){
		}
		
		goodsDirectListPage++;
		
		$.ajax({ 
		   url: "<c:url value='/user/goodsDirect.do'/>"
		   ,async: true
		   ,data : {page:goodsDirectListPage, listCnt:100, goodsNm:$('#goodsDirectListPopup #goodsNm').val(), goodsNo:$('#goodsDirectListPopup #goodsNo').val()}
		   ,dataType: "json"
		   ,success:function(json){
				for(var i=0; i<json.goodsDirectList.length; i++){
					var goodsNo = json.goodsDirectList[i].goods_no;
					var goodsNm = json.goodsDirectList[i].goods_nm;
					createGoodsDirectList($goodsDirectListView, goodsNo, goodsNm);
				}
				$goodsDirectListView.listview( "refresh" );
				isAddingList = false;
				$.mobile.loading( "hide" );
			}
		});
	}

	function registGoodsDirectList(){
		var $bizGoodsDirectListView = $('#bizGoodsDirectListPopup ul#bizGoodsDirectListView');
		$('#goodsDirectListPopup li').each(function(i,e){
			var $this = $(this);
			if($this.attr('data-icon') == 'minus'){
				var goodsNo = $this.data('goodsNo');
				var goodsNm = $this.data('goodsNm');
				var limitDt = $this.data('limitDt');
				var isDuplicate = false;
				for(var y=0; y<bizGoodsDirectList.length; y++){
					if(bizGoodsDirectList[y].goodsNo == goodsNo){
						isDuplicate = true;
					}
				}
				if(!isDuplicate){
					var obj = new Object();
					obj.goodsNo = goodsNo;
					obj.goodsNm = goodsNm;
					obj.limitDt = null;
					bizGoodsDirectList.push(obj);
				}
			}
		});
		$.mobile.back();
		$bizGoodsDirectListView.listview( "refresh" );
	}
	
	function createGoodsDirectList(listView, goodsNo, goodsNm, limitDt){
		var $bizGoodsDirectListView = $('#bizGoodsDirectListPopup ul#bizGoodsDirectListView');
		if(listView.attr('id') == 'bizGoodsDirectListView'){
			var $li = $('<li/>').attr('data-icon', 'plus');
			var $a = $('<a/>', {href:'#'}).css({'text-align':'center', 'font-size':'11px'});
			var $span = $('<span/>', {'class':'goodsNo'}).css({'width':'30%', 'text-align':'left', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
			var $span2 = $('<span/>', {'class':'goodsNm'}).css({'width':'32%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial', 'margin-left':'5px'});
			var $span3 = $('<span/>', {}).css({'width':'28%', 'text-align':'right', 'display':'inline-block', 'float':'left', 'white-space':'initial', 'margin-left':'5px'});
			var $limitDtInput = $('<input/>', {'type':'text', 'class':'limitDt', 'data-role':'date','data-inline':'true', 'placeholder':'만료일', 'readonly':'readonly'}).css({'position':'relative','z-index':'99','width':'100%'});
			$limitDtInput.datepicker();
			$limitDtInput.on('click',function(e){
				e.stopPropagation();
			    e.cancelBubble = true;   
				return false;
			});
			$span.appendTo($a);
			$span2.appendTo($a);
			$span.text(goodsNo);
			$span2.text(goodsNm);
			$span3.appendTo($a);
			$limitDtInput.appendTo($span3);
			$limitDtInput.val(limitDt);
			$a.appendTo($li);
			$li.appendTo(listView);
			$li.data('goodsNo', goodsNo);
			$li.data('goodsNm', goodsNm);
			$li.data('limitDt', limitDt);
			function goodsDirectReplaceLi1(){
				var $this = $(this);
				if($this.attr('data-icon') == 'minus'){
					var $li = $('<li/>').attr('data-icon', 'plus');
					$li.attr('data-theme', 'a')
				}else{
					var $li = $('<li/>').attr('data-icon', 'minus');
					$li.attr('data-theme', 'b')
				}
				$li.on('click', goodsDirectReplaceLi1);
				var $a = $('<a/>', {href:'#'}).css({'text-align':'center', 'font-size':'11px'});
				var $span = $('<span/>', {'class':'goodsNo'}).css({'width':'30%', 'text-align':'left', 'display':'inline-block', 'float':'left', 'white-space':'initial'});
				var $span2 = $('<span/>', {'class':'goodsNm'}).css({'width':'32%', 'text-align':'center', 'display':'inline-block', 'float':'left', 'white-space':'initial', 'margin-left':'5px'});
				var $span3 = $('<span/>', {}).css({'width':'28%', 'text-align':'right', 'display':'inline-block', 'float':'left', 'white-space':'initial', 'margin-left':'5px'});
				var $limitDtInput = $('<input/>', {'type':'text', 'class':'limitDt', 'data-role':'date','data-inline':'true', 'placeholder':'만료일', 'readonly':'readonly'}).css({'position':'relative','z-index':'99','width':'100%'});
				$limitDtInput.val(limitDt);
				$limitDtInput.datepicker();
				$limitDtInput.on('click',function(e){
					e.stopPropagation();
				    e.cancelBubble = true;   
					return false;
				});
				$span.appendTo($a);
				$span2.appendTo($a);
				$span.text($this.data('goodsNo'));
				$span2.text($this.data('goodsNm'));
				$span3.appendTo($a);
				$limitDtInput.appendTo($span3);
				$limitDtInput.val($this.find('.limitDt').val());
				$a.appendTo($li);
				$li.appendTo(listView);
				$li.data('goodsNo', $this.data('goodsNo'));
				$li.data('goodsNm', $this.data('goodsNm'));
				$this.replaceWith($li);
				listView.listview( "refresh" );
			}
			$li.on('click', goodsDirectReplaceLi1);
		}else{
			var $li = $('<li/>').attr('data-icon', 'plus');
			var $a = $('<a/>', {href:'#'}).css({'text-align':'center'});
			var $span = $('<span/>', {}).css({'float':'left'});
			var $span2 = $('<span/>', {}).css({'float':'right'});
			$span.appendTo($a);
			$span2.appendTo($a);
			$span.text(goodsNo);
			$span2.text(goodsNm);
			$a.appendTo($li);
			$li.appendTo(listView);
			$li.data('goodsNo', goodsNo);
			$li.data('goodsNm', goodsNm);
			function goodsDirectReplaceLi2(){
				var $this = $(this);
				if($this.attr('data-icon') == 'minus'){
					var $li = $('<li/>').attr('data-icon', 'plus');
					$li.attr('data-theme', 'a')
				}else{
					var $li = $('<li/>').attr('data-icon', 'minus');
					$li.attr('data-theme', 'b')
				}
				$li.on('click', goodsDirectReplaceLi2);
				var $a = $('<a/>', {href:'#'}).css({'text-align':'center'});
				var $span = $('<span/>', {}).css({'float':'left'});
				var $span2 = $('<span/>', {}).css({'float':'right'});
				$span.appendTo($a);
				$span2.appendTo($a);
				$span.text($this.data('goodsNo'));
				$span2.text($this.data('goodsNm'));
				$a.appendTo($li);
				$li.appendTo(listView);
				$li.data('goodsNo', $this.data('goodsNo'));
				$li.data('goodsNm', $this.data('goodsNm'));
				$this.replaceWith($li);
				listView.listview( "refresh" );
			}
			$li.on('click', goodsDirectReplaceLi2);
		}
	}
	
	function deleteGoodsDirectList(){
		$('#bizGoodsDirectListPopup li').each(function(i,e){
			var $this = $(this);
			if($this.attr('data-icon') == 'minus'){
				var goodsNo = $this.data('goodsNo');
				//var goodsNm = $this.data('goodsNm');
				for(var y=0; y<bizGoodsDirectList.length; y++){
					if(bizGoodsDirectList[y].goodsNo == goodsNo){
						bizGoodsDirectList.splice(y,1);
					}
				}
				$this.remove();
			}
		});
	}
	
	function searchBizGoodsDirectList(){
		$('#bizGoodsDirectListPopup li').each(function(i,e){
			var $this = $(this);
			var goodsNo = $this.data('goodsNo');
			var goodsNm = $this.data('goodsNm');
			var $goodsDirectPage = $('#bizGoodsDirectListPopup');
			var goodsNoVal = $goodsDirectPage.find('#goodsNo').val();
			var goodsNmVal = $goodsDirectPage.find('#goodsNm').val();
			if(goodsNo.indexOf(goodsNoVal) > -1 && goodsNm.indexOf(goodsNmVal) > -1){
				$this.show();
			}else{
				$this.hide();
			}
		});
	}
	
	var bizGoodsDirectList = [];
	function saveGoodsDirectList(){
		var bizGoodsDirects = '';
		for(var i=0; i<bizGoodsDirectList.length; i++){
			bizGoodsDirects += bizGoodsDirectList[i].goodsNm + ', ';
			var limitDt = $('ul#bizGoodsDirectListView li').eq(i).find('.limitDt').val();
			if(!limitDt){
				$('#limitDtPopup').popup("open");
				return;
			}
			var currDate = new Date();
			var limitDate = new Date(limitDt + ' 23:59:59');
			if(currDate.getTime() > limitDate.getTime()){
				$('#limitDtPopup').popup("open");
				return;
			}
			bizGoodsDirectList[i].limitDt = limitDt;
		}
		
		bizGoodsDirects = bizGoodsDirects.slice(0,-2);
		$('#bizGoodsDirectList').val(bizGoodsDirects);
		
		if(bizGoodsDirects){
			var error = $('#bizGoodsDirectList').next('.invalidTxt').children('.error');
			error.text('');
			error.hide();
		}
		$.mobile.back();
	}
	
	function deleteAllBizGoodsDirectList(){
		bizGoodsDirectList = [];
		var $bizGoodsDirectListView = $('#bizGoodsDirectListPopup ul#bizGoodsDirectListView');
		$bizGoodsDirectListView.empty();
		$('#bizGoodsDirectList').val('');
	}
	
	function join(){
		$.mobile.loading( "show" );
		var fileSize = $("#files")[0].files.length;
	 	if(fileSize > 4){
	 		alert("최대 4개의 파일까지 가능합니다.");	
	 	}
		var bizGoodsInfos = '';
		for(var i=0; i<bizGoodsInfoList.length; i++){
			bizGoodsInfos += bizGoodsInfoList[i].goodsNo + '^';
		}
		bizGoodsInfos = bizGoodsInfos.slice(0,-1);
		var bizGubunInfos = '';
		for(var i=0; i<bizGubunInfoList.length; i++){
			bizGubunInfos += bizGubunInfoList[i].cd + '^';
		}
		bizGubunInfos = bizGubunInfos.slice(0,-1);
		var bizGoodsDirects = '';
		for(var i=0; i<bizGoodsDirectList.length; i++){
			bizGoodsDirects += bizGoodsDirectList[i].goodsNo + ':' + bizGoodsDirectList[i].limitDt + '^';
		}
		bizGoodsDirects = bizGoodsDirects.slice(0,-1);
		var bizCreditDegrees = '';
		$('#bizCreditDegreesArea input[type=checkbox]').each(function(i,e){
			var $this = $(this);
			if($this.is(':checked')){
				bizCreditDegrees += $this.val() + '^';
			}
		});
		bizCreditDegrees = bizCreditDegrees.slice(0,-1);
		
		$("#bizGoodsInfos").val(bizGoodsInfos);
		$("#bizGubunInfos").val(bizGubunInfos);
		$("#bizGoodsDirects").val(bizGoodsDirects);
		$("#bizCreditDegrees").val(bizCreditDegrees);
	       
        $("#joinForm").ajaxSubmit({
 	    	type: 'post',
 	        url: "<c:url value='/user/join.do'/>",
 	        beforeSend:function(){
            },
            //data: $('#joinForm').serialize(),
 	        dataType: 'json',
 	        processData: false,
            contentType: false,
 	        success: function(data) { 
 	        	if(data.status == '200'){
 	        		$('#joinCompletePopup').popup({
       			  		afterclose: function( event, ui ) {
       			  			location.href = '<c:url value="/login.jsp"/>';
       			  		}
        			});
 	        		$('#joinCompletePopup').popup('open');
 	        	}
 	        	$.mobile.loading( "hide" );
 	        },
 	        complete:function(){
 	        	$.mobile.loading( "hide" );
             },
 	        error: function(request, status, error) {
 	        	$.mobile.loading( "hide" );
 	        },
 	    });
	}
</script>
</head>

<body>
	
	<div id="joinPage" data-role="page">
		<div data-role="header" data-theme="a" enctype="multipart/form-data">
		    <h1>회원가입</h1>
		</div>
		<div data-role="main" class="ui-content">
			<div data-role="content">
				<form name="joinForm" id="joinForm" enctype="multipart/form-data" method="post">
					<input type="hidden" name="bizGoodsInfos" id="bizGoodsInfos" />
					<input type="hidden" name="bizGubunInfos" id="bizGubunInfos" />
					<input type="hidden" name="bizGoodsDirects" id="bizGoodsDirects" />
					<input type="hidden" name="bizCreditDegrees" id="bizCreditDegrees" />
				
					<div style="margin: 15px 0px;">
						* 표시는 필수 입력사항입니다. 
						<div style="color: red;">
							※ 아이디는 관리자 (bid@in-con.biz)의 승인 후 메일로 송부 드립니다.
						</div>
					</div>
					<div style="font-size: 0.75em">
						<div data-role="collapsible" data-inset="false" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b" data-disabled="true">
					        <h3>업체 기본 정보</h3>
							<table class="dtl_table">
								<tr>
									<td class="joinTitle ui-corner-all ui-shadow">*사업자 번호</td>
									<td class="cont ui-corner-all ui-shadow">
										<div class="ui-block-a" style="width: 50%;">
									        <label for="company_no" class="ui-hidden-accessible">사업자 번호</label>
									        <div style="position: relative; top: 3px;">
												<input type="text" name="company_no" id="company_no" placeholder="-를 포함하여 입력" value=""/>
											</div>
									    </div>
									    <div class="ui-block-b">
									    	<!-- <a href="#" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b">Search</a> -->
									    	<a href="#checkCompanyNoPopup" data-role="button" data-inline="true" data-icon="search" data-theme="b" data-mini="true"  data-direction="reverse" data-transition="flow">중복확인</a>
									    </div>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*업체명</td>
									<td class="cont ui-corner-all ui-shadow">
										<label for="company_nm" class="ui-hidden-accessible">업체명</label>
										<input type="text" name="company_nm" id="company_nm" placeholder="법인의 경우 '업체명 (주)'로 표기" value=""/>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*대표자명</td>
									<td class="cont ui-corner-all ui-shadow">
										<label for="delegate" class="ui-hidden-accessible">대표자명</label>
										<input type="text" name="delegate" id="delegate" placeholder="공동대표의 경우 모두 입력(,로 구분)" value=""/>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*업체주소</td>
									<td class="cont ui-corner-all ui-shadow">
										<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
											<label for="address">기본주소 선택</label>
										    <select name="address" id="address" style="z-index:1 !important">
										        <option value="">기본주소 선택</option>
												<c:forEach var="address" items="${addressList}">
											        <option value="${address.cd}">${address.cd_nm}</option>		
												</c:forEach>
										    </select>
										</fieldset>
										<label for="addressDetail" class="ui-hidden-accessible">상세주소</label>
										<input type="text" name="address_detail" id="address_detail" placeholder="상세주소" value="">
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all ui-shadow">*업체전화번호</td>
									<td class="cont ui-corner-all ui-shadow">
										<label for="phoneNo" class="ui-hidden-accessible">업체전화번호</label>
										<input type="text" name="phone_no" id="phone_no" placeholder="업체전화번호" value=""/>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all ui-shadow">*직위/담당자</td>
									<td class="cont ui-corner-all ui-shadow">
										<label for="position" class="ui-hidden-accessible">직위</label>
										<input type="text" name="position" id="position" placeholder="직위" value="">
										<label for="bidmanager" class="ui-hidden-accessible">담당자</label>
										<input type="text" name="bidmanager" id="bidmanager" placeholder="담당자" value=""/>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all ui-shadow">*담당자<br>휴대폰번호</td>
									<td class="cont ui-corner-all ui-shadow">
										<label for="mobileNo" class="ui-hidden-accessible">담당자 휴대폰번호</label>
										<input type="text" name="mobile_no" id="mobile_no" placeholder="담당자 휴대폰번호" value=""/>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all ui-shadow">*담당자<br>E-mail</td>
									<td class="cont ui-corner-all ui-shadow">
										<label for="email" class="ui-hidden-accessible">담당자 E-mail</label>
										<input type="text" name="email" id="email" placeholder="담당자 E-mail" value=""/>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">가입경로</td>
									<td class="cont ui-corner-all ui-shadow">
										<label for="joinRoute" class="ui-hidden-accessible">가입경로</label>
										<input type="text" name="join_route" id="join_route" placeholder="가입경로" value=""/>
									</td>
								</tr>
							</table>
						</div>
					
						<div data-role="collapsible" data-inset="false" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b" data-disabled="true">
					        <h3>업체 상세정보</h3>
							<table class="dtl_table">
								<tr>
									<td class="joinTitle ui-corner-all">*개업일</td>
									<td class="cont ui-corner-all ui-shadow">
										<input type="text" name="start_dt" id="start_dt" data-role="date" data-inline="true" placeholder="개업일" readonly="readonly">
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*제조물품</td>
									<td class="cont ui-corner-all ui-shadow">
										<div class="ui-block-a" style="width: 55%; position: relative; top: 3px;">
									        <input id="bizGoodsInfoList" name="bizGoodsInfoList" type="text" data-inline="true" placeholder="제조물품" readonly="readonly"/>
									    </div>
									    <div class="ui-block-b">
									    	<!-- <a href="#" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b">Search</a> -->
									    	<a href="#bizGoodsInfoListPopup" data-role="button" data-inline="true" data-icon="search" data-iconpos="notext" data-theme="b" data-mini="true"  data-direction="reverse" data-role="button" data-transition="flow">icon only button</a>
											<a href="#" onclick="deleteAllBizGoodsInfoList();" data-role="button" data-inline="true" data-icon="delete" data-iconpos="notext" data-theme="b" data-mini="true">icon only button</a>
									    </div>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*업종</td>
									<td class="cont ui-corner-all ui-shadow">
										<div class="ui-block-a" style="width: 55%; position: relative; top: 3px;">
									        <input id="bizGubunInfoList" name="bizGubunInfoList" type="text" data-inline="true" placeholder="업종" readonly="readonly"/>
									    </div>
									    <div class="ui-block-b">
									    	<a href="#bizGubunInfoListPopup" data-role="button" data-inline="true" data-icon="search" data-iconpos="notext" data-theme="b" data-mini="true">icon only button</a>
											<a href="#" onclick="deleteAllBizGubunInfoList();" data-role="button" data-inline="true" data-icon="delete" data-iconpos="notext" data-theme="b" data-mini="true">icon only button</a>
									    </div>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*직접생산증명서</td>
									<td class="cont ui-corner-all ui-shadow">
										<div class="ui-block-a" style="width: 55%; position: relative; top: 3px;">
									        <input id="bizGoodsDirectList" name="bizGoodsDirectList" type="text" data-inline="true" placeholder="직접생산증명서" readonly="readonly"/>
									    </div>
									    <div class="ui-block-b">
									    	<!-- <a href="#" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b">Search</a> -->
									    	<a href="#bizGoodsDirectListPopup" data-role="button" data-inline="true" data-icon="search" data-iconpos="notext" data-theme="b" data-mini="true">icon only button</a>
											<a href="#" onclick="deleteAllBizGoodsDirectList();" data-role="button" data-inline="true" data-icon="delete" data-iconpos="notext" data-theme="b" data-mini="true">icon only button</a>
									    </div>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*기업구분</td>
									<td class="cont ui-corner-all ui-shadow">
										<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
											<label for="scale_cd">선택</label>
										    <select name="scale" id="scale" style="z-index:1 !important">
										        <option value="">선택</option>
												<c:forEach var="bizType" items="${bizTypeList}">
											        <option value="${bizType.cd}^${bizType.cd_nm}">${bizType.cd_nm}</option>		
												</c:forEach>
										    </select>
										</fieldset>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*신용등급</td>
									<td class="cont ui-corner-all ui-shadow">
										<fieldset data-role="controlgroup" data-type="horizontal" data-mini="true">
											<label for="credit_cd">선택</label>
										    <select name="credit_cd" id="credit_cd" style="z-index:1 !important">
										        <option value="">선택</option>
												<c:forEach var="creditEval" items="${creditEvalList}">
											        <option value="${creditEval.cd}^${creditEval.cd_nm}">${creditEval.cd_nm}</option>		
												</c:forEach>
										    </select>
										</fieldset>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*중소기업확인서 만료일</td>
									<td class="cont ui-corner-all ui-shadow">
										<input type="text" id="scale_dt" name="scale_dt" data-role="date" data-inline="true" placeholder="중소기업확인서 만료일" readonly="readonly"/>
									</td>
								</tr>
								<tr>
									<td class="joinTitle ui-corner-all">*신용등급 만료일</td>
									<td class="cont ui-corner-all ui-shadow">
										<input type="text" id="credit_dt" name="credit_dt" data-role="date" data-inline="true" placeholder="신용등급 만료일" readonly="readonly"/>
									</td>
								</tr>
							</table>
						</div>
						
						<div data-role="collapsible" data-inset="false" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b" data-disabled="true">
		                    <h3>파일첨부</h3>
		                    <table class="dtl_table">
		                        <tr>
		                        	<td class="joinTitle ui-corner-all">*업체기본정보 및 상세보기 증빙자료 첨부하기</td>
		                            <td class="cont ui-corner-all">
										<input id="files" name="files" type="file" multiple="multiple"/>
		                            </td>
		                        </tr>
		                    </table>
						</div>
	
						<div data-role="collapsible" data-inset="false" id="bizCreditDegreesArea" data-expanded-icon="carat-u" data-collapsed-icon="carat-d" data-collapsed="false" data-content-theme="b" data-disabled="true">
					        <h3>신인도</h3>
							<table class="dtl_table">
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">NET,NEP</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="NET,NEP">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">성능인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="성능인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">조달우수제품인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="조달우수제품인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">녹색기술인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="녹색기술인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">서비스품질우수기업인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="서비스품질우수기업인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">특허</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="특허">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">디자인등록</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="디자인등록">
									</td>
								</tr>
								
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">GS인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="GS인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">KS제품인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="KS제품인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">단체표준인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="단체표준인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">고효율에너지기자재인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="고효율에너지기자재인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">GR인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="GR인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">환경표지인증</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="환경표지인증">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">환경친화기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="환경친화기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">에너지소비효율1등급</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="에너지소비효율1등급">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">혁신형 중소기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="혁신형 중소기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">제조기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="제조기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">여성기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="female_yn" value="여성기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">여성기업발급일</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="text" id="female_dt" name="female_dt" data-role="date" data-inline="true" placeholder="여성기업 발급일" readonly="readonly">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">장애인기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="장애인기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">하도급거래모범업체</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="하도급거래모범업체">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">비상대비 중점관리업체</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="비상대비 중점관리업체">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">노사문화우수기업-대상기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="노사문화우수기업-대상기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">노사문화우수기업-우수기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="노사문화우수기업-우수기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">사회적기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="사회적기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">사회적협동조합</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="사회적협동조합">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">모범납세자</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="모범납세자">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">보훈복지단체</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="보훈복지단체">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">가족친화인증기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="가족친화인증기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">고용창출 100대 우수기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="고용창출 100대 우수기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">조달업무 우수업체 표창</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="조달업무 우수업체 표창">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">세계일류상품인증기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="세계일류상품인증기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">수출유망중소기업</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="수출유망중소기업">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">부정당업자</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="부정당업자">
									</td>
								</tr>
								<tr style="height: 40px;">
									<td class="joinTitle ui-corner-all">불공정하도급거래</td>
									<td class="cont ui-corner-all ui-shadow">
							        	<input type="checkbox" name="" value="불공정하도급거래">
									</td>
								</tr>
							</table>
						</div>
					</div>
					<button type="submit" class="ui-btn ui-shadow ui-corner-all ui-btn-b">회원등록</button>
				</form>
				<div data-role="popup" id="joinCompletePopup" data-overlay-theme="b" class="ui-content" data-position-to="window" data-tolerance="15,15" data-corners="false" style="text-align: center;">
			    	<h3>확인</h3>
					<p>
						<div>
							회원가입이 완료되었습니다.
						</div>
					</p>
				</div>
			</div>
		</div>
	</div>
	
    <div id="checkCompanyNoPopup" data-role="page">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-theme="a">
        	<h1>사업자 중복 확인</h1>
        </div>
        <div data-role="main" class="ui-content">
			<div data-role="content">
				<div>
					<label for="company_no" class="ui-hidden-accessible">사업자 번호</label>
					<input type="text" name="company_no" id="company_no" placeholder="사업자 번호" value="">
				</div>
				<div id="checkResultTxt" style="text-align: center; margin: 20px 0px 25px 0px; padding: 5px; font-size: 20px"></div>
				<button id="useCompanyNo" onclick="useCompanyNo();" class="ui-btn ui-btn-b" disabled="disabled">사용</button> 
			</div>
        </div>
    </div>
	
	<div id="bizGoodsInfoListPopup" data-role="page">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-theme="a">
        	<h1>등록세부품명</h1>
        </div>
        <div data-role="main" class="ui-content">
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
    
    <div id="goodsInfoListPopup" data-role="page">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-theme="a">
        	<h1>세부품명목록</h1>
        </div>
        <div data-role="main" class="ui-content">
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
							<a href="#" onclick="getGoodsInfoList('search')" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b" style="position: relative; top: 5px;">검색</a>
						</div>
					</div>
					<div data-role="controlgroup" data-type="horizontal" data-mini="true" style="text-align: right;">
					    <a href="#" onclick="registGoodsInfoList();" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b">등록</a>
					</div>
				</div> 
			    <ul id="goodsInfoListView" data-role="listview" data-inset="true" data-filter="false" data-filter-placeholder="" data-theme="a">
			</div>
        </div>
    </div>
	
	<div id="bizGubunInfoListPopup" data-role="page">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-theme="a">
        	<h1>등록업종</h1>
        </div>
        <div data-role="main" class="ui-content">
			<div data-role="content">
				<div>
					<div class="ui-grid-b">
						<div class="ui-block-a" style="width:38%; float:left;">
							<label for="cd" class="ui-hidden-accessible">업종번호</label>
							<input type="text" name="cd" id="cd" placeholder="업종번호" value="">
						</div>
						<div class="ui-block-b" style="width:38%; margin-left:10px;">
							<label for="cdNm" class="ui-hidden-accessible">업종명</label>
							<input type="text" name="cdNm" id="cdNm" placeholder="업종명" value="">
						</div>
						<div class="ui-block-c" style="width:10%; margin-left:10px;">
							<a href="#" onclick="searchBizGubunInfoList()" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b" style="position: relative; top: 5px;">검색</a>
						</div>
					</div>
					<div data-role="controlgroup" data-type="horizontal" data-mini="true" style="text-align: right;">
						<a href="#gubunInfoListPopup" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b" data-prefetch="true">추가</a>
					    <a href="#" onclick="deleteGubunInfoList();" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-minus ui-btn-b">삭제</a>
					</div>
				</div> 
			    <ul id="bizGubunInfoListView" data-role="listview" data-inset="true" data-filter="false" data-filter-placeholder="" data-theme="a"></ul>
			    <div style="text-align: center;">
					<button onclick="saveGubunInfoList();" class="ui-btn ui-btn-b">저장</button>
				</div>
			</div>
        </div>
    </div>
    
    <div id="gubunInfoListPopup" data-role="page">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-theme="a">
        	<h1>세부업종목록</h1>
        </div>
        <div data-role="main" class="ui-content">
			<div data-role="content">
				<div>
					<div class="ui-grid-b">
						<div class="ui-block-a" style="width:38%; float:left;">
							<label for="cd" class="ui-hidden-accessible">업종번호</label>
							<input type="text" name="cd" id="cd" placeholder="업종번호" value="">
						</div>
						<div class="ui-block-b" style="width:38%; margin-left:10px;">
							<label for="cdNm" class="ui-hidden-accessible">업종명</label>
							<input type="text" name="cdNm" id="cdNm" placeholder="업종명" value="">
						</div>
						<div class="ui-block-c" style="width:10%; margin-left:10px;">
							<a href="#" onclick="getGubunInfoList('search')" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b" style="position: relative; top: 5px;">검색</a>
						</div>
					</div>
					<div data-role="controlgroup" data-type="horizontal" data-mini="true" style="text-align: right;">
					    <a href="#" onclick="registGubunInfoList();" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b">등록</a>
					</div>
				</div> 
			    <ul id="gubunInfoListView" data-role="listview" data-inset="true" data-filter="false" data-filter-placeholder="" data-theme="a">
			</div>
        </div>
   	</div>
    
    <div id="bizGoodsDirectListPopup" data-role="page">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-theme="a">
        	<h1>직접생산물품</h1>
        </div>
        <div data-role="main" class="ui-content">
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
							<a href="#" onclick="searchBizGoodsDirectList()" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b" style="position: relative; top: 5px;">검색</a>
						</div>
					</div>
					<div data-role="controlgroup" data-type="horizontal" data-mini="true" style="text-align: right;">
						<a href="#goodsDirectListPopup" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b" data-prefetch="true">추가</a>
					    <a href="#" onclick="deleteGoodsDirectList();" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-minus ui-btn-b">삭제</a>
					</div>
				</div> 
			    <ul id="bizGoodsDirectListView" data-role="listview" data-inset="true" data-filter="false" data-filter-placeholder="" data-theme="a"></ul>
			    <div style="text-align: center;">
					<button onclick="saveGoodsDirectList();" class="ui-btn ui-btn-b">저장</button>
				</div>
    
			    <div data-role="popup" id="limitDtPopup" data-overlay-theme="b" class="ui-content" data-position-to="window" data-tolerance="15,15" data-corners="false" style="text-align: center;">
			    	<h3>확인</h3>
					<p>
						<div>
							만료일을 입력하지 않았거나 이미 지난 날짜를 입력 하셨습니다.
						</div>
					</p>
				</div>
			</div>
        </div>
    </div>
    
    <div id="goodsDirectListPopup" data-role="page">
        <div data-role="header" data-add-back-btn="true" data-back-btn-text="돌아가기" data-theme="a">
        	<h1>세부품명목록</h1>
        </div>
        <div data-role="main" class="ui-content">
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
							<a href="#" onclick="getGoodsDirectList('search')" class="ui-btn ui-btn-inline ui-shadow ui-corner-all ui-icon-search ui-btn-icon-notext ui-btn-b" style="position: relative; top: 5px;">검색</a>
						</div>
					</div>
					<div data-role="controlgroup" data-type="horizontal" data-mini="true" style="text-align: right;">
					    <a href="#" onclick="registGoodsDirectList();" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b">등록</a>
					</div>
				</div> 
			    <ul id="goodsDirectListView" data-role="listview" data-inset="true" data-filter="false" data-filter-placeholder="" data-theme="a">
			</div>
        </div>
    </div>
    
</body>
</html>
