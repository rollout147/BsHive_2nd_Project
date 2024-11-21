<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>온라인 강의 조회</title>
</head>
<style>
    /* 테이블 스타일 */
    .styled-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        border-radius: 8px;
        overflow: hidden;
        background-color: #fff;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .styled-table th,
    .styled-table td {
        padding: 12px;
        text-align: left;
        font-size: 14px;
        border: 1px solid #ddd;
    }

    .styled-table th {
        background-color: #007bff;
        color: white;
    }

    .styled-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .styled-table tr:hover {
        background-color: #f1f1f1;
    }

    .styled-table td a {
        color: #007bff;
        text-decoration: none;
    }

    .styled-table td a:hover {
        text-decoration: underline;
    }
</style>
<header>
	<%@ include file="../header.jsp" %>
</header>
<body>	
	<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebar_On.jsp" %>
		</div>
		<div class="content1" style="border-top: 2px solid black;">
			<h2 style="padding-top: 20px; padding-bottom: 10px;">강의 상세보기</h2>
			<div class="content1">
			
			    <!-- 강의 정보 테이블 -->
			    <table class="styled-table">
				    <thead>
						<tr>
							<td>강의명</td><td>${onlnDtl.lctr_name}</td>
						</tr>
						<tr>
							<td>강의설명</td><td>${onlnDtl.lctr_expln}</td>
						</tr>
						<tr>	
							<td>시작일</td><td>${onlnDtl.bgng_ymd}</td>
						</tr>
						<tr>
							<td>종료일</td><td>${onlnDtl.end_ymd}</td>
						</tr>
						<tr>
							<td>모집인원수</td><td>${onlnDtl.rcrt_nope}</td>
						<tr>	
							<td>수료기준</td><td>${onlnDtl.fnsh_crtr}</td>
						</tr>
					</thead>	
				</table>
				<div style="display: flex; justify-content: center; align-items: center; gap: 20px; height: 10vh;">
				    <button onclick="window.location.href='/se/onlnAply?lctr_num=${onlnDtl.lctr_num}';"
					        style="padding: 10px 20px; font-size: 16px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">
					    수강신청
					</button>
				    <button onclick="window.location.href='<%= request.getContextPath() %>/se/onlnList';" 
					        style="padding: 10px 20px; font-size: 16px; background-color: #f44336; color: white; border: none; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">
					    뒤로가기
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>