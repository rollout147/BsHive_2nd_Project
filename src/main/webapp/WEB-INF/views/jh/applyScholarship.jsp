<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	button[type="button"] {
	    background-color: #134b84; /* 버튼의 기본 배경색 */
	    color: white; /* 버튼 텍스트 색상 */
	    padding: 10px 20px; /* 버튼 안의 여백 */
	    font-size: 14px; /* 버튼 폰트 크기 */
	    border: none; /* 버튼 테두리 제거 */
	    border-radius: 5px; /* 버튼 모서리 둥글게 */
	    cursor: pointer; /* 커서 모양을 포인터로 변경 */
	    transition: background-color 0.3s ease, transform 0.2s ease; /* 배경색과 크기 변경 효과 추가 */
	}
	
	button[type="button"]:hover {
	    background-color: #daaf67; /* 호버 시 배경색 */
	    transform: scale(1.05); /* 호버 시 약간 확대 */
	}
	
	button[type="button"]:active {
	    background-color: #daaf67; /* 클릭 시 배경색 */
	    transform: scale(1); /* 클릭 시 원래 크기로 */
	}
	
	/* 버튼이 비활성화될 때 회색으로 바뀌는 스타일 */
    .disabled-btn {
        background-color: #d3d3d3; /* 회색 배경 */
        color: #a9a9a9;            /* 회색 텍스트 */
        border: 1px solid #a9a9a9; /* 회색 테두리 */
    }
    
    /* disabled 속성일 때에도 버튼을 회색으로 스타일링 */
    button:disabled {
        background-color: #d3d3d3;
        color: #a9a9a9;
        border: 1px solid #a9a9a9;
        cursor: not-allowed;  /* 마우스 커서를 '금지'로 변경 */
    }
	button:disabled:hover,
    .disabled-btn:hover {
        background-color: #d3d3d3; /* 비활성화된 상태에서 호버 시 배경색 그대로 유지 */
        transform: none; /* 호버 시 확대 효과 제거 */
    }
</style>
	<script type="text/javascript">		
		function applyScholarship(lctr_num) {
		    var confirmApply = confirm("장학금을 신청하겠습니까?");
		    if (confirmApply) {
		        var url = "/kh/admin/applyScholarship?lctr_num=" + lctr_num;
		        window.open(url, "_blank", 'width=600,height=800,location=no,status=no,scrollbars=no,top=100,left=300');
		    }
		}
		
		function cancelClass(LCTR_NUM) {
		    // confirm 창을 띄워 사용자에게 확인을 요청
		    if (confirm("신청한 강의를 취소하시겠습니까?")) {
		        // 현재 페이지의 URL 경로 추출
		        const currentUrl = window.location.pathname;

		        $.ajax({
		            type: "POST",
		            url: "/jh/cancelClass",
		            data: { LCTR_NUM: LCTR_NUM, redirectUrl: currentUrl },
		            success: function(response) {
		                alert("수강신청이 취소되었습니다.");
		                location.href = response.redirectUrl; // 서버에서 전달된 URL로 리디렉션
		            }
		        });
		    }
		}
	</script>

</head>
<body>
</body>
</html>