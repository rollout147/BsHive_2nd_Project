<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<link href="/css/pstBanner.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>약관</title>
<link rel="stylesheet" type="text/css" href="/css/mh_PstCss.css">
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>고객센터</div>
		<div class="lctrList_main_banner_text">약관</div><div class="lctrList_main_banner_text2"></div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/게시판2_banner.jpg" class="lctrList_main_banner_img">
	</div>
<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebarPst.jsp" %>
		</div>
 <div class="main-container">
  <div class="container">
      <h2>약관</h2>

<form action="yakWrite">
<table>
<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
		<c:set var="num" value="1"></c:set>
		<c:forEach items="${listYak }" var="board">		
		<tr onclick="location.href='/mh/yakView?pst_num=${board.pst_num}'" style="cursor: pointer;">
		<td>${num}</td>
		<td>${board.pst_ttl }</td>
		<td>${board.wrt_ymd }</td>
		</tr>
		<c:set var="num" value="${num + 1}" />
		</c:forEach>
</table>
					<div id="paging">

				<c:if test="${page.startPage > page.pageBlock }">
					<a
						href="yakList?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					<a href="yakList?currentPage=${i}">[${i}]</a>
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage }">
					<a
						href="yakList?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
				</c:if>

        </div>
    <c:if test="${admin == 3 }"><input type="submit" value="글작성"></c:if>
    </form>
    </div>
    </div>
    </div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>