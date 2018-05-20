<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script>
    $( document ).on( "pagecontainerchange", function() {
        // Each of the four pages in this demo has a data-title attribute
        // which value is equal to the text of the nav button
        // For example, on first page: <div data-role="page" data-title="Info">
        var current = $( ".ui-page-active" ).jqmData( "title" );
        // Change the heading
        $( "[data-role='header'] h1" ).text( current );
        // Remove active class from nav buttons
        $( "[data-role='navbar'] a.ui-btn-active" ).removeClass( "ui-btn-active" );
        // Add active class to current nav button
        $( "[data-role='navbar'] a" ).each(function() {
            if ( $( this ).text() === current ) {
                $( this ).addClass( "ui-btn-active" );
            }
        });
    });

    </script>
<div style="overflow: hidden;" data-role="footer"  data-position="fixed">
   	<div data-role="navbar">
        <ul>
            <li><a href="<c:url value='/bid/list.do'/>">공고현황</a></li>
            <li><a href="<c:url value='/notice/list.do'/>">공지사항</a></li>
            <li><a href="<c:url value='/msg/list.do'/>">메세지함</a></li>
<!-- 		            <li><a href="#">Three</a></li> -->
        </ul>
    </div><!-- /navbar -->
</div><!-- /footer -->

<div class="ui-footer ui-bar-a ui-footer-fixed slideup" role="contentinfo" data-role="footer" data-theme="a" data-position="fixed">
	<div class="ui-navbar" role="navigation" data-role="navbar">
		<ul class="ui-grid-b">
			<li class="ui-block-a"><a class="ui-btn ui-btn-active" href="<c:url value='/bid/list.do'/>" data-transition="fade" data-prefetch="true">공고현황</a></li>
			<li class="ui-block-b"><a class="ui-btn" href="<c:url value='/notice/list.do'/>" data-transition="fade" data-prefetch="true">공지사항</a></li>
			<li class="ui-block-c"><a class="ui-btn" href="<c:url value='/msg/list.do'/>" data-transition="fade" data-prefetch="true">메세지함</a></li>
		</ul>
	</div><!-- /navbar -->
</div>