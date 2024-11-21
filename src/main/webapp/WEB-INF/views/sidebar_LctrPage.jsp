<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이드바 내강의실</title>
<link rel="stylesheet" type="text/css" href="/css/sidebarLctr.css">
<script type="text/javascript">
	window.onload = function() {
	    const links = document.querySelectorAll('.list a div');
	    const currentPath = window.location.pathname;
	
	    links.forEach(link => {
	        if (link.parentElement.getAttribute('href') === currentPath) {
	            link.classList.add('active');
	        }
	    });
	};
</script>
</head>
<body>
<div class="body">
    <div class="main-container"> <!-- 리스트와 콘텐츠를 감싸는 컨테이너 -->
        <div class="list">
        <%-- <c:if test="${lgn.unq_num.startWith('1') }"> --%>
            <a href="/mn/hanPage"><div class="<%= request.getRequestURI().startsWith("mn/lctListPage") ? "active" : "" %>">교육대상자</div></a>
            <a href="/mn/lctListPage"><div class="<%= request.getRequestURI().startsWith("mn/lctListPage") ? "active" : "" %>">수강신청 및 리스트</div></a>
            <a href="/mn/lctrmethod"><div class="<%= request.getRequestURI().startsWith("/hs/lecAssignment") ? "active" : "" %>">수강신청 방법</div></a>
        </div>
    </div>
</div>
</body>
</html>