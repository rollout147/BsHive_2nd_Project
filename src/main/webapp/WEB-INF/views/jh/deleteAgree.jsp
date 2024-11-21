<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- Confirm Modal HTML -->
<div id="confirmModal" class="modal">
    <div class="modal-content">
        <p>정말 회원에서 탈퇴하시겠습니까?</p>
        <div class="button_container">
            <button id="confirmBtn" class="btn-confirm">확인</button>
            <button id="cancelBtn" class="btn-cancel">취소</button>
        </div>
    </div>
</div>

<!-- 스타일링을 위한 CSS -->
<style>
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        justify-content: center;
        align-items: center;
    }

    .modal-content {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        text-align: center;
        width: 300px;
    }

    .button_container {
        display: flex;
        align-content:center;
        justify-content:center;
        gap: 30px;
        margin-top: 20px;
    }

    .btn-confirm {
        background-color: #daaf67;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 4px;
    }

    .btn-cancel {
        background-color: #134b84;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 4px;
    }

    .btn-confirm:hover, .btn-cancel:hover {
        opacity: 0.9;
    }
    .button_container button {
    	border: 1px solid black;
    }
</style>

<script>
    function showModal() {
        document.getElementById("confirmModal").style.display = "flex";
    }

    function hideModal() {
        document.getElementById("confirmModal").style.display = "none";
    }

    document.getElementById("confirmBtn").onclick = function () {
        document.getElementById("loginForm").submit();
    };

    document.getElementById("cancelBtn").onclick = function () {
        hideModal();
    };

    document.getElementById("loginForm").onsubmit = function (event) {
        event.preventDefault();
        showModal();
    };
</script>
</body>
</html>