<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BsHiVE</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous">
</script>
<!-- CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
<!-- 테마 -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<style type="text/css">
<style type="text/css">
	body {
		font-family: 'Pretendard';
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}

	.main_header_container {
		display: flex;
		justify-content: space-between;
		background: rgba(253, 253, 253, 0.7);
		align-items: center;
		height: 100px;
		max-height: 100px;
		width: 100%;
	}
	
	.main_header_menu_2 {
		display: flex;
		justify-content: space-around;
		list-style: none;
	    padding: 0;
	    margin: 0;
	}
	.main_header_menu_2 a {
		text-align: center;
	    color: #323232;
	    font-size: 19px;
	    font-weight: 600;
	    text-decoration: none;
	    transition: color 0.3s;
	    margin:75px; 
	}
	
	.main_header_menu_2 a:hover {
		color: #134b84;
	}
	.main_header_box_1 {
		display: flex;
		border: 0.5px solid #e2e8ee;
		margin: 30px;
		padding: 10px;
		border-radius: 20px;
		align-items: center;
	}
	
	.main_header_input_1 {
		background: none;
		border: none;
	}
	
	.main_header_menu_1_img{
		margin: 15px 50px;
		width: 200px;
		height: auto;
	}
	
	.main_header_box_1_img {
		width: 100%;
		max-width: 24px;
		height: auto;
	} 
	
	.main_header_menu_3 {
		display: flex;
		margin-right: 50px; 
	}
	
	.main_header_menu_3 a {
		text-decoration: none;
	}
	
	.main_lpgin_mypage_but{
		font-size: 18px;
		font-weight: 400;
		color: #323232;
		padding-right: 40px; 
	}
	
	.main_lpgin_but {
		font-size: 18px;
		font-weight: 400;
		color: #323232;
	}
	
	.main_lpgin_mypage_but:hover {
		color: #134b84;
	}
	
	.main_lpgin_but:hover {
		color: #134b84;
	}
	
	.main_lpgin_but_img{
		width: 100%;
		max-width: 12px;
		height: auto;
	}
	
</style>
</head>
<body>
	<div class="main_header_container">
		<div class="main_header_menu_1">
			<a href="/"><img alt="메뉴_icon" src="<%=request.getContextPath()%>/images/main/Logo.png" class="main_header_menu_1_img"></a>
		</div>
		<nav>
			<ul class="main_header_menu_2">
				<li><a href="/jh/introduceHiveProject">센터소개</a></li>
				<li><a href="/mn/lctListPage">오프라인수강신청</a></li>
				<li><a href="/se/onlnList">LMS</a></li>
				<li><a href="/mh/gongList">고객센터</a></li>
			</ul>
		</nav>
		<div class="main_header_menu_3">
            <c:choose>
                <c:when test="${not empty sessionScope.user }">
                    <!-- 세션에 유저정보가 있을시 -->
                    <c:choose>
                        <c:when test="${sessionScope.user.mbr_se == 3 }">
                            <a href="/kh/admin/adminMain" class="main_lpgin_mypage_but"><img alt="관리자페이지" src="<%=request.getContextPath()%>/images/main/관리자.png" class="main_lpgin_but_img">&nbsp;관리자페이지</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/jh/myPage" class="main_lpgin_mypage_but"><img alt="마이페이지" src="<%=request.getContextPath()%>/images/main/마이페이지.png" class="main_lpgin_but_img">&nbsp;마이페이지</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="/jh/logout" class="main_lpgin_mypage_but"><img alt="로그아웃" src="<%=request.getContextPath()%>/images/main/로그아웃.png" class="main_lpgin_but_img">&nbsp;로그아웃</a>
                </c:when>
                <c:otherwise>
                    <!-- 세션에 저장된 user정보가 없을시 -->
                    <a href="/jh/signUpSelect" class="main_lpgin_mypage_but"><img alt="회원가입" src="<%=request.getContextPath()%>/images/main/회원.png" class="main_lpgin_but_img">&nbsp;회원가입</a>
                    <a href="/jh/loginForm" class="main_lpgin_mypage_but"><img alt="자물쇠" src="<%=request.getContextPath()%>/images/main/자물쇠.png" class="main_lpgin_but_img">&nbsp;로그인</a>
                </c:otherwise>
            </c:choose>
        </div>
	</div>
</body>
</html>