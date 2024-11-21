<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/mn_hanPage.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<header>
	<%@ include file="../header.jsp" %>
</header>
<body>
	<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>수강신청 리스트</div>
		<div class="lctrList_main_banner_text">Offline</div><div class="lctrList_main_banner_text2">수강신청 방법</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/수업중.png" class="lctrList_main_banner_img">
	</div>
	<div class="han_main_container">
		<div class="han_grid_container">
			<div class="han_sidebar">
				<%@ include file="../sidebar_LctrPage.jsp" %>
			</div>
			<div class="met_content">
				<div class="han_title">
					수강신청 방법
				</div>
				<div class="met_images">
					<img alt="배너" src="<%=request.getContextPath()%>/images/main/banner_info.png" class="img_imgbox">
				</div>
			</div>
		</div>
	</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>