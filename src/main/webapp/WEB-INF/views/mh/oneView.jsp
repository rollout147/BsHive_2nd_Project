<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../header.jsp"%>
<link href="/css/pstBanner.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의</title>
<link rel="stylesheet" type="text/css" href="/css/mh_PstView.css">
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>고객센터</div>
		<div class="lctrList_main_banner_text">1:1문의</div><div class="lctrList_main_banner_text2"></div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/게시판2_banner.jpg" class="lctrList_main_banner_img">
	</div>
<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebarPst.jsp" %>
		</div>
 <div class="main-container">
  <div class="container">
	<h2>1:1 문의</h2>
	<table border="1">
		<c:forEach items="${oneView}" var="board">
			<tr>
				<td>제목</td>
				<td><input type="text" name="pst_ttl" value="${board.pst_ttl}"
					readonly></td>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="stdnt_nm" value="${board.stdnt_nm }"></td>
			</tr>
				<tr>
				<td>작성일</td>
				<td><input type="text" name="wrt_ymd" value="${board.wrt_ymd}"
					readonly></td>
			</tr>
			<tr>
				<td>내용</td>
				<td style="width: 100%; padding: 10px; border: 1px solid #ddd;">
    <div style="width: 100%; height: 400px; overflow-y: auto; padding: 10px; border: 1px solid #ccc;">
        <span name="pst_cn" readonly="readonly" th:utext>${board.pst_cn}</span>
    </div>
</td>
			</tr>
			<tr>
			<c:if test="${board.ans_yn == 1 }"><tr>
				<td>답변자</td>
				<td><input type="text" name="stdnt_nm" value="${board.emp_nm}"></td>
			</tr>
			<tr>	
				<td>답변일</td>
				<td><input type="text" name="wrt_ymd" value="${board.answr_ymd}"
					readonly></td>
			</tr>
			<tr>
				<td>답변</td>
				<td style="width: 100%; padding: 10px; border: 1px solid #ddd;">
    <div style="width: 100%; height: 400px; overflow-y: auto; padding: 10px; border: 1px solid #ccc;">
        <span name="pst_cn" readonly="readonly" th:utext>${board.ans}</span>
    </div>
</td>
			</tr></c:if>
			
		</c:forEach>
	</table>
            <div style="text-align: center;">
	<c:forEach items="${oneView}" var="board">
	 <c:if test="${writer == board.unq_num }"><button
			onclick="location.href='/mh/oneModify?pst_num=${board.pst_num}'">수정</button></c:if>
		<button type="button" onclick="location.href='/mh/oneList'">목록보기</button>
		 <c:if test="${writer == board.unq_num }"><button onclick="location.href='/mh/oneDelete?pst_num=${board.pst_num}'" class="delete">삭제</button></c:if>
		 <c:if test="${admin == 3 && board.ans_yn == 0}"><button  onclick="location.href='/mh/answrWrite?pst_num=${board.pst_num}'">답변작성</button></c:if>
	</c:forEach>
	</div>
	</div>
	</div>
	</div>
	
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>
