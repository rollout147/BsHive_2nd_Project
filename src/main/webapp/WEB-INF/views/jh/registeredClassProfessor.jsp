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
<script>
    function submitForm(lctrNum) {
        const form = document.getElementById("detailForm");
        form.Lctr_num.value = lctrNum;
        form.submit();
    }
</script>

<form id="detailForm" action="/jw/detailOnlnLctr" method="get" style="display:none;">
    <input type="hidden" name="Lctr_num" />
</form>

<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div><div class="title">마이페이지</div></div>
		<div class="lctrList_main_banner_text2">강의신청현황</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/background/나의 강의실.png" class="lctrList_main_banner_img">
</div>
<div class="body">
    <div class="main-container"> 
        <div class="list">
            <%@ include file="myPageSideBar.jsp" %>
        </div>

        <div class="content">
            <div class="block_1">
                <h2>강의신청현황</h2>
                <div class="btns">    
	                <a href="/jw/writeFormOnlnLctr" class="regisClass">온라인 강의개설</a>
	                <a href="/mn/insertformlctr" class="regisClass">오프라인 강의개설</a>
				</div>
                <div class="btns">
	                <button class="btn" onclick="filterLectures('all')">전체강의 보기</button>
	                <button class="btn" onclick="filterLectures('online')">온라인 강의보기</button>
	                <button class="btn" onclick="filterLectures('offline')">오프라인 강의보기</button>
	            </div>
	            
                <!-- 필터 버튼 -->
                
                <table class="border">
                    <thead>
                        <tr>
                            <th>순번</th>
                            <th>강의번호</th>
                            <th>강의명</th>
                            <th>정원인원수</th>
                            <th>강의상태</th>
                            <th>강의유형</th>
                        </tr>
                    </thead>
                    <tbody>
                         <c:forEach var="regClaProf" items="${regClaProf}" varStatus="status">
                         
                            <tr onclick="submitForm(${regClaProf.LCTR_NUM})" style="cursor: pointer;"
                            	class="<c:choose>
		                                    <c:when test='${fn:substring(regClaProf.LCTR_NUM, 5, 6) >= "0" && fn:substring(regClaProf.LCTR_NUM, 5, 6) <= "4"}'>
		                                        online
		                                    </c:when>
		                                    <c:otherwise>
		                                        offline
		                                    </c:otherwise>
		                                </c:choose>">
                                <td>${status.index + 1}</td> 
                                <td>${regClaProf.LCTR_NUM}</td> 
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:length(regClaProf.LCTR_NAME) > 10}">
                                            ${fn:substring(regClaProf.LCTR_NAME, 0, 10)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${regClaProf.LCTR_NAME}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${regClaProf.PSCP_NOPE}</td>
                                <td>${regClaProf.APLY_TYPE}</td> 
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:substring(regClaProf.LCTR_NUM, 5, 6) >= '0' && fn:substring(regClaProf.LCTR_NUM, 5, 6) <= '4'}">
                                            온라인 강의
                                        </c:when>
                                        <c:otherwise>
                                            오프라인 강의
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>      
    </div>
</div>

<script>
function filterLectures(type) {
    // 테이블의 모든 행 선택
    const rows = document.querySelectorAll("table.border tbody tr");
    let index = 1; // 순번 초기값

    rows.forEach(row => {
        // 각 행이 온라인인지 오프라인인지 확인
        const isOnline = row.classList.contains("online");
        const isOffline = row.classList.contains("offline");

        // 필터 타입에 따라 행을 보여주거나 숨김
        if (type === "all") {
            row.style.display = ""; // 전체 보기
            row.querySelector("td:first-child").textContent = index++; // 순번 업데이트
        } else if (type === "online" && isOnline) {
            row.style.display = ""; // 온라인 강의만 보기
            row.querySelector("td:first-child").textContent = index++; // 순번 업데이트
        } else if (type === "offline" && isOffline) {
            row.style.display = ""; // 오프라인 강의만 보기
            row.querySelector("td:first-child").textContent = index++; // 순번 업데이트
        } else {
            row.style.display = "none"; // 조건에 맞지 않는 행 숨기기
        }
    });
}
</script>

<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>