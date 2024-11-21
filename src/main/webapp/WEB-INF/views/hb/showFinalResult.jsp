<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/css/offLctrBanner.css" rel="stylesheet" type="text/css">

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>평가 이후 확인 페이지</title>
  <style type="text/css">
  table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f4;
            color: #333;
            font-weight: bold;
        }

        td {
            background-color: #fafafa;
        }

        tr:nth-child(even) td {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        input[type="button"] {
            padding: 8px 15px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            font-size: 14px;
        }

        input[type="button"]:hover {
            background-color: #45a049;
        }
         .modal {
            display: none;  /* 기본적으로 숨김 */
            position: fixed;
            z-index: 1; /* 화면 앞에 표시 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4); /* 배경 어두운 색 */
        }

        /* 모달 내용 스타일 */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* 원하는 크기로 설정 */
            max-width: 500px;
        }

        /* 닫기 버튼 */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>

    <header><%@ include file="../header.jsp" %></header>
<body>
    <div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>${student.lctr_name }</div>
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
        <main>
            <h2>학생 정보</h2>
           <form action="submitFinalApproval" method="post" onsubmit="return confirm('최종 승인을 하시겠습니까?');">
              
	        <table>
                <thead>
                    <tr>
                        <th>학생 이름</th>
                        <th>강의명</th>
                        <th>출석 점수</th>
                        <th>과제 확인</th>
                        <th>강의평가 여부</th>
                        <th>수료 여부</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 학생 목록 반복 -->
                    <c:forEach var="student" items="${studentList}">
                        <input type="hidden" name="lctr_num" value="${student.lctr_num}">
    					<input type="hidden" name="unq_num" value="${student.unq_num}">
                        <tr>
                            <td>${student.stdnt_nm}</td> <!-- 학생 이름 -->
                            <td>${student.lctr_name}</td> <!-- 강의명 -->
                            <td> ${student.atndc_scr}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${student.asmt_scr > 1}">
                                        과제 완료
                                    </c:when>
                                    <c:otherwise>
                                        과제 미완
                                    </c:otherwise>
                                </c:choose>
                            </td> 
                            <td>
                                <c:choose>
                                    <c:when test="${student.evl_total > 1}">
                                        평가 완료
                                    </c:when>
                                    <c:otherwise>
                                        평가 미완
                                    </c:otherwise>
                                </c:choose>
                             </td>
                             <td>
                                <c:choose>
                                    <c:when test="${student.fnsh_yn == 1}">
                                        수료 완료
                                    </c:when>
                                    <c:otherwise>
                                        수료 미완
                                    </c:otherwise>
                                </c:choose>
                            </td> 
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
                <button type="submit" class="btnFinalApproval">최종 승인</button>
            </form>
        </main>
    </div>
    <footer>
        <%@ include file="../footer.jsp" %>
    </footer>
</body>
</html>
