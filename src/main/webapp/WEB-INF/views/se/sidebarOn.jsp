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
    <c:if test="${unq_num != null && fn:substring(unq_num, 0, 1) == '1'}">
    <a href="/jh/myClassroom">
    	<div class="<%= request.getRequestURI().startsWith("/jh/myClassroom") ? "active" : "" %>">강의목록</div>
   	</a>
    <a href="/se/lctrViewList?unq_num=${unq_num}&lctr_num=${lctr.lctr_num }">
    	<div class="<%= request.getRequestURI().startsWith("/se/lctrViewList") ? "active" : "" %>">차시목록</div>
   	</a>
    <a href="/hs/lecAssignmentList?lctr_num=${lctr.lctr_num }">
    	<div class="<%= request.getRequestURI().startsWith("/hs/lecAssignment") ? "active" : "" %>">과제제출</div>
   	</a>
    <a href="/hb/courseEval?lctr_num=${lctr.lctr_num}">
        <div class="${request.requestURI.equals('/hb/courseEval') ? 'active' : ''}">평가</div>
    </a>
    
    <a href="/hb/showResult?lctr_num=${lctr.lctr_num}&unq_num=${unq_num}">
        <div class="${request.requestURI.equals('/hb/showResult') ? 'active' : ''}">성적확인</div>
    </a>
</c:if>

<c:if test="${unq_num != null && (fn:substring(unq_num, 0, 1) == '2' || fn:substring(unq_num, 0, 1) == '3')}">
    <a href="/hs/lecAssignList?lctr_num=${lctr.lctr_num}">
        <div class="${request.requestURI.startsWith('/hs/lecAssignWrite') ? 'active' : ''}">과제입력(교수)</div>
    </a>
    <a href="/hs/lecProfConfirmAssign?lctr_num=${lctr.lctr_num}">
        <div class="${request.requestURI.startsWith('/hs/lecProfConfirmAssign') ? 'active' : ''}">학생과제제출물(교수)</div>
    </a>
    <a href="/hb/lecTestResult?lctr_num=${lctr.lctr_num}">
        <div class="${request.requestURI.equals('/hb/lecTestResult') ? 'active' : ''}">성적입력(교수)</div>
    </a>
    <a href="/hb/showFinalResult?lctr_num=${lctr.lctr_num}">
        <div class="${request.requestURI.equals('/hb/showFinalResult') ? 'active' : ''}">학생수료결과(교수)</div>
    </a>
</c:if>

</div>


</body>
</html>