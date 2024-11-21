<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/jh_myClassroom.css">
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div><div class="title">마이페이지</div></div>
		<div class="lctrList_main_banner_text2">내가 등록한 글</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/background/정보변경.png" class="lctrList_main_banner_img">
</div>
<div class="body">
    <div class="main-container"> 
        <div class="list">
            <%@ include file="myPageSideBar.jsp" %>
        </div>
        
        <div class="content">
		    <div class="block_1">
		        <h2>내가 등록한 글</h2>
		        <table class="border">
		            <thead>
		                <tr>
		                    <th>번호</th> 
		                    <th>제목</th>
		                    <th>작성일자</th>
		                    <th>답변여부</th>
		                    <th>답변일자</th>
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach var="board" items="${pst}" varStatus="status">
		                    <tr onclick="location.href='/mh/oneView?pst_num=${board.pst_num}'" style="cursor: pointer;">
		                        <td>${status.index + 1}</td> 
		                        <td>
		                            <c:choose>
		                                <c:when test="${fn:length(board.pst_ttl) > 10}">
		                                    ${fn:substring(board.pst_ttl, 0, 10)}...
		                                </c:when>
		                                <c:otherwise>
		                                    ${board.pst_ttl}
		                                </c:otherwise>
		                            </c:choose>
		                        </td>
		                        <td>${board.wrt_ymd}</td>
		                        <td>${board.ans_yn}</td> 
		                        <td>${board.answr_ymd}</td> 
		                    </tr>
		                </c:forEach>
		            </tbody>
		        </table>
		
				<!-- 페이지 -->
				<div class="pagination">
				    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i">
				        <a href="/jh/myWrittingList?currentPage=${i}" class="${i == paging.currentPage ? 'active' : ''}">${i}</a>
				    </c:forEach>
				</div>
		    </div>
		</div>
    </div>
</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>