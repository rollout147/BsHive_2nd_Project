<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/mn_Coursereg.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<header>
	<%@ include file="../header.jsp" %>
</header>
<%-- message 값이 존재할 경우 alert 메시지 표시 --%>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
<body>
	<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>수강신청</div>
		<div class="lctrList_main_banner_text">Offline</div><div class="lctrList_main_banner_text2">수강신청페이지</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/수강신청페이지.png" class="lctrList_main_banner_img">
	</div>
	<div class="Coureg_main_container">
		<div class="Coureg_gird_container">
			<div class="Coureg_sideber">
				<%@ include file="../sidebar_LctrPage.jsp" %>
			</div>
			<div class="Coureg_gird_content">
				<form action="/mn/ConrinsertPage" method="post">
				<div class="Coureg_title">
				<div class="lecInfo_title">강의정보</div>
				</div>
				<table class="Coureg_prm_table">
					<c:forEach var="lctr" items="${lctr }">
						<tr>
							<th>프로그램명
								<input type="hidden" value="${lctr.lctr_num }" name="lctr_num">
							</th>
							<td colspan="3">${lctr.lctr_name }</td>
						</tr>
						<tr>
							<th>강의개요</th>
							<td>${lctr.lctr_otln }</td>
							<th>교육목적</th>
							<td>${lctr.edu_prps }</td>
						</tr>
						<tr>
							<th>교육기간</th>
							<td>${lctr.bgng_ymd}~${lctr.end_ymd}</td>
							<th>강의시간</th>
							<td>
								<c:choose>
									<c:when test="${lctr.dow_day == 1 }">
										월		
									</c:when>
									<c:when test="${lctr.dow_day == 2 }">
										화
									</c:when>
									<c:when test="${lctr.dow_day == 3 }">
										수
									</c:when>
									<c:when test="${lctr.dow_day == 4 }">
										목
									</c:when>
									<c:otherwise>
										금
									</c:otherwise>
								</c:choose>
								요일 ${lctr.bgng_tm } ~ ${lctr.end_tm }
							</td>
						</tr>
						<tr>
							<th>모집정원</th>
							<td>${lctr.pscp_nope }</td>
							<th>수강료</th>
							<td>${lctr.fnsh_cost }원</td>
						</tr>
						<tr>
							<th>교육장소</th>
							<td colspan="3">중앙정보처리학원 ${lctr.lctrm_num}호</td>
						</tr>
					</c:forEach>
				</table>
				
				<hr class="hr_1">
				
				<div class="Coureg_title">
					<div class="lecInfo_title2">신청자정보</div>
					<div class="Coureg_title_text">
						* 주소, 휴대폰번호, 이메일 정보를 변경하시려면 마이페이지 > 회원정보변경에서 변경하시면 됩니다.
					</div>
				</div>
				<table class="Coureg_user_table">
					<c:forEach var="user" items="${user }">
					<tr>
						<th>신청자 명
							<input type="hidden" value="${user.unq_num }" name="unq_num">
						</th>
						<td colspan="3">${user. stdnt_nm}</td>
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
						<td colspan="3">${user.eml }</td>
					</tr>
					</c:forEach>
					<tr>
						<th>참여유형</th>
						<td colspan="3">
							<div class="Coureg_user_table_ptcp">
								<c:forEach var="part" items="${part }" varStatus="status">
									<label class="radio_label">
									  <input type="radio" class="radio_but" name="ptcp_type" value="${part.mcode }" ${status.first ? 'checked="checked"' : ''}>
									  ${part.content }
									</label>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<th>우대사항</th>
						<td>
							<div class="Coureg_user_radio_priority">
								<c:forEach var="pref" items="${pref }" varStatus="status">
									<label class="radio_label">
									  <input type="radio" class="radio_but" name="priority_type" value="${pref.mcode }" ${status.first ? 'checked="checked"' : ''}>
									  ${pref.content }
									</label>
								</c:forEach>
							</div>
						</td>
					</tr>
					
				</table>
				
				<div class="Coureg_title">
					<div class="lecInfo_title">서류관련 안내사항</div>
				</div>
				<table class="Coureg_user_table_1">
					<tr class="row_1">
						<th class="col_1">대상자</th>
						<th class="col_2">구비서류</th>
						<th class="col_3">발급처</th>
						<th class="col_4">발급방법</th>
					</tr>
					<tr>
						<td rowspan="2" class="col_1">장애인</td>
						<td rowspan="2">장애인 복지카드 사본 or 장애인증명서</td>
						<td>복지로 온라인신청</td>
						<td class="col_4"><a href="https://online.bokjiro.go.kr/apl/aplMain.do">https://online.bokjiro.go.kr/apl/aplMain.do</a> 에서 신청 또는 소지하고 있는 복지카드 복사본</td>
					</tr>
					<tr>
						<td>민원24</td>
						<td class="col_4"><a href="http://www.minwon.go.kr/main?a=AA020InfoMainApp">http://www.minwon.go.kr/main?a=AA020InfoMainApp</a> 에서 장애인증명서 온라인 신청가능</td>
					</tr>
					<tr>
						<td rowspan="2" class="col_1">경력단절자</td>
						<td rowspan="2">건강보험자격득실확인서</td>
						<td rowspan="2">국민건강보험공단</td>
						<td >1577-1000으로 전화후 팩스로 받기</td>
					</tr>
					<tr>
						<td class="col_4"><a href="https://www.nhis.or.kr/retrieveHomeMain.xx">https://www.nhis.or.kr/retrieveHomeMain.xx</a> 에서 온라인 신청 가능</td>
					</tr>
					<tr>
						<td class="col_1">탈북자</td>
						<td>북한이탈주민등록확인서</td>
						<td>민원24</td>
						<td class="col_4"><a href="http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A10004&CappBizCD=12500000065">http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A10004&CappBizCD=12500000065</a>
							에서 온라인 신청가능</td>
					</tr>
					<tr>
						<td class="col_1">다문화가정</td>
						<td>가족관계증명서 및 외국인사실확인서 등 다문화 가정임을 증명할 수 있는 서류</td>
						<td>민원24</td>
						<td class="col_4"><a href="http://efamily.scourt.go.kr">http://efamily.scourt.go.kr</a> 에서 온라인 신청가능</td>
					</tr>
					<tr>
						<td class="col_1">기초생활 대상자</td>
						<td>국민기초생활수급자 증명서</td>
						<td>민원24</td>
						<td class="col_4"><a href="http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A02&CappBizCD=14600000280">http://www.minwon.go.kr/main?a=AA020InfoCappViewApp&HighCtgCD=A02&CappBizCD=14600000280</a> 에서 온라인 신청가능</td>
					</tr>
				</table>
				
				<hr>
				<div class="Coureg_form_group">
					<label class="agree">
						<Strong>이용약관에 동의</Strong>
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
				<div class="but_submit">
					<button type="submit" id="submitBtn" class="butgo">수강신청</button>
					<button id="backBtn" class="butgo2" onclick="history.back()">취소</button>
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