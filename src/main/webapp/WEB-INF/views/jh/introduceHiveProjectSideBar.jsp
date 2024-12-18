<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/jh_introduceHiveProjectSideBar.css">
<script type="text/javascript">
    window.onload = function() {
        const links = document.querySelectorAll('.select.button a'); // '.select.button' 클래스의 a 요소를 선택
        const currentPath = window.location.pathname; // 현재 경로 가져오기

        links.forEach(link => {
            if (link.getAttribute('href') === currentPath) {
                link.classList.add('active'); // href가 현재 경로와 일치하면 active 클래스 추가
            }
        });

        // 기존 리스트 링크에 대해서도 active 클래스 적용
        const listLinks = document.querySelectorAll('.body a'); // '.body' 클래스의 a 요소를 선택
        listLinks.forEach(link => {
            if (link.getAttribute('href') === currentPath) {
                link.classList.add('active'); // href가 현재 경로와 일치하면 active 클래스 추가
            }
        });
    };
</script>
</head>
<body>

<div class="body"> 
    <a href="/jh/introduceHiveProject" class="link-style <%= request.getRequestURI().equals("/jh/introduceHiveProject") ? "active" : "" %>">센터소개</a>
    <a href="/jh/introduceBusiness" class="link-style <%= request.getRequestURI().equals("/jh/introduceBusiness") ? "active" : "" %>">사업소개</a>
    <a href="/jh/introduceOurTeam" class="link-style <%= request.getRequestURI().equals("/jh/introduceOurTeam") ? "active" : "" %>">	조직도</a>
    <a href="/jh/introducePartnerUniversity" class="link-style <%= request.getRequestURI().equals("/jh/introducePartnerUniversity") ? "active" : "" %>">협력기관</a>
    <a href="/jh/introducePlace" class="link-style <%= request.getRequestURI().equals("/jh/introducePlace") ? "active" : "" %>">시설소개</a>
    <a href="/jh/introduceHowToGetHere" class="link-style <%= request.getRequestURI().equals("/jh/introduceHowToGetHere") ? "active" : "" %>">오시는 길</a>
</div>

</body>
</html>