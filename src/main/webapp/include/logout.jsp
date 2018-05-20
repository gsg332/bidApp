<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script>
	    function logout(val){
			$.mobile.loading( "show" );
			
			$.ajax({ 
			    type: "POST"
			   ,url: "<c:url value='/user/logout.do'/>"
			   ,async: false 
			   ,data : {
				}
			   ,dataType: "json"
			   ,success:function(json){
					$.mobile.loading( "hide" );
					location.href="<c:url value='/'/>";
			   }
			});
		}
    
    </script>
<div id="logoutDialog" style="max-width: 500px;" data-role="popup" data-theme="c" data-overlay-theme="b" data-dismissible="false">
    <div data-role="header" data-theme="a">
    <h1>로그아웃</h1>
    </div>
    <div class="ui-content" role="main">
        <h3 class="ui-title">로그아웃 하시겠습니까?</h3>
<!-- 		    	<p>This action cannot be undone.</p> -->
			<div class="ui-grid-a">
			    <div class="ui-block-a"><a class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-check ui-btn-icon-left " href="#" data-transition="flow"  onClick="logout()">확인</a></div>
			    <div class="ui-block-b"><a class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-left " href="#" data-rel="back">취소</a></div>
			</div>	
    </div>
</div>
