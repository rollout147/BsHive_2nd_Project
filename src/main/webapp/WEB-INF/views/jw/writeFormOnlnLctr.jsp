<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>
<link href="<%=request.getContextPath()%>/css/se_onln_lctrList2.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<link href="/css/jw_writeFormOnlnLctr.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>강의 계획서</div>
		<div class="lctrList_main_banner_text">Onln</div><div class="lctrList_main_banner_text2">강의 개설</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/강의계획서.jpg" class="lctrList_main_banner_img">
	</div>
	<div class="mainContainer">
    <div class="sidebar"><%@ include file="../se/sidebar_On.jsp"%></div>
    <div class="content">
        <h1>강의계획서 작성</h1>
        <hr>
        <c:if test="${msg!=null}">${msg}</c:if>
        <form action="insertOnlnLctr" method="post" name="frm" enctype="multipart/form-data" onsubmit="return chk();">
            <table class="styled-table">
                <!-- 교수 정보 불러오기 -->
                <!-- Onln_Lctr TBL 입력 필드 -->
                <tr><th>강의번호</th>
                    <td><input type="hidden" name="lctr_num" value="${lctr_num }">${lctr_num}</td>
                </tr>
                <tr><th>강의명</th>
                    <td><input type="text" name="lctr_name" required></td>
                </tr>
                <tr><th>강의설명</th>
                    <td><textarea rows="10" cols="100" name="lctr_expln"></textarea></td>
                </tr>
                <tr><th>시작일</th>
                    <td><input type="date" id="bgng_ymd" name="bgng_ymd" required></td>
                </tr>
                <tr><th>종료일</th>
                    <td><input type="date" id="end_ymd" name="end_ymd" required></td>
                </tr>
                <tr><th>모집인원수</th>
                    <td><input type="number" name="rcrt_nope" min="1" required></td>
                </tr>
                <tr><th>수료기준</th>
                    <td><input type="text" name="fnsh_crtr" required></td>
                </tr>
            </table>
            <button type="submit" class="submit-btn">강의계획서 제출</button>
        </form>
    </div>
</div>

<footer>
<%@ include file="../footer.jsp" %>
</footer>
	
<script type="text/javascript">
	function chk() {
		if (!frm.lctrName.value) {
            alert("강좌 번호를 입력해주세요");
            frm.lctrName.focus();
            return false;
        }
        if (!frm.sbjectName.value) {
            alert("학과명을 입력해주세요");
            frm.sbjectName.focus();
            return false;
        }
        if (!frm.lctrNum.value) {
            alert("강좌명을 입력해주세요");
            frm.lctrNum.focus();
            return false;
        }
        if (!frm.pscpNope.value) {
            alert("모집인원을 입력해주세요");
            frm.pscpNope.focus();
            return false;
        }
        if (!frm.openDate.value) {
            alert("개설일을 입력해주세요");
            frm.openDate.focus();
            return false;
        }
        if (!frm.closeDate.value) {
            alert("마감일을 입력해주세요");
            frm.closeDate.focus();
            return false;
        }
        return true; // 모든 검증 통과
    }
</script>
<script>
    // 시작일과 종료일의 유효성 검사 코드
    document.getElementById('bgng_ymd').addEventListener('change', function() {
        document.getElementById('end_ymd').min = this.value;
    });

    document.getElementById('end_ymd').addEventListener('change', function() {
        const startDate = document.getElementById('bgng_ymd').value;
        if (startDate && this.value < startDate) {
            alert('종료일은 시작일 이후로 선택해야 합니다.');
            this.value = '';
        }
    });
</script>

		
</body>
</html>