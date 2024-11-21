<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ include file="../header.jsp" %>
<link href="<%=request.getContextPath()%>/css/se_onln_lctrList.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 수강목록</title>
</head>
<body>
	<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>수강강의 목록</div>
		<div class="lctrList_main_banner_text">Online</div><div class="lctrList_main_banner_text2">수강목록</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/LCTR_LMS.jpg" class="lctrList_main_banner_img">
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
						    <th>순번</th> <!-- 순번 추가 -->
						    <th>강의번호</th>
						    <th>강의명</th>
						    <th>강사명</th>
						    <th>시작일</th>
						    <th>종료일</th>
						    <th>강의진도율</th>
						    <th>강의상태</th>
						</tr>
			        </thead>
			        <tbody>
			            <c:forEach var="myLctrList" items="${myLctrList}" varStatus="status">
			                <tr onclick="location.href='/se/lctrViewList?unq_num=${myLctrList.UNQ_NUM}&lctr_num=${myLctrList.LCTR_NUM}';" style="cursor: pointer;">
			                    <td>${status.index + 1}</td> <!-- 순번 표시 -->
			                    <td>${myLctrList.LCTR_NUM}</td>
			                    <td>${myLctrList.LCTR_NAME}</td>
			                    <td>${myLctrList.EMP_NM}</td>
			                    <td>${myLctrList.BGNG_YMD}</td>
			                    <td>${myLctrList.END_YMD}</td>
			                    <td>${myLctrList.PACE}%</td>
			                    <td>${myLctrList.APLY_TYPE}</td>
			                </tr>					
			            </c:forEach>
			        </tbody>
			    </table>
		    </div>
        </div>      
    </div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>