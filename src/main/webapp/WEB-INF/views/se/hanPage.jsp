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
		<div class="lctrList_main_banner_text">Offline</div><div class="lctrList_main_banner_text2">교육대상자</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/교육대상.png" class="lctrList_main_banner_img">
	</div>
	<div class="han_main_container">
		<div class="han_grid_container">
			<div class="han_sidebar">
				<%@ include file="sidebar_On.jsp" %>
			</div>
			<div class="han_content">
				<div class="han_title">
					신청대상
				</div>
				<div class="han_text">
					수업 참여의 의지가 있는 일반인 및 직장인
				</div>
				<div class="han_title">
					우대사항
				</div>
				<div class="han_text">
					부산시 지역주민
				</div>
				<div class="han_title">
					수강료
				</div>
				<div class="han_text">
					무료(국비지원) 일부과정 유
				</div>
				<div class="han_title">
					선발방법
				</div>
				<div class="han_text">
					수강신청 후 개강 일주일 전 수강생 선발 개별 통보 <br>
					(과정에 따라 정원을 초과할 경우 면접이 있을 수 있음)
				</div>
				<div class="han_title">
					장학금
				</div>
				<table class="han_table">
					<tr>
						<th class="col_1" colspan="2">지급대상</th>
						<th class="col_2">지급예시</th>
					</tr>
					<tr>
						<td rowspan="4">HiVE 교육참여 장학</td>
						<td>기초생활수급자, 차상위계층</td>
						<td>수강료의 50%</td>
					</tr>
					<tr>
						<td>보훈가족, 장애인1~6급, 다문화가정, 새터민</td>
						<td>수강료의 40%</td>
					</tr>
					<tr>
						<td>구직자(경력단절여성, 미취업대상자)</td>
						<td>수강료의 30%</td>
					</tr>
					<tr>
						<td>재직자 등</td>
						<td>수강료의 20%</td>
					</tr>
					<tr>
						<td>HiVE-DAY 장학금</td>
						<td>교육과정 이수자 중 성취도 상위 50% 이내</td>
						<td>5만원 이내</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>