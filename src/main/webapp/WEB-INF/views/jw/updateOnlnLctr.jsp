<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    /* 테이블 스타일 */
    .table-container {
	    display: flex;
	    gap: 20px; /* 두 표 사이의 간격 */
	    flex-wrap: wrap; /* 화면이 좁아지면 줄바꿈이 되도록 */
	}
    
    .styled-table {
        width: 48%;
        border-collapse: collapse;
        margin-top: 20px;
        border-radius: 8px;
        overflow: hidden;
        background-color: #fff;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .styled-table th,
    .styled-table td {

        border: 1px solid #ddd;
    }

    .styled-table th {
    	padding: 12px;
        background-color: #134b84;
        font-size: 14px;
        color: white;
        width: 150px;
    }
    
    .styled-table td {
    	padding: 12px;
    	font-size: 14px;
    	width: 350px;
    }
    
  
    .styled-table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .styled-table td a {
        color: #007bff;
        text-decoration: none;
    }

    .styled-table td a:hover {
        text-decoration: underline;
    }
</style>
<header>
	<%@ include file="../header.jsp" %>
</header>
<body>
	<div class="container1">
		<div class="sideLeft">
			<%@ include file="../se/sidebar_On.jsp" %>
		</div>
		
		<div class="content1" style="border-top: 2px solid black;">	
			<h2 style="padding-top: 20px; padding-bottom: 10px;">강의 내용 수정</h2>
			<div class="content1">
		
				<form action="updateList" method="post">
				    <input type="hidden" name="lctr_num" value="${lctr_num}">
				    
				    <div class="table-container">  	
					    <table class="styled-table">
					    	<!-- Onln_Lctr -->
					        <tr>
					            <th>강의명</th>
					            <td><input type="text" name="onln_lctr.lctr_name" value="${onln_lctr.lctr_name}" required></td>
					        </tr>
					        <tr>
					            <th>강의설명</th>
					            <td><textarea rows="10" cols="50" name="onln_lctr.lctr_expln" required>${onln_lctr.lctr_expln}</textarea></td>
					        </tr>
					        <tr>	
								<th>시작일</th>
								<td><input type="text" name="onln_lctr.bgng_ymd" value = "${onln_lctr.bgng_ymd}"></td>
							</tr>
							<tr>
								<th>종료일</th>
								<td><input type="text" name="onln_lctr.end_ymd" value="${onln_lctr.end_ymd}"></td>
							</tr>
							<tr>
								<th>모집인원수</th>
								<td><input type="text" name="onln_lctr.rcrt_nope" value="${onln_lctr.rcrt_nope}"></td>
							<tr>	
								<th>수료기준</th>
								<td><input type="text" name="onln_lctr.fnsh_crtr" value="${onln_lctr.fnsh_crtr}"></td>
							</tr>
							
							<!-- Syllabus_Unit -->
							<tr>
								<th>비디오ID</th>
								<td><input type="text" name="syllabus_unit.vdo_id" value="${syllabus_unit.vdo_id}"></td>
							</tr>
							<tr>
								<th>콘텐츠 이름</th>
								<td><input type="text" name="syllabus_unit.conts_nm" value="${syllabus_unit.conts_nm}"></td>
							</tr>
							<tr>	
								<th>재생시간</th>
								<td><input type="text" name="syllabus_unit.play_hr" value="${syllabus_unit.play_hr}"></td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td><input type="text" name="syllabus_unit.file_group" value="${syllabus_unit.file_group}"></td>
							</tr>
				
							<!-- Conts_Ch -->
							<tr>
								<th>챕터번호</th>
								<td><input type="text" name="conts_ch.ch_num" value="${conts_ch.ch_num}"></td>
							</tr>
							<tr>
								<th>챕터이름</th>
								<td><input type="text" name="conts_ch.ch_nm" value="${conts_ch.ch_nm}"></td>
							</tr>
							<tr>	
								<th>시작시간</th>
								<td><input type="text" name="conts_ch.play_start" value="${conts_ch.play_start}"></td>
							</tr>
					    </table>
					</div>
					
					<div style="display: flex; justify-content: center; align-items: center; gap: 20px; height: 10vh;">
					    <button type="submit" 
					    style="padding: 10px 20px; font-size: 16px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">
					    	저장하기
					    </button>
					</div>
				</form>
			
			</div>
		</div>
	</div>
</body>
</html>