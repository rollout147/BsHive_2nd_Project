<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<link href="/css/pstBanner.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="stylesheet" type="text/css" href="/css/mh_PstView.css">
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>고객센터</div>
		<div class="lctrList_main_banner_text">FAQ</div><div class="lctrList_main_banner_text2"></div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/게시판_banner.jpg" class="lctrList_main_banner_img">
	</div>
<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebarPst.jsp" %>
		</div>
 <div class="main-container">
  <div class="container">
  <h2>FAQ</h2>
    <form action="faqModifyDB" method="post">
        <table border="1">
        <c:forEach items="${fnqView }" var="board">
            <input type="hidden" name="pst_num" value="${board.pst_num }">
            <tr>
                <td>제목</td>
                <td><input type="text" name="pst_ttl" value="${board.pst_ttl }"></td>
            </tr>
            <tr>
                <td>작성일</td>
                <td><input type="text" name="wrt_ymd" value="${board.wrt_ymd }" readonly></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea rows="10" name="pst_cn">${board.pst_cn }</textarea></td>
                <td>
            </tr>

            <tr>
                <td colspan="2">
                    <button type="submit">작성</button>
                    &nbsp;&nbsp; 
                    <button type="button" onclick="location.href='/mh/fnqList'">목록보기</button>
                </td>
            </tr>
            
                        </c:forEach>
        </table>
    </form>
    </div>
    </div>
    </div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>