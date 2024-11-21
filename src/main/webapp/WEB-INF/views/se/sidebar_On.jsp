<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<div class="list">
    <a href="/se/onlnList">
        <a href="/se/hanPage"><div class="<%= request.getRequestURI().startsWith("se/lctListPage") ? "active" : "" %>">교육대상자</div></a>
        <a href="/se/lctrmethod"><div class="<%= request.getRequestURI().startsWith("/se/lecAssignment") ? "active" : "" %>">수강신청 방법</div></a>
        <a href="/se/onlnList"><div class="<%= request.getRequestURI().startsWith("/se/onlnList") ? "active" : "" %>">모집 강의 목록</div></a>
    </a>

<c:if test="${unq_num != null && (fn:substring(unq_num, 0, 1) == '2' || fn:substring(unq_num, 0, 1) == '3')}">
    <a href="/jw/writeFormOnlnLctr">
        <div class="${request.requestURI.equals('/jw/writeFormOnlnLctr') ? 'active' : ''}">온라인 강의개설</div>
    </a>
    <a href="/jw/beforeOnlnLctrList">
        <div class="${request.requestURI.equals('/jw/beforeOnlnLctrList') ? 'active' : ''}">온라인 콘텐츠 개설</div>
    </a>
</c:if>

</div>


</body>
</html>