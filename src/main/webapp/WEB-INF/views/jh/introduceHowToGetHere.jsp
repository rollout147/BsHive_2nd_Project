<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하이브 소개</title>
<link rel="stylesheet" type="text/css" href="/css/jh_introduceHive.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b1aec89436ffdda282e6948304fd91a1"></script>
<style type="text/css">
.Info_user_map {
	margin-left:-300px;
}
.text {
	display:inline-block;
	margin-left:-570px;
	padding: 0px;
}
</style>
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div><div class="title">센터소개</div></div>
		<div class="lctrList_main_banner_text2">오시는 길</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/introduceHive/센터 소개.png" class="lctrList_main_banner_img">
</div>
<div class="body">
    <div class="main-container">
        <div class="list">
           <%@ include file="introduceHiveProjectSideBar.jsp" %>
        </div>
		<div class="content">
		  	<div id="kakao_map" class="Info_user_map" style="width: 800px; height: 400px;">
				<script type="text/javascript">
					var container = document.getElementById('kakao_map');
					var options = {
						center: new kakao.maps.LatLng(37.556478985230136, 126.94520353570182),
						level: 3
					};
		
					var map = new kakao.maps.Map(container, options);
					var marker = new kakao.maps.Marker({ 
					    // 지도 중심좌표에 마커를 생성합니다 
					    position: map.getCenter() 
					}); 
					// 지도에 마커를 표시합니다
					marker.setMap(map);
				</script>
			</div>
			<div class="text">
				<h3>부산 HiVE센터</h1>
				<h4>(04104) 서울 마포구 신촌로 176 중앙빌딩 3층 301호 <br> TEL 02-313-1711</h2>
			</div>
		</div>
    </div> 			
</div>	
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>