<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="stylesheet" type="text/css" href="/css/mh_PstView.css">
</head>
<script type="text/javascript">
	function deleteFile(fileGroup, fileNo) {
		// 파일 삭제 요청을 서버로 보내는 AJAX (fetch가 현대식 ajax)
		
		// fetch를 사용해 비동기적으로 POST 요청을 보냄
		fetch('<%=request.getContextPath()%>/mh/deleteUpdFile', {
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
	    document.getElementById("file1").addEventListener("change", function(event) {
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
</script>
<body>
<div class="container1">
    <div class="sideLeft">
        <%@ include file="sidebarPst.jsp" %>
    </div>
    <div class="main-container">
        <div class="container">
            <h2>공지사항 수정</h2>
            <form action="gongModifyDB" method="post" enctype="multipart/form-data">
                <table border="1">
                    <c:forEach items="${GongView}" var="board">
                        <input type="hidden" name="pst_num" value="${board.pst_num}">
                        <input type="hidden" name="file_group" value="${board.file_group}">
                        <tr>
                            <td>제목</td>
                            <td><input type="text" name="pst_ttl" value="${board.pst_ttl}"></td>
                        </tr>
                        <tr>
                            <td>작성일</td>
                            <td><input type="text" name="wrt_ymd" value="${board.wrt_ymd}" readonly></td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td><textarea rows="10" name="pst_cn">${board.pst_cn}</textarea></td>
                        </tr>
                        <tr>
                                               <div class="form-group">
				<tr>
					<th><label for="file1">파일</label></th>
					<td><!-- 기존 첨부파일 목록 표시 -->
						<input type="hidden" name="file_group" value="${board.file_group}">
						<input type="file" class="form-control" id="file1" name="file" multiple>
                        <c:if test="${not empty board.file_group}">
                        	<input type="hidden" name="file_group" value="${board.file_group}">
                            <ul>
                            	<!-- 새 파일 첨부 -->
                        		<br>
                                <c:forEach var="fileL" items="${filePath}">
                                    <li>
                                        <!-- 기존 파일 이름 표시 -->
                                        ${fileL.dwnld_file_nm}
                                        <!-- 파일 삭제 버튼 -->
                                        <button type="button" onclick="deleteFile(${fileL.file_group}, '${fileL.file_no}')">  x</button>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <ul class="file-list" id="newFiles"></ul></td>
				</tr>
			</div>
                               
                    </c:forEach>

                </table>
                <div style="text-align: center;">
                 <button type="submit">수정</button>
                  &nbsp;&nbsp;
                 <button type="button" onclick="location.href='/mh/gongList'">목록보기</button></div>
            </form>
        </div>
    </div>
</div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>
