<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="/css/mh_PstView.css">
</head>
<body>

<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebarPst.jsp" %>
		</div>
 <div class="main-container">
  <div class="container">
        <h2>공지사항</h2>
	<table border="1">
		<c:forEach items="${GongView}" var="board">
		<input type="hidden" name="file_group" value="${board.file_group }">
			<tr>
				<td>제목</td>
				<td><input type="text" name="pst_ttl" value="${board.pst_ttl}"
					readonly></td>
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
			</table>
			<table>
			<tr>
			<c:if test="${not empty board.file_group}">
                        <c:forEach var="filePath"
                            items="${filePath}">
                            <a download="${filePath.dwnld_file_nm}" href="download?filePath=${filePath.file_path_nm}" type="media_type">
                                ${filePath.dwnld_file_nm} 다운로드 </a>
                            <br>
                        </c:forEach>
                    </c:if>
                    </tr>
	</table>
	            <div style="text-align: center;">
</c:forEach>
	<c:forEach items="${GongView}" var="board">
	 <c:if test="${writer == board.unq_num }"><button
			onclick="location.href='/mh/gongModify?pst_num=${board.pst_num}&file_group=${board.file_group }'">수정</button></c:if>
		<button onclick="location.href='/mh/gongList'">목록보기</button>
	 <c:if test="${writer == board.unq_num }"><button onclick="location.href='/mh/gongDelete?pst_num=${board.pst_num}'">삭제</button></c:if>
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
