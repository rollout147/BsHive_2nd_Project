<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/css/offLctrBanner.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교수 과제항목 수정</title>
<style type="text/css">

    /* 과제입력 제목 스타일 */
    h1 {
        font-size: 28px;
        color: #134b84;
        border-bottom: 2px solid #134b84;
        padding-bottom: 15px;
        margin-bottom: 20px;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th {
        background-color: #134b84;
        color: white;
        font-weight: normal;
        text-align: center !important;
        font-size: 16px;
        width: 180px;
    }

    td {
        padding: 12px;
        text-align: center;
        background-color: #fff;
        color: #333;
        font-size: 14px;
    }

    td[colspan="3"] {
        text-align: left;
        padding-left: 20px;
    }

    /* 폼 입력 스타일 */
    .form-floating {
        margin-bottom: 15px;
        width: 100%;
    }

    .form-floating input,
    .form-floating textarea {
        height: 45px;
        font-size: 14px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    .form-floating textarea {
        height: 100px;
    }

    .form-floating label {
        color: grey;
    }
    
    ul {
    	list-style-type: none;
    }
    
    button {
		margin-left: 10px;
		cursor: pointer; /* 마우스 커서 변경 */
		border: none;
		color: red;
		background-color: white;
	}
</style>
<script type="text/javascript">
	function deleteFile(fileGroup, fileNo) {
		// 파일 삭제 요청을 서버로 보내는 AJAX (fetch가 현대식 ajax)
		
		// fetch를 사용해 비동기적으로 POST 요청을 보냄
		fetch('<%=request.getContextPath()%>/hs/deleteUpdFile', {
			method: 'POST',
			// 서버에 JSON 형식으로 데이터를 전송한다고 알려줌
			headers: {
					'Content-Type': 'application/json',
			},
			// 요청 본문(body) 데이터를 JSON 형태로 변환하여 전송
			body: JSON.stringify({
						//dto : 현재 jsp에서 쓰이는 parameter
						file_group: fileGroup,
						file_no: fileNo
			})
		})
		.then(response => {
			if (response.ok) {  // HTTP 상태 코드 200 OK일 경우
	            console.log('파일이 삭제되었습니다.');
	            location.reload();  // 페이지 새로고침하여 파일 목록 갱신
	        } else if (response.status === 400) {  // 400 상태 코드일 경우
	        	console.log('파일 삭제에 실패했습니다.');
	        } else if (response.status === 500) {  // 500 상태 코드일 경우
	        	console.log('서버 오류가 발생했습니다.');
	        } else {
	        	console.log('알 수 없는 오류가 발생했습니다.');
	        }
		})
		.catch(error => {
	     	console.error('Error:', error);
	     	console.log("파일 삭제에 실패했습니다.");
		});
	}
	
	// 페이지가 완전히 로드된 후 스크립트 실행
	document.addEventListener('DOMContentLoaded', function () {
		// 파일 추가 시 파일 목록에 추가
	    document.getElementById("file").addEventListener("change", function(event) {
	        const files = event.target.files;  // 선택된 파일들
	        const newFilesList = document.getElementById("newFiles");
			
	    	// 기존 목록을 비우기
	        newFilesList.innerHTML = '';
	        
	        // 기존 목록을 비우고, 새로 추가된 파일들만 리스트에 추가
	        Array.from(files).forEach(file => {
	            const li = document.createElement("li");
	            li.textContent = file.name;  // 파일명만 추가
	            // 삭제 버튼 추가
	            const deleteButton = document.createElement("button");
	            deleteButton.textContent = "x";
	            deleteButton.style.color = "red";
	            deleteButton.addEventListener("click", function() {
	                // x 버튼 클릭 시 해당 파일만 목록에서 삭제
	                newFilesList.removeChild(li);
	            });
	            li.appendChild(deleteButton);
	            newFilesList.appendChild(li);
	        });
	    });
	});
	

    function confirmUpdate() {
        var result = confirm("과제를 수정하시겠습니까?");
        if (result) {
            // 사용자가 '확인'을 클릭한 경우 폼을 제출
            document.getElementById("assignmentForm").submit();
        }
    }
    
    function confirmBack() {
        var result = confirm("뒤로 가시겠습니까? 수정된 내용은 저장되지 않습니다.");
        if (result) {
            // 사용자가 '확인'을 클릭한 경우 페이지 이동
            window.location.href = '/hs/lecAssignDetail?lctr_num=${hsAssignWrite.lctr_num}&cycl=${hsAssignWrite.cycl}';
        }
    }
</script>
</head>
<header>
	<%@ include file="../header.jsp" %>
</header>
<body>
	<%-- lctr_num 가져오기 --%>
	<c:set var="lctrNum" value="${lctr.lctr_num}" />
	
	<%-- 앞에서 6번째 자리를 추출 (인덱스 5) --%>
	<c:set var="sixthFromStart" value="${fn:substring(lctrNum, 5, 6)}" />
	
	<%-- 숫자로 변환 --%>
	<c:set var="sixthFromStartNum" value="${sixthFromStart}" />
	
	<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>${lctr.lctr_name }</div>
		<div class="lctrList_main_banner_text">
			<c:choose>
			    <c:when test="${sixthFromStartNum >= 0 and sixthFromStartNum <= 4}">
			        <!-- 온라인 강의일 경우 -->
			        Online
			    </c:when>
			    <c:when test="${sixthFromStartNum >= 5 and sixthFromStartNum <= 9}">
			        <!-- 오프라인 강의일 경우 -->
			        Offline
			    </c:when>
			</c:choose>
		</div><div class="lctrList_main_banner_text2">과제수정</div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/수강신청_banner.jpg" class="lctrList_main_banner_img">
	</div>
	<div class="container1">
		<div class="sideLeft">
			<%-- 조건에 따라 사이드바 파일을 동적으로 설정 --%>
			<c:choose>
			    <c:when test="${sixthFromStartNum >= 0 and sixthFromStartNum <= 4}">
			        <!-- 온라인 강의일 경우 -->
			        <%@ include file="../se/sidebarOn.jsp" %>
			    </c:when>
			    <c:when test="${sixthFromStartNum >= 5 and sixthFromStartNum <= 9}">
			        <!-- 오프라인 강의일 경우 -->
			        <%@ include file="../sidebarLctr.jsp" %>
			    </c:when>
			</c:choose>
		</div>
		<form action="profAsmtUpdate" method="post" enctype="multipart/form-data">
		<div class="main">
			<h1>과제수정</h1>
			<input type="hidden" name="lctr_num" value="${hsAssignWrite.lctr_num }">
			<table>
				<tr>
					<th>차시</th>
					<td><input type="hidden" name="cycl" value="${hsAssignWrite.cycl }" >${hsAssignWrite.cycl }차시</td>
					<th>강의명</th>
					<td>${hsAssignWrite.lctr_name }</td>
				</tr>
				<tr>
					<th>교수명</th>
					<td colspan="3">${hsAssignWrite.emp_nm }</td>
				</tr>
				<tr>
					<th>주제</th>
					<td colspan="3">
						<div class="form-floating">
	  						<input type="text" name="asmt_tpc" class="form-control" id="floatingInput" placeholder="과제주제를 입력하세요" required="required" value="${hsAssignWrite.asmt_tpc }">
	  						<label for="floatingInput" style="color: grey;">과제 주제</label>
	  					</div>
					</td>
				</tr>
				<tr>
					<th>상세내용</th>
					<td colspan="3">
						<div class="form-floating">
							<textarea class="form-control" aria-label="With textarea" name="asmt_dtl_cn" id="floatingTextarea" required="required" style="height: 100px;">${hsAssignWrite.asmt_dtl_cn  }</textarea>
							<label for="floatingTextarea">과제 관련해 자세히 적어주세요</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>제출마감일</th>
					<td colspan="3">
						<input type="date" name="asmt_ddln" class="form-control" required="required" value="${hsAssignWrite.asmt_ddln  }">
					</td>
				</tr>
				<tr>
					<th><label for="file">참고문서</label></th>
					<td colspan="3">
						<input type="hidden" name="file_group" value="${hsAssignWrite.file_group}">
                		 <!-- 기존 첨부파일 목록 표시 -->
                		 <input type="file" class="form-control" id="file" name="file" multiple>
                        <c:if test="${not empty fileList}">
                            <ul>
                            	<!-- 새 파일 첨부 -->
                        		<br>
                                <c:forEach var="file" items="${fileList}">
                                    <li>
                                        <!-- 기존 파일 이름 표시 -->
                                        ${file.dwnld_file_nm}
                                        <!-- 파일 삭제 버튼 -->
                                        <button type="button" onclick="deleteFile(${file.file_group}, '${file.file_no}')">  x</button>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <ul class="file-list" id="newFiles"></ul>
                	</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: center;">
						<button type="button" class="btn btn-outline-secondary" onclick="confirmBack()">이전</button>
						<button type="submit" class="btn btn-outline-primary" onclick="confirmUpdate()">수정</button>
					</td>
				</tr>
			</table>
		</div>
		</form>
	</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>