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
<link rel="shortcut icon" href="<c:url value='/images/favicon.ico'/>" type="image/x-icon">
<link rel="stylesheet"	href="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.css" />
<link rel="stylesheet" href="<c:url value='/css/theme-classic.css'/>" />
<link rel="stylesheet"	href="<c:url value='/css/list.css'/>" />
<link rel="stylesheet"	href="<c:url value='/css/base.css'/>" />
<link rel="stylesheet"	href="<c:url value='/css/login.css'/>" />

<!-- jQuery 라이브러리 연결후 jQuery mobile 라이버러리 연결 -->
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.0/jquery.mobile-1.4.0.min.js"></script>

<title>조달관리 시스템</title>
<script>
	var typelogin = '<%=loginok%>';

	$(document).ready(function() {
		  if(localStorage.getItem("mepno")!=null){
			  $("input[name=epno]").val(localStorage.getItem("mepno"));
			  /* $("input[name=eppw]").val(localStorage.getItem("meppw")); */
			  
			  /* $("#ckidsave").attr("checked",""); */
		  }
		  
		$("#eppw").keydown(function(key){
		  	if(key.keyCode == 13){
		  		login(); 
			}
		});
		
		if(localStorage.getItem("companyNo")){
			$("#chkIdSave").attr("checked",true).checkboxradio("refresh");
			$("input[name=epno]").val(localStorage.getItem("companyNo"));
		}else{
			$("#chkIdSave").attr("checked",false).checkboxradio("refresh");
		}
	});
	
	function login(){
		  
		  if($("input[name=epno]").val().length==0){
			  alert('아이디를 입력하세요.');
			  return;
		  }
		  if($("input[name=eppw]").val().length==0){
			  alert('비밀번호를 입력하세요.');
			  return;
		  }
		  
		 // alert($("input[name=epno]").val());
		  $.ajax({
			   type: "POST",
			   url: "<c:url value='/user/login.do'/>",
			   //폼 데이터
			   data: {"method":"checkLogin"
				  	  ,"query":"bomManagement.list" 
				  	  ,"epno":$("input[name=epno]").val()
				  	  ,"eppw":$("input[name=eppw]").val()
				  		 
			    },
			   //응답 데이터 포맷
			   dataType:"json",
			   //성공시
			   success: function(obj) 
			   {
			   	   	if(obj.loginOK=='true'){
			   	   		fncheckidsave();
			   	   		idsave();
				   	   	window.location.href="<c:url value='/bid/list.do'/>";
			   		} else {
			   			alert("잘못된 비밀번호 입니다.");
			   		}
			 	  }
			    ,error:function(request,status,error){
		            alert("code:"+request.status+"\n" +"message:" +request.responseText+"\n" +"error:" +error);
		      }  

			});
		  
	  }
	  

	  function logout(){
		  $.ajax({
			   type: "POST",
			   url: "<c:url value='/user/logout.do'/>",
			   //폼 데이터
			   data: {"method":"logout"
				  	  ,"query":"bomManagement.list" 
			    },
			   //응답 데이터 포맷
			   dataType:"json",
			   //성공시
			   success: function(obj) 
			   {
			    			window.location.href="<c:url value='/login.jsp'/>";
			 	}
			    ,error:function(request,status,error){
		            alert("code:"+request.status+"\n" +"message:" +request.responseText+"\n" +"error:" +error);
		      	}  
			});   
		  
	  }
	  
	  function fncSetValue()
	  {
	         localStorage.setItem("mepno",$("input[name=epno]").val());
	         localStorage.setItem("meppw",$("input[name=eppw]").val());
	  }


	  function fncGetValue()
	  {
	      var val = localStorage.getItem("mepno");
	      alert(val);
	  }


	  function fncClear()
	  {
	      localStorage.clear();
	  }


	  function fncheckidsave(){
	  	if($("#ckidsave").is(":checked")){
	  		fncSetValue();
	  	}else {
	  		fncClear();
	  	}
	  }
	  
	  function idsave(){
	  	if($("#chkIdSave").is(":checked")){
	  		localStorage.setItem("companyNo", $("input[name=epno]").val());
	  	}else {
	  		localStorage.removeItem("companyNo");
	  	}
	  }
	  
	  function send_password(){
		  $.ajax({
			   type: "POST",
			   url: "<c:url value='/user/sendPassword.do'/>",
			   //폼 데이터
			   data: {"epno":$("input[name=epno]").val()				  		 
			    },
			   //응답 데이터 포맷
			   dataType:"json",
			   //성공시
			   success: function(obj) 
			   {
			   	   	if(obj.emailOK=='true'){
			   	   		alert(obj.email+"\n해당메일로 1회용 비밀번호가 전송되었습니다.");
			   		} else {
			   			alert("해당 사용자의 메일주소가 등록되어 있지 않습니다. \n담당자에게 연락바랍니다. (070-5075-0252)");
			   		}
			 	  }
			    ,error:function(request,status,error){
		            alert("code:"+request.status+"\n" +"message:" +request.responseText+"\n" +"error:" +error);
		      }  

			});  
	  }
	  
	  function memberJoin(){
		  window.location.href="<c:url value='/user/joinForm.do'/>";
	  }
</script>
</head>


<body>
	<div data-role="page" data-theme="a" >
		<div data-role="main" class="ui-content">
			<div data-role="content" class="content">
			<div style="text-align: center;">
				<img src="<c:url value='/images/logo_small.png'/>" style="width: 300px">
			</div>
		        <input name="epno" id="epno" type="text" placeholder="아이디" value="">
		        <input name="eppw" id="eppw" type="password" data-clear-btn="true" placeholder="비밀번호" value="">
				<!-- <label>
					<input type='checkbox' id="ckidsave" onclick='javascript:fncheckidsave();' style="width:20px" name="ckidsave" value='Y'>자동로그인
				</label> -->
				
				<label>
					<input type='checkbox' id="chkIdSave" style="width:20px" name="ckidsave" style="text-align:center;">ID저장
				</label>
				
				<a class="ui-btn ui-corner-all ui-shadow" href="#" onclick="login()">로그인</a>
				<!-- 
				<a class="ui-btn ui-corner-all ui-shadow" href="#" onclick="send_password()">1회용 비밀번호 받기</a>
				 -->
				<a class="ui-btn ui-corner-all ui-shadow" href="#" onclick="memberJoin()">회원가입</a>
			</div>
		</div>
	</div>
</body>
</html>
