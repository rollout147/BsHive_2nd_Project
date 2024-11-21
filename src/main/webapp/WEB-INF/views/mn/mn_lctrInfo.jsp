<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/mn_lctrInfo.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의계획서</title>
</head>
<header>
	<%@ include file="../header.jsp" %>
</header>
<body>
<div class="lctrList_main_banner">
	<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>수강신청 리스트</div>
	<div class="lctrList_main_banner_text">Offline</div><div class="lctrList_main_banner_text2">수강상세</div>
	<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/수강신청.png" class="lctrList_main_banner_img">
</div>
<div class="lctrList_main_container">
	<div class="lctrList_grid_container">
		<div class="sideLeft">
			<%@ include file="../sidebar_LctrPage.jsp" %>
		</div>
		<div class="lctrList_main_content">
			<c:forEach var="lctr" items="${lctr }">
			<div class="lctrList_main_card_header">
				<div class="lctrList_main_card_box">
					<div class="lctrList_main_card_box_1">수강</div>
					<c:if test="${lctr.aply_type == 110 }">
						<div class="lctrList_main_card_box_2">수강가능</div>
					</c:if>
				</div>
				<div class="lctrList_main_card_title">${lctr.lctr_name }</div>
				<div class="lctrList_main_card_body">
					<c:choose>
						<c:when test="${lctr.aply_type == 110 }">
							<div class="lctrList_main_card_body_box">수강신청진행중</div>
						</c:when>
						<c:otherwise>
							<div class="lctrList_main_card_body_box_2">수강신청종료</div>
						</c:otherwise>
					</c:choose>
					<div class="lctrList_main_card_body_text">${lctr.bgng_ymd }~${lctr.end_ymd}</div>
				</div>
			</div>
			<div class="lecInfo_title">강의기본정보</div>
			<table class="lecInfo_table">
				<tr>
					<th>강의명</th>
					<td colspan="3"><div>${lctr.lctr_name }</div></td>
				</tr>
				<tr>
					<th>강사명</th>
					<td colspan="3">${lctr.emp_nm }</td>
				</tr>
				<tr>
					<th>강의 기간</th>
					<td>${lctr.bgng_ymd } ~ ${lctr.end_ymd }</td>
					<th>강의 시간</th>
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
					<th>모집 정원</th>
					<td>${lctr.pscp_nope }명</td>
					<th>수강료</th>
					<td>${lctr.fnsh_cost } 원</td>
				</tr>
			</table>
			
			<br><br>
			
			<div class="lecInfo_title">강의계획</div>
			<table class="lecSched_table">
				<tr>
					<th>강의개요</th>
					<td>${lctr.lctr_otln }</td>
				</tr>
				<tr>
					<th>교육목적</th>
					<td>${lctr.edu_prps }</td>
				</tr>
				<tr>
					<th>교육내용</th>
					<td>${lctr.edu_cn }</td>
				</tr>
				<tr>
					<th>평가방법</th>
					<td>${lctr.evl_mthd }</td>
				</tr>
				<tr>
					<th>참고자료내용</th>
					<td>${lctr.ref_data_cn }</td>
				</tr>
				<tr>
					<th>특이사항</th>
					<td>${lctr.excptn_mttr }</td>
				</tr>
			</table>
			<br><br>
			<hr class="hr_1">
			
			<div class="lecInfo_title3">주차별 강의 계획</div>
			<table class="lctrWeek_table">
				<tr class="col_1">
					<th class="colth_1">주</th>
					<th class="colth_2">강의계획</th>
					<th class="colth_3">수업자료</th>
					<th class="colth_4">강의실</th>
				</tr>
				<c:forEach var="week" items="${week }">
					<tr class="col_2">
						<td style="text-align: center;">${week.lctr_weeks }주차</td>
						<td>${week.lctr_plan }</td>
						<td style="text-align: center;">
							<c:choose>
								<c:when test="${week.file_group == null && week.file_group == ''}">
									없음
								</c:when>
								<c:otherwise>
									<img alt="file_icon" src="<%=request.getContextPath()%>/images/main/파일.png" style="width: 24px; height: auto;">
								</c:otherwise>
							</c:choose>
						</td>
						<td style="text-align: center;">${week.lctrm_num }호</td>
					</tr>
				</c:forEach>
			</table>
			<div class="but_submit">
				<button class="butgo" type="button" onclick="window.location.href='/mn/mn_CourseregPage?lctr_num=${lctr.lctr_num}'">수강신청</button>
				<button class="butgo2" type="button" onclick="history.back()">목록으로</button>
			</div>
			</c:forEach>
		</div>
	</div>
</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>
