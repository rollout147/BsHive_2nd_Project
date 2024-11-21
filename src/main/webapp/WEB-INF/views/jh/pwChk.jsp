<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/jh_pwChk.css">
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div><div class="title">마이페이지</div></div>
		<div class="lctrList_main_banner_text2">회원정보변경</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/background/비밀번호 찾기.png" class="lctrList_main_banner_img">
</div>
<div class="body">
    <div class="main-container">
        <div class="list">
           <%@ include file="myPageSideBar.jsp" %>
        </div>
		<div class="content">
		  	<c:if test="${not empty loginError}">
		        <div class="alert">
		            ${loginError}
		        </div>
		    </c:if> 
		    <h1>본인확인</h1>
		    <h4>회원님의 소중한 개인정보를 위해서 본인확인을 진행합니다.</h4>
		    <div class="realPwChk">    
		        <form action="/jh/realPwChk" method="post" id="loginForm">
						<%String eml = (String) session.getAttribute("eml");%>
						<input type="hidden" name="eml" value="<%= eml != null ? eml : "" %>">
		            <div class="input-group">
		                <label for="password">비밀번호</label>
		                <input type="password" name="pswd" id="pswd" placeholder="비밀번호를 입력하세요." required="required">
		            </div>
		            <div class="button-container"> 
		                <input type="submit" value="확인" class="input_submit">
		                <input type="button" value="취소" class="input_cancel" onclick="window.location.href='/jh/myPage';">
		            </div>
		        </form>
		    </div>           
		</div>
    </div> 
</div>	
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>