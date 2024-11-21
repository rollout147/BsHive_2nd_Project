<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/css/pstBanner.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
<link rel="stylesheet" type="text/css" href="/css/mh_PstCss.css">
</head>
<header>
<%@ include file="../header.jsp" %>
</header>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>고객센터</div>
		<div class="lctrList_main_banner_text">공지사항</div><div class="lctrList_main_banner_text2"></div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/게시판_banner.jpg" class="lctrList_main_banner_img">
	</div>
<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebarPst.jsp" %>
		</div>
 <div class="main-container">
  <div class="container">
    <table>
        <form action="gongWrite">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
            </tr>
            <c:set var="num" value="1"></c:set>
            <c:forEach items="${listGong}" var="board">
                <tr onclick="location.href='/mh/gongView?pst_num=${board.pst_num}&file_group=${board.file_group}'"
                    style="cursor: pointer;">
                    <td>${num}</td>
                    <td>${board.pst_ttl}</td>
                    <td>${board.wrt_ymd}</td>
                </tr>
                <c:set var="num" value="${num + 1}" />
            </c:forEach>
       
    </table>
    
    	<div id="paging">
        <c:if test="${page.startPage > page.pageBlock}">
            <a href="gongList?currentPage=${page.startPage - page.pageBlock}">[이전]</a>
        </c:if>
        <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
            <a href="gongList?currentPage=${i}">[${i}]</a>
        </c:forEach>
        <c:if test="${page.endPage < page.totalPage}">
            <a href="gongList?currentPage=${page.startPage + page.pageBlock}">[다음]</a>
        </c:if>
        </div>
    
    <c:if test="${admin == 3}">
        <input type="submit" value="글작성">
    </c:if> </form>
    </div>
    </div>
    </div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>
