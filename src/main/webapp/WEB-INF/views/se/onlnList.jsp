<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ include file="../header.jsp" %>
<link href="<%=request.getContextPath()%>/css/se_onln_lctrList.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LMS</title>
</head>
<body>
	<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>모집강의 목록</div>
		<div class="lctrList_main_banner_text">Online</div><div class="lctrList_main_banner_text2">강의목록</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/LMS1.jpg" class="lctrList_main_banner_img">
	</div>
	<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebar_On.jsp" %>
		</div>
		<div class="content1" style="border-top: 2px solid black;">
			<br><br>
			<div class="content1">
			
			    <!-- 강의 정보 테이블 -->
			    <table class="styled-table">
			        <thead>
			            <tr>
			                <th>강의번호</th>
			                <th>강의명</th>
			                <th>강의상태</th>
			                <th>개설일</th>
			                <th>정원인원수</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach items="${onlnList}" var="Lctr">
			                <tr>
			                    <td>${Lctr.lctr_num}</td>
			                    <td onclick="location.href='/se/onlnDtl?Lctr_Num=${Lctr.lctr_num}'" style="cursor: pointer;">
			                        ${Lctr.lctr_name}
			                    </td>
			                    <td>
								    <c:choose>
								        <c:when test="${Lctr.aply_type == '100'}">개설신청</c:when>
								        <c:when test="${Lctr.aply_type == '110'}">모집중</c:when>
								        <c:when test="${Lctr.aply_type == '120'}">진행중</c:when>
								        <c:when test="${Lctr.aply_type == '130'}">보완요청</c:when>
								        <c:when test="${Lctr.aply_type == '140'}">강의종료</c:when>
								        <c:when test="${Lctr.aply_type == '150'}">폐강</c:when>
								        <c:otherwise>${Lctr.aply_type}</c:otherwise>
								    </c:choose>
								</td>
			                    <td>${Lctr.aply_ydm}</td>
			                    <td>${Lctr.pscp_nope}</td>
			                </tr>
			            </c:forEach>
			        </tbody>
			    </table>
			    <div style="text-align: center;">
				    <c:set var="num" value="${page.total - page.start + 1 }"></c:set>
				
				    <c:if test="${page.startPage > page.pageBlock}">
				        <a href="onlnList?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
				    </c:if>
				
				    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				        <a href="onlnList?currentPage=${i}">[${i}]</a>
				    </c:forEach>
				
				    <c:if test="${page.endPage < page.totalPage}">
				        <a href="onlnList?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
				    </c:if>
				</div>
			</div>
		</div>
	</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>