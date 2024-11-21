<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/css/offLctrBanner.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교수 과제입력</title>
<style type="text/css">
/* 메인 콘텐츠 영역 */
.main {
    width: 100%;
    max-width: 900px;
    margin: 30px auto;
    padding: 30px;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

/* 헤더 스타일 */
.main h1 {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 30px;
    color: #333;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

th, td {
    padding: 12px 15px;
    border: 1px solid #ddd;
    text-align: left;
}

th {
    background-color: #004f99;
    color: white;
    font-size: 16px;
}

td {
    background-color: #f9f9f9;
    font-size: 14px;
    color: #333;
}

/* 폼 입력 필드 스타일 */
.form-floating {
    margin-bottom: 15px;
}

input[type="text"], input[type="date"], textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
    color: #333;
    background-color: #fafafa;
}

input[type="text"]:focus, input[type="date"]:focus, textarea:focus {
    outline: none;
    border-color: #004f99;
}

textarea {
    resize: vertical;
    min-height: 100px;
}

/* 파일 업로드 스타일 */
input[type="file"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background-color: #fafafa;
}
</style>

</head>
<header>
	<%@ include file="../header.jsp" %>
</header>
<body>
	<%-- lctr_num 가져오기 --%>
	<c:set var="lctrNum" value="${lctr.lctr_num}" />
	
	<%-- 앞에서 6번째 자리를 추출 (인덱스 5) --%>
	<c:set var="sixthFromStart" value="${fn:substring(lctrNum, 5, 6)}" />
	
	<%-- 숫자로 변환 --%>
	<c:set var="sixthFromStartNum" value="${sixthFromStart}" />
	<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>${lctr.lctr_name }</div>
		<div class="lctrList_main_banner_text">
			<c:choose>
			    <c:when test="${sixthFromStartNum >= 0 and sixthFromStartNum <= 4}">
			        <!-- 온라인 강의일 경우 -->
			        Online
			    </c:when>
			    <c:when test="${sixthFromStartNum >= 5 and sixthFromStartNum <= 9}">
			        <!-- 오프라인 강의일 경우 -->
			        Offline
			    </c:when>
			</c:choose>
		</div><div class="lctrList_main_banner_text2">과제입력</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/수강신청_banner.jpg" class="lctrList_main_banner_img">
	</div>
	<div class="container1">
		<div class="sideLeft">
			<%-- 조건에 따라 사이드바 파일을 동적으로 설정 --%>
			<c:choose>
			    <c:when test="${sixthFromStartNum >= 0 and sixthFromStartNum <= 4}">
			        <!-- 온라인 강의일 경우 -->
			        <%@ include file="../se/sidebarOn.jsp" %>
			    </c:when>
			    <c:when test="${sixthFromStartNum >= 5 and sixthFromStartNum <= 9}">
			        <!-- 오프라인 강의일 경우 -->
			        <%@ include file="../sidebarLctr.jsp" %>
			    </c:when>
			</c:choose>
		</div>
		<form action="profAsmtWrite" method="post" enctype="multipart/form-data">
		<div class="main">
			<h1>과제입력</h1>
			<input type="hidden" name="lctr_num" value="${lctr.lctr_num }">
			<input type="hidden" name="cycl" value="${hsAssignWrite.cycl }">
			<table>
				<tr>
					<th>차수</th>
					<td>${hsAssignWrite.cycl }</td>
					<th>강의명</th>
					<td>${hsAssignWrite.lctr_name }</td>
				</tr>
				<tr>
					<th>교수명</th>
					<td colspan="3">${hsAssignWrite.emp_nm }</td>
				</tr>
				<tr>
					<th>주제</th>
					<td colspan="3">
						<div class="form-floating">
	  						<input type="text" name="asmt_tpc" class="form-control" id="floatingInput" placeholder="과제주제를 입력하세요" required="required">
	  						<label for="floatingInput" style="color: grey;">과제 주제</label>
	  					</div>
					</td>
				</tr>
				<tr>
					<th>상세내용</th>
					<td colspan="3">
						<div class="form-floating">
							<textarea class="form-control" aria-label="With textarea" name="asmt_dtl_cn" id="floatingTextarea" required="required" style="height: 100px;"></textarea>
							<label for="floatingTextarea">과제 관련해 자세히 적어주세요</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>제출마감일</th>
					<td colspan="3">
						<input type="date" name="asmt_ddln" class="form-control" required="required" id="asmt_ddln">
					</td>
				</tr>
				<tr>
					<th><label for="file">참고문서</label></th>
					<td colspan="3">
                		<input type="file" class="form-control" id="file" name="file" multiple>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: center;">
						<button type="submit" class="btn btn-outline-primary" id="submitBtn">등록</button>
					</td>
				</tr>
			</table>
		</div>
		</form>
	</div>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    // 폼 제출 버튼 클릭 시
    document.getElementById('submitBtn').addEventListener('click', function(event) {
        // "과제를 등록하시겠습니까?" 확인 메시지
        let confirmResult = confirm("과제를 등록하시겠습니까?");
        
        // 사용자가 "취소"를 클릭한 경우, 폼 제출을 취소
        if (!confirmResult) {
            event.preventDefault();  // 폼 제출을 막습니다.
            return;
        }

        // 마감일자 유효성 검사
        let asmt_ddln = document.getElementById('asmt_ddln').value;
        let today = new Date();
        let selectedDate = new Date(asmt_ddln);

        // 오늘 날짜보다 이전일 경우 경고 메시지 표시
        if (selectedDate < today) {
            alert("오늘 이후 날짜를 선택하세요.");
            event.preventDefault();  // 폼 제출을 막습니다.
        }
    });
});
</script>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>