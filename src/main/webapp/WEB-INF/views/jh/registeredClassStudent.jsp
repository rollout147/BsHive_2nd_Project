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
<%@ include file="applyScholarship.jsp" %>
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div><div class="title">마이페이지</div></div>
		<div class="lctrList_main_banner_text2">수강신청현황</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/background/나의 강의실.png" class="lctrList_main_banner_img">
</div>
<div class="body">
    <div class="main-container"> 
        <div class="list">
            <%@ include file="myPageSideBar.jsp" %>
        </div>

        <div class="content">
		    <div class="block_1">
    			<h2>수강신청현황</h2>
    			<div class="btns2">
	                <button class="btn" onclick="filterLectures('all')">전체 보기</button>
	                <button class="btn" onclick="filterLectures('online')">온라인 강의만 보기</button>
	                <button class="btn" onclick="filterLectures('offline')">오프라인 강의만 보기</button>
				</div>
			    <table class="border">
			        <thead>
						<tr>
						    <th>순번</th> <!-- 순번 추가 -->
						    <th>강의번호</th>
						    <th>강의명</th>
						    <th>강사명</th>
						    <th>신청일</th>
						    <th>수강확정일</th>
						    <th>모집인원/정원인원</th>
						    <!-- <th>강의신청률</th> 신청인원 / 정원인원 퍼센트로 표현 -->
						    <th>신청상태</th>
						    <th>수강취소</th>
						    
						</tr>
			        </thead>
			        <tbody>
			             <c:forEach var="regClaStdt" items="${regClaStdt}" varStatus="status">
				            <tr>
				                <td>${status.index + 1}</td> 
				                <td>${regClaStdt.LCTR_NUM}</td>
				                <td>
									<c:choose>
								        <c:when test="${fn:length(regClaStdt.LCTR_NAME) > 10}">
								            ${fn:substring(regClaStdt.LCTR_NAME, 0, 10)}...
								        </c:when>
								        <c:otherwise>
								            ${regClaStdt.LCTR_NAME}
								        </c:otherwise>
								    </c:choose>
								</td>
				                <td>${regClaStdt.EMP_NM}</td>
					            <td>${regClaStdt.APLY_YMD}</td> 
				                <td>${regClaStdt.END_DATE}</td>
								<%-- <td>${(regClaStdt.PSCP_NOPE - regClaStdt.PSCP_COUNT) / regClaStdt.PSCP_NOPE * 100}%</td> --%>
								<td>${(regClaStdt.PSCP_NOPE - regClaStdt.PSCP_COUNT)}/${regClaStdt.PSCP_NOPE}</td>
				            	<td>${regClaStdt.APLY_STTS}</td>  
				              	<td>
									<c:choose>
										<c:when test="${regClaStdt.APLY_STTS == '승인'}">
											<!-- "강의취소" 버튼 -->
											<button type="button" onclick="cancelClass(${regClaStdt.LCTR_NUM})">수강취소</button>
										</c:when>
									</c:choose>
								</td>
				                <td style="display: none;">${regClaStdt.UNQ_NUM}</td>
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
    const rows = document.querySelectorAll("table.border tbody tr");
    let index = 1; // 순번 초기화

    rows.forEach(row => {
        // 6번째 자리 숫자 추출
        const lectureNum = row.querySelector("td:nth-child(2)").textContent;
        const sixthDigit = lectureNum.charAt(5); // 6번째 자리 숫자

        // 온라인(0~4) 또는 오프라인(5~9) 분류
        const isOnline = (parseInt(sixthDigit) >= 0 && parseInt(sixthDigit) <= 4);
        const isOffline = (parseInt(sixthDigit) >= 5 && parseInt(sixthDigit) <= 9);

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
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>