<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/css/offLctrBanner.css" rel="stylesheet" type="text/css">

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>교수의 성적 입력창</title>
    <style type="text/css">
        /* 스타일은 그대로 유지 */
        header {
            grid-column: 1 / -1;
        }
        footer {
            grid-column: 1 / -1;
        }
        .sidebar {
            width: 410px;
            padding: 15px;
            background-color: #f9f9f9;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .content {
            padding: 15px;
            display: flex;
            flex-direction: column;
        }
        h2 {
            color: #333;
            margin-top: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            padding: 10px 20px;
            margin-top: 20px;
            float: right;
            margin: 10px;
        }
        button:hover {
            opacity: 0.8;
        }
        #buttonTable{
            margin: 5px;
        }
    </style>
</head>
<header><%@ include file="../header.jsp" %></header>
<body>
    <div class="lctrList_main_banner">
        <div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>${lctr.lctr_name }</div>
        <div class="lctrList_main_banner_text"></div><div class="lctrList_main_banner_text2">최종성적 확인</div>
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
        <div class="content">
            <h2>교수의 성적 입력창</h2>
            <form action="hbsubmitGrade" method="post">
                <table class="buttonTable">
                    <tr>
                    <th>
					<input type="hidden" id="lctr_num" name="lctr_num" value="${lctr_num}">
                	</th>
                </tr>
                </table>
                <table>
                 <thead>
    <tr>
        <th>학생 이름</th>
        <th>강의 번호</th>
        <th>학생 번호</th>
        <th>출석 점수</th>
        <th>과제 점수</th>
    </tr>
</thead>
<tbody>
    <!-- 학생 리스트 반복 처리 -->
    <c:forEach var="hbEvl" items="${classlist}">
        <tr>
            <!-- 학생 이름 -->
            <td>
                <input type="text" 
                       id="stdnt_nm_${hbEvl.unq_num}" 
                       name="stdnt_nm_${hbEvl.unq_num}" 
                       value="${hbEvl.stdnt_nm}" 
                       readonly required>
            </td>

            <!-- 강의 번호 -->
            <td>
                <input type="text" 
                       id="lctr_num_${hbEvl.unq_num}" 
                       name="lctr_num_${hbEvl.unq_num}" 
                       value="${hbEvl.lctr_num}" 
                       readonly required>
            </td>

            <!-- 학생 번호 -->
            <td>
                <input type="text" 
                       id="unq_num_${hbEvl.unq_num}" 
                       name="unq_num_${hbEvl.unq_num}" 
                       value="${hbEvl.unq_num}" 
                       readonly required>
            </td>

            <!-- 출석 점수 -->
            <td>
                <input type="number" 
                       id="atndc_scr_${hbEvl.unq_num}" 
                       name="atndc_scr_${hbEvl.unq_num}" 
                       value="${hbEvl.atndc_scr}" 
                       required>
            </td>

            <!-- 과제 점수 -->
            <td>
                <input type="number" 
                       id="asmt_scr_${hbEvl.unq_num}" 
                       name="asmt_scr_${hbEvl.unq_num}" 
                       value="${hbEvl.asmt_scr}" 
                       required>
            </td>

            <!-- 강의 번호를 hidden input으로 포함 -->
            <td>
                <input type="hidden" 
                       id="hidden_lctr_num_${hbEvl.lctr_num}" 
                       name="lctr_num_${hbEvl.lctr_num}" 
                       value="${hbEvl.lctr_num}">
            </td>
        </tr>
    </c:forEach>
</tbody>
</table>

                <button type="submit">성적 제출</button>
            </form>
        </div>
    </div>
    <footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</body>
</html>