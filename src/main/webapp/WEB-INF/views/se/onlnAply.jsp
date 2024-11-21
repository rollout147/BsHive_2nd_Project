<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 신청서</title>
<script type="text/javascript">
function toggleButton() {
    const checkBox1 = document.getElementById('agree1');
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

// 페이지 로드 시 버튼 비활성화 상태로 시작
window.onload = function() {
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.disabled = true; // 기본 비활성화
    submitBtn.classList.remove('active'); // 기본 스타일 제거
};
</script>
<style type="text/css">
    /* 기본 폰트 및 배경 설정 */
    body {
        overflow-x: hidden;
    }

    /* 페이지 중앙 정렬 및 레이아웃 설정 */
    .Coureg_main_container {
        width: 100%;
        display: flex;
        justify-content: center;
        padding: 10px 0;
    }

    .Coureg_gird_container {
        display: flex;
        width: 90%;
        max-width: 2800px;
        gap: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        background-color: #fff;
    }

    /* 메인 콘텐츠 스타일 */
    .Coureg_gird_content {
        width: 100%;
        box-sizing: border-box;
        color: #333;
    }

    /* 헤더와 제목 스타일 */
    h2, h1 {
        font-family: 'Segoe UI', sans-serif;
        color: #4CAF50;
        margin-bottom: 10px;
    }

    .Coureg_title {
        margin-bottom: 20px;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }

    th, td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f1f1f1;
        font-weight: bold;
    }

    /* 버튼 스타일 */
    #submitBtn {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 15px 30px;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
	
	#backBtn {
        background-color: red;
        color: white;
        border: none;
        padding: 15px 30px;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    
    #submitBtn.active {
        background-color: #388e3c;
    }

    #submitBtn:disabled {
        background-color: #e0e0e0;
        color: #b0b0b0;
        cursor: not-allowed;
    }

    /* 버튼 Hover 효과 */
    #submitBtn:hover:not(:disabled) {
        background-color: #388e3c;
    }

    /* 체크박스 스타일 */
    .checkBtn {
        margin-right: 10px;
    }

    .check input[type="checkbox"] {
        margin-right: 10px;
    }

    .Coureg_form_group {
        margin-top: 20px;
        margin-bottom: 30px;
    }

    .Coureg_form_group .agree {
        font-size: 16px;
        font-weight: bold;
    }

    .Coureg_form_group .text {
        font-size: 14px;
        color: #555;
        margin-top: 10px;
        margin-bottom: 10px;
        border: 1px solid #000;
    }

    /* 작은 텍스트 */
    .Coureg_title_text {
        font-size: 12px;
        color: #777;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    /* 링크 스타일 */
    a {
        color: #4CAF50;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }
    .Coureg_user_table td{
    	font-size: 15px;
    }
</style>
</head>
<header>
	<%@ include file="../header.jsp" %>
</header>
<%-- message 값이 존재할 경우 alert 메시지 표시 --%>
<body>
	<div class="Coureg_main_container">
		<div class="Coureg_gird_container">
			<div class="Coureg_sideber">
				<%@ include file="sidebar_On.jsp" %>
			</div>
			<div class="Coureg_gird_content">
				<form action="/se/lctrOnlnInsert" method="post">
				<div class="content1" style="border-top: 2px solid black;">
					<h2 style="padding-top: 20px; padding-bottom: 10px;">강의 신청서</h2>
				<div class="Coureg_title">
					<h1>프로그램정보</h1>
				</div>
				<table class="Coureg_prm_table">
						<tr>
							<th>프로그램명
								<input type="hidden" value="${onlnAply.lctr_num}" name="lctr_num">
							</th>
							<td>${onlnAply.lctr_name }</td>
						</tr>
						<tr>
							<th>교육목적</th>
							<td>${onlnAply.lctr_expln}</td>
						</tr>
						<tr>
							<th>교육기간</th>
							<td>${onlnAply.bgng_ymd} ~ ${onlnAply.end_ymd}</td>
						</tr>
						<tr>
							<th>신청일</th>
							<td id="aply_ymd"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></td>
						</tr>
						<tr>
							<th>모집정원</th>
							<td>${onlnAply.rcrt_nope }</td>
						</tr>
				</table>
				</div>
				<div class="Coureg_title">
					<h1>프로그램정보</h1>
					<div class="Coureg_title_text">
						* 주소, 휴대폰번호, 이메일 정보를 변경하시려면 마이페이지 > 회원정보변경에서 변경하시면 됩니다.
					</div>
				</div>
				<table class="Coureg_user_table">
					<tr>
						<th>신청자 명<input type="hidden" value="${user.unq_num}" name="unq_num"></th>
						<td colspan="3">${user.stdnt_nm}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">우&nbsp;${user. stdnt_zip})&nbsp;${user.stdnt_addr }&nbsp;${user.stdnt_daddr }</td>
					</tr>
					<tr>
						<th>휴대폰번호</th>
						<td colspan="3">${user.stdnt_telno }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3">${user.eml}</td>
					</tr>
					<tr>
						<th>참여유형</th>
						<td>
							<div class="Coureg_user_table_ptcp">
							  <label>
							    <input type="radio" name="ptcp_type" value="100"> 해당 없음
							  </label>
							  <label>
							    <input type="radio" name="ptcp_type" value="110" > 구직자
							  </label>
							  <label>
							    <input type="radio" name="ptcp_type" value="120" > 재직자
							  </label>
							  <label>
							    <input type="radio" name="ptcp_type" value="130" > 소상공인
							  </label>
							</div>
						</td>
					</tr>
					<tr>
						<th>우대사항</th>
						<td>
							<div class="Coureg_user_radio_priority">
								<label>
								    <input type="radio" name="priority_type" value="100"> 해당 없음
								  </label>
								  <label>
								    <input type="radio" name="priority_type" value="110" > 장애인
								  </label>
								  <label>
								    <input type="radio" name="priority_type" value="120" > 경력단절자
								  </label>
								  <label>
								    <input type="radio" name="priority_type" value="130" > 탈북자
								  </label>
								  <label>
								    <input type="radio" name="priority_type" value="140" > 다문화가정
								  </label>
								  <label>
								    <input type="radio" name="priority_type" value="150" > 기초생활대상자
								  </label>
							</div>
						</td>
					</tr>
				</table>
				
				<div class="Coureg_title">
					<h1>프로그램정보</h1>
				</div>
				<table class="Coureg_user_table">
					<tr class="row_1">
						<th>대상자</th>
						<th>구비서류</th>
						<th>발급처</th>
						<th>발급방법</th>
					</tr>
					<tr>
						<td rowspan="2">장애인</td>
						<td rowspan="2">장애인 복지카드 사본 <br>or 장애인증명서</td>
						<td>복지로 온라인신청</td>
						<td><a href="https://online.bokjiro.go.kr/apl/aplMain.do">https://online.bokjiro.go.kr/apl/aplMain.do</a> <br> 신청 또는 소지하고 있는 복지카드 복사본</td>
					</tr>
					<tr>
						<td>민원24</td>
						<td><a href="http://www.minwon.go.kr/main?a=AA020InfoMainApp">http://www.minwon.go.kr/main?a=AA020InfoMainApp</a> <br> 장애인증명서 온라인 신청가능</td>
					</tr>
					<tr>
						<td rowspan="2">경력단절자</td>
						<td rowspan="2">건강보험자격득실확인서</td>
						<td rowspan="2">국민건강보험공단</td>
						<td>1577-1000으로 전화후 팩스로 받기</td>
					</tr>
					<tr>
						<td><a href="https://www.nhis.or.kr/retrieveHomeMain.xx">https://www.nhis.or.kr/retrieveHomeMain.xx</a> <br> 온라인 신청 가능</td>
					</tr>
					<tr>
						<td>탈북자</td>
						<td>북한이탈주민등록확인서</td>
						<td>민원24</td>
						<td><a href="http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A10004&CappBizCD=12500000065">http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A10004&CappBizCD=12500000065</a>
							<br> 온라인 신청가능</td>
					</tr>
					<tr>
						<td>다문화가정</td>
						<td>가족관계증명서 및 <br>외국인사실확인서 등<br>다문화 가정임을 증명하는 서류</td>
						<td>민원24</td>
						<td><a href="http://efamily.scourt.go.kr">http://efamily.scourt.go.kr</a> <br> 온라인 신청가능</td>
					</tr>
					<tr>
						<td>기초생활 대상자</td>
						<td>국민기초생활수급자 증명서</td>
						<td>민원24</td>
						<td><a href="http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A02&CappBizCD=14600000280">http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A02&CappBizCD=14600000280</a> <br> 온라인 신청가능</td>
					</tr>
				</table>
				<div class="Coureg_form_group">
					<label class="agree">
						<Strong>1. 이용약관에 동의</Strong>
					</label>
					<div class="text">
						<strong>제 1 장 총 칙</strong>
						
						<strong>제 1 조 (목 적)</strong>
						이 약관은 부산광역시 HiVE 센터 고등직업교육거점지구(이하 '부산광역시 HiVE 센터 고등직업교육거점지구')이 제공하는 교육강좌서비스(이하 '서비스')의 이용조건 및 절차에 관한 사항을 규정함을 목적으로 합니다.
						
						<strong>제 2 조 (용어 정의)</strong>
						1. 이 약관에서 사용하는 용어는 다음과 같습니다.
						가. '회원'이라 함은 서비스를 제공받기 위해 부산광역시 HiVE 센터 고등직업교육거점지구가 인정하는 절차를 통해 가입하여 이용자번호 (ID)를 부여 받은 자를 말합니다.
						나. '이용자번호(ID)'라 함은 가입회원의 식별과 회원의 서비스 이용을 위해 고객이 선정하고 부산광역시 HiVE 센터 고등직업교육거점지구가 부여하는 문자와 숫자의 조합을 말합니다.
						다. '비밀번호'라 함은 회원이 부여받은 이용자번호(ID)와 일치된 회원임을 확인하고 회원의 권익보호를 위하여 회원이 선정한 문자와 숫자의 조합을 말합니다.
						2. 이 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스 이용안내에서 정하는 바에 따릅니다.
						
						<strong>제 3 조 (약관 외 적용범위)</strong>
						1. 이 약관은 부산광역시 HiVE 센터 고등직업교육거점지구가 제공하는 서비스 이용에 관한 안내(이하 '서비스 이용안내')와 함께 적용 합니다.
						2. 이 약관에 명시되지 않은 사항에 대해서는 관계법령 및 서비스 이용안내에 따릅니다.
						
						<strong>제 2 장 이용계약</strong>
						
						<strong>제 4 조 (서비스의 종류)</strong>
						서비스의 종류와 내용은 서비스 이용안내에서 정하는 바에 따릅니다.
						
						<strong>제 5조 (이용계약의 성립)</strong>
						1. 이용계약은 본 약관에 동의한 고객이 부산광역시 HiVE 센터 고등직업교육거점지구 소정의 이용신청서를 온라인 또는 부산광역시 HiVE 센터 고등직업교육거점지구가 정하는 방법으로 신청, 부산광역시 HiVE 센터 고등직업교육거점지구의 승낙에 의하여 성립합니다.
						2. 이용계약은 이용자번호(ID) 단위로 체결됩니다.
						3. 제 1항의 규정에 의해 고객이 이용신청을 할 때에는 부산광역시 HiVE 센터 고등직업교육거점지구가 정한 필수입력 사항을 입력하여야 합니다.
						4. 부산광역시 HiVE 센터 고등직업교육거점지구는 고객의 이용신청이 다음 각 호에 해당하는 경우 그 신청에 대한 승낙을 제한 또는 유보할 수 있습니다.
						가. 이름이 실명이 아닐 경우
						나. 허위 주민등록번호를 기재했을 경우
						다. 선량한 풍속, 기타 사회질서를 해 할 목적으로 신청한 경우
						라. 이용신청서의 내용을 허위로 기재하였거나 허위서류를 첨부하였을 경우
						마. 부산광역시 HiVE 센터 고등직업교육거점지구의 업무수행상 또는 기술상 지장이 있는 경우
						바. 기타 이용신청고객의 귀책사유로 이용승낙이 곤란한 경우
						
						<strong>제 6조 (약관의 동의)</strong>
						회원이 등록절차를 거처 동의 버튼을 누름으로써 본 약관에 동의한 것으로 간주합니다.
					</div>
					<div class="check">
						<input type="checkbox" class="checkBtn" id="agree1" required="required" 
							   onclick="toggleButton()">
						<span>동의합니다.</span>
					</div>
				</div>
				<div class="Coureg_but_group" style="margin-bottom: 40px;">
					<button id="submitBtn">수강신청</button>
					<a href="/"><button id="backBtn">취소</button></a>
				</div>
				</form>
			</div>
		</div>
	</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>