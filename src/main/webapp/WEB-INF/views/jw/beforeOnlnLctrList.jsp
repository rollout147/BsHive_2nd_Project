<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp"%>
<link href="<%=request.getContextPath()%>/css/se_onln_lctrList2.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<link href="/css/jw_beforeOnlnLctrList.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
    // 메시지가 있을 경우 alert를 띄운다.
    <c:if test="${not empty lctr_msg}">
        alert("${lctr_msg}");
    </c:if>
</script>
</head>

<body>
	<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>온라인 컨텐츠</div>
		<div class="lctrList_main_banner_text">Onln</div><div class="lctrList_main_banner_text2">영상 목록</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/LMS2.jpg" class="lctrList_main_banner_img">
	</div>
	<div class="mainContainer">
		<div class="sidebar"><%@ include file="../se/sidebar_On.jsp"%></div>
		<c:if test="${msg!=null}">${msg}</c:if>
			<!-- Syllabus_Unit TBL 입력 -->
		<div class="subContainer">	
			<div class="onlnConts">
				<h3>온라인 강의 차시</h3>
				<hr>	
				<form action="/jw/insertOnlnConts" method="post" name="frm" enctype="multipart/form-data" onsubmit="return chk();">
					<table class="styled-table">
						<tr><th>강의명</th>
						<td><span>${lctr_num}</span> 		
							<select name="lctr_num">
								<c:forEach var="onln_Lctr" items="${onlnLctrNumList }">    
									<option value="${onln_Lctr.lctr_num}">${onln_Lctr.lctr_name}</option>
								</c:forEach>
							</select>
						</td></tr>

						<!-- 차시번호(unit_num)를 서버에 전송하기 위한 hidden input -->
		        		<input type="hidden" name="unit_num" value="${unit_num}" readonly="readonly"/>

						<tr><th>비디오ID</th>
				        <td><input type="text" name="vdo_id" required></td></tr>
				        					
				        <tr><th>콘텐츠명</th>
				        <td><input type="text" name="conts_nm" required></td></tr>
				        		        
				        <tr><th>재생시간</th>
				        <td><input type="number" name="play_hr" required> 단위: 초</td></tr>
				        
				        <tr><th>파일</th>
					    <td><input type="file" name="file" multiple></td></tr>
				        
					</table>
		
					<button type="submit">제출</button>
			
			    </form>
			</div>		    
			    
			    
			    <!-- Syllabus Unit 목록 표시 -->
			<div class="confirmList">	
				<h3>강의차시</h3>
				    <table class="styled-table">
	
				        <c:forEach var="syll" items="${syllabusUnitList}">
				                <c:set var="vdoPrinted" value="true" />
				                <tr>
				                    <th>비디오ID</th>
				                    <td>${syll.vdo_id}</td>
				                </tr>
				                <tr>
					                <th>콘텐츠명</th>
					                <td>${syll.conts_nm}</td>
					            </tr>
					            <tr>
					                <th>재생시간</th>
					                <td>${syll.play_hr} 초</td>
					            </tr>
					            <tr>
					                <th>파일</th>
					                <td>${syll.file_group}</td>
					            </tr>
				                   
				        </c:forEach>
				    </table>
		
			    
			</div>		    
			    <hr>
			    
			    <!-- Conts_ch TBL 입력 -->
			<div class="contsCh">
				<h3>온라인 강의 콘텐츠</h3>
				<hr>		 
			    <form action="/jw/insertContsCh" method="post" name="frm2" onsubmit="return chk2();">
				    <table class="styled-table">
				    
				    	<tr><th>강의번호</th>
				        	<td class="lctr_num">
				        		<input type="hidden" name="lctr_num" value="${lctr_num }">${lctr_num}
				        	</td>
				        </tr>
				    	<tr><th>차시번호</th>
				        	<td class="unit_num">
				        		<input type="hidden" name="unit_num" value="${unit_num }">${unit_num}
				        	</td>
				        </tr>
				    	
				    	<tr><th>챕터번호</th>
				            <td>
				            	<input type="number" name="ch_num" value="1" required>
				            	<input type="number" name="ch_num" value="2" required>
				            </td>
				        </tr>
				        
				        <tr><th>시작시간</th>
				            <td>
				            	<input type="text" name="play_start" value="0" required>
				            	<input type="text" name="play_start" required>
				            </td>
				        </tr>
				        
				        <tr><th>챕터이름</th>
				            <td>
				            	<input type="text" name="ch_nm" value="챕터 1">
							    <input type="text" name="ch_nm" value="챕터 2">
		    				</td>
				        </tr>
				    </table>
				
				    <button type="submit">제출</button>
				    
				</form>
				
			</div>
				
		</div>
	</div>		

<c:if test="${not empty message1}">
    <script>
        alert("${message1}");
    </script>
</c:if>

<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>					
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>