<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="/css/offLctrBanner.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상세 성적 확인 페이지</title>
    <style>

        table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: #fff;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	}

		th {
		    background-color: #3498db;
		    color: white;
		    padding: 12px;
		    text-align: left;
		    font-size: 16px;
		}
		
		td {
		    padding: 12px;
		    text-align: left;
		    font-size: 16px;
		    border: 1px solid #ddd;
		}
		
		tr:nth-child(even) {
		    background-color: #f7f7f7;
		}
		
		tr:hover {
		    background-color: #e1e1e1;
		}
		
		hr {
		    border: 1px solid #eee;
		    margin: 20px 0;
		}
    </style>
</head>

<header><%@ include file="../header.jsp" %></header>
<body>
    <div class="lctrList_main_banner">
        <div class="lctrList_main_banner_text3">
            <div class="lctrList_main_banner_do"></div>${lctr.lctr_name}
        </div>
        <div class="lctrList_main_banner_text">Offline 성적확인</div>
        <img alt="메인배너" src="<%=request.getContextPath()%>/images/main/수강신청_banner.jpg" class="lctrList_main_banner_img">
    </div>
<div class="container1">
    <div class="sidebar">
      <div class="sidebar">
        <c:set var="lctrNum" value="${lctr.lctr_num}" />
		
		<%-- 앞에서 6번째 자리를 추출 (인덱스 5) --%>
		<c:set var="sixthFromStart" value="${fn:substring(lctrNum, 5, 6)}" />
		
		<%-- 숫자로 변환 --%>
		<c:set var="sixthFromStartNum" value="${sixthFromStart}" />
	
          <c:choose>
			    <c:when test="${sixthFromStartNum >= 0 and sixthFromStartNum <= 4}">
			        <!-- 온라인 강의일 경우 -->
			        <%@ include file="../se/sidebarOn.jsp" %>
			    </c:when>
			    <c:when test="${sixthFromStartNum >= 5 and sixthFromStartNum <= 9}">
			        <!-- 오프라인 강의일 경우 -->
			        <%@ include file="../sidebarLctr.jsp" %>
			    </c:when>
			</c:choose>
        </div>
    </div>
    
<main>
    <c:forEach var="student" items="${studentGrade}">
        <p>학생 ID: ${student.unq_num}</p>
        <p>${student.stdnt_nm}</p> <!-- 학생 이름 -->
        <p>${student.lctr_name}</p> <!-- 강의명 -->
    </c:forEach>
    
    <table>
        <thead>
            <tr>
                <th>항목</th>
                <th>내용</th>
            </tr>
        </thead>
        <tbody>
       <c:forEach var="grade" items="${studentGrade}">
    <tr>
        <td>신청일</td>
        <td>${grade.aply_ymd}</td>
    </tr>
    <tr>
        <td>출석 점수</td>
        <td>${grade.atndc_scr}</td>
    </tr>
    <tr>
        <td>과제 점수</td>
        <td>${grade.asmt_scr}</td>
    </tr>
    <tr>
        <td>수료 여부</td>
        <td>
            <!-- 수료 여부가 1이면 "완료", 0이면 "비완료" -->
            <c:choose>
                <c:when test="${grade.fnsh_yn == 1}">완료</c:when>
                <c:otherwise>비완료</c:otherwise>
            </c:choose>
        </td>
    </tr>
    <tr>
        <td>강의 진도율</td>
        <td>${grade.pace}%</td>
    </tr>
    <tr>
        <td>강의 평가</td>
        <td>
            <!-- 강의 평가가 1 이상이면 "완료", 그렇지 않으면 "미완료" -->
            <c:choose>
                <c:when test="${grade.evl_total >= 1}">완료</c:when>
                <c:otherwise>미완료</c:otherwise>
            </c:choose>
        </td>
    </tr>
    <hr>
</c:forEach>
        </tbody>
    </table>
</main>
</div>
</body>
<footer><%@ include file="../footer.jsp" %></footer>
</html>
