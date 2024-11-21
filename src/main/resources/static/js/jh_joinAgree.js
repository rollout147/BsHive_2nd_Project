/*		function toggleButton() {
		    const checkBox1 = document.getElementById('agree1');
		    const checkBox2 = document.getElementById('agree2');
		    const checkBox3 = document.getElementById('agree3');
		    const submitBtn = document.getElementById('submitBtn');
		
		    // agree3 체크 여부 결정
		    checkBox3.checked = checkBox1.checked && checkBox2.checked;
		
		    // 체크박스 상태에 따라 버튼 활성화/비활성화 및 CSS 클래스 변경
		    if (checkBox1.checked && checkBox2.checked) {
		        submitBtn.disabled = false; // 활성화
		        submitBtn.classList.add('active'); // 활성화 스타일 추가
		    } else {
		        submitBtn.disabled = true; // 비활성화
		        submitBtn.classList.remove('active'); // 활성화 스타일 제거
		    }
		}
		
		function toggleAgreeCheckboxes() {
		    const checkBox1 = document.getElementById('agree1');
		    const checkBox2 = document.getElementById('agree2');
		    const checkBox3 = document.getElementById('agree3');
		
		    // agree3 체크 시 agree1과 agree2 체크
		    if (checkBox3.checked) {
		        checkBox1.checked = true;
		        checkBox2.checked = true;
		    } else {
		        // agree3 체크 해제 시 agree1과 agree2 체크 해제
		        checkBox1.checked = false;
		        checkBox2.checked = false;
		    }
		
		    // 상태 업데이트
		    toggleButton();
		}
		
		// 페이지 로드 시 버튼 비활성화 상태로 시작
		window.onload = function() {
		    const submitBtn = document.getElementById('submitBtn');
		    submitBtn.disabled = true; // 기본 비활성화
		    submitBtn.classList.remove('active'); // 기본 스타일 제거
		};
*/


document.addEventListener("DOMContentLoaded", function() {
    // 페이지 로드 시 초기 상태 확인
    toggleButton();
});

function toggleAgreeCheckboxes() {
    const agree1 = document.getElementById("agree1");
    const agree2 = document.getElementById("agree2");
    const agree3 = document.getElementById("agree3");

    // agree3가 체크되면 agree1과 agree2도 체크
    if (agree3.checked) {
        agree1.checked = true;
        agree2.checked = true;
    } else {
        // agree3이 체크 해제되면 agree1과 agree2도 해제
        agree1.checked = false;
        agree2.checked = false;
    }
    
    toggleButton();
}

function toggleButton() {
    const agree1 = document.getElementById("agree1");
    const agree2 = document.getElementById("agree2");
    const submitBtn = document.getElementById("submitBtn");

    // agree1과 agree2가 모두 체크되었을 때만 submitBtn 활성화
    if (agree1.checked && agree2.checked) {
        submitBtn.disabled = false;
    } else {
        submitBtn.disabled = true;
    }

    // 하나라도 체크 해제되면 agree3 체크 해제
    const agree3 = document.getElementById("agree3");
    if (!agree1.checked || !agree2.checked) {
        agree3.checked = false;
    }
}
