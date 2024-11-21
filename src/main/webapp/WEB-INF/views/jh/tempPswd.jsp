<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   
<!-- 임시 비밀번호 안내 팝업 -->
<c:if test="${sessionScope.isTempPswd}">
    <div id="tempPasswordModal" style="display: block; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 5px; width: 300px; text-align: center;">
            <p>현재 임시 비밀번호로 <br>로그인하셨습니다. <br>비밀번호를 변경하시겠습니까?</p>
            <a href="${pageContext.request.contextPath}/jh/changePassword" class="btn">비밀번호 변경</a>
            <button onclick="closeModal()" class="btn">나중에 변경</button>
        </div>
    </div>
</c:if>

<script>
    function closeModal() {
        document.getElementById("tempPasswordModal").style.display = "none";
        fetch('<%=request.getContextPath()%>/jh/clearTempPswdFlag', {
            method: 'POST'
        });
    }
</script>
<style>
    .btn {
        border: 1px solid black; /* 버튼에 파란색 테두리 추가 */
        border-radius: 5px; /* 테두리 둥글게 */
        color: white; /* 텍스트 색상 */
        text-decoration: none; /* 링크 밑줄 없애기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        background-color: #134b84; /* 배경색 */
    }
    .btn:hover {
        background-color: #daaf67; /* hover 시 배경색 변경 */
        color: black; /* hover 시 텍스트 색상 변경 */
    }
</style>   
</body>
</html>