<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하이브 소개</title>
<link rel="stylesheet" type="text/css" href="/css/jh_introduceHive.css">
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div><div class="title">센터소개</div></div>
		<div class="lctrList_main_banner_text2">조직도</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/introduceHive/센터 소개.png" class="lctrList_main_banner_img">
</div>
<div class="body">
    <div class="main-container">
        <div class="list">
           <%@ include file="introduceHiveProjectSideBar.jsp" %>
        </div>
		<div class="content">
		  	
		  	<div class="background_image">
				<img src="/images/introduceHive/조직도.png" alt="조직도" class="introduceOurTeam">
    		</div>
		</div>
    </div> 
</div>	
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>