<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>강의 리스트</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function formatTime(seconds) {
            var minutes = Math.floor(seconds / 60);
            var remainingSeconds = seconds % 60;
            return minutes + ":" + (remainingSeconds < 10 ? "0" : "") + remainingSeconds;
        }

        function onlnViewDet(vdoId, unitNum, contsNm, playHr, maxDtl, lastDtl, chnm, playstart, lctrNum, unqNum, filegroup) {
            // 팝업 창에 전달할 파라미터를 URL 쿼리 스트링으로 전달
            const params = new URLSearchParams({
                vdo_id: vdoId,
                unit_num: unitNum,
                conts_nm: contsNm,
                play_hr: playHr,
                max_dtl: maxDtl,
                last_dtl: lastDtl,
                ch_nm: chnm,
                play_start: playstart,
                lctr_num: lctrNum,
                unq_num: unqNum,
                file_group: filegroup
            }).toString();

            // 팝업창 열기 (새로운 창으로 전달된 URL을 엽니다)
            window.open('/se/lctrView?' + params, 'coursePopup', 'width=1400,height=900,resizable=yes,scrollbars=yes');
        }

        document.addEventListener("DOMContentLoaded", function () {
            // 예시로 보여주는 시간들을 업데이트
            <c:forEach items="${onln_Lctr_List}" var="lL">
                // formatTime 함수로 시간 형식 변환
                console.log("playHr: " + ${lL.play_hr} + ", maxDtl: " + ${lL.max_dtl}); // 디버깅용
                document.getElementById("play_hr_${lL.unit_num}").textContent = formatTime(${lL.play_hr});
                document.getElementById("max_dtl_${lL.unit_num}").textContent = formatTime(${lL.max_dtl});  // 수강시간 변환
            </c:forEach>
        }, { once: true });

</script>
    <style>
		.course-card {
		    background-color: white;
		    border-radius: 10px;
		    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
		    display: flex;
		    margin: 20px 0;
		    padding: 20px;
		    box-sizing: border-box;
		    align-items: center;
		    justify-content: space-between;
		    flex-direction: row;
		    transition: transform 0.3s ease-in-out;
		}
		
		.course-card:hover {
		    transform: translateY(-5px);
		}
		
		.course-card img {
		    width: 100%;  
		    max-width: 500px; 
		    height: auto;
		    object-fit: cover;
		    border-radius: 8px;
		    margin-right: 20px;
		    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
		}
		
		.course-info {
		    display: flex;
		    flex-direction: column;
		    justify-content: space-between;
		    flex-grow: 1;
		    width: 60%;
		}
		
		.course-details {
		    font-size: 20px;
		    color: #495057;
		    line-height: 1.5;
		}
		
		.course-details div {
		    margin-bottom: 8px;
		}
		
		.course-card button {
		    padding: 10px 15px;
		    background-color: #007bff;
		    color: white;
		    border: none;
		    border-radius: 6px;
		    cursor: pointer;
		    font-weight: 600;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		    margin-top: 12px;
		}
		
		.course-card button:hover {
		    background-color: #0056b3;
		    transform: scale(1.05);
		}
		
		.course-card button:disabled {
		    background-color: #6c757d;
		    cursor: not-allowed;
		}
		
		.progress-bar-container {
		    margin: 10px 0;
		}
		
		progress {
		    width: 100%;
		    height: 12px;
		    border-radius: 10px;
		    background-color: #e9ecef;
		    appearance: none;
		}
		
		progress::-webkit-progress-bar {
		    background-color: #e9ecef;
		    border-radius: 10px;
		}
		
		progress::-webkit-progress-value {
		    background-color: #28a745;
		    border-radius: 10px;
		}
		
		progress::-moz-progress-bar {
		    background-color: #28a745;
		    border-radius: 10px;
		}
	</style>
</head>
<header>
	<%@ include file="../header.jsp" %>
</header>
<body>
    <div class="container1">
    	<div class="sideLeft">
			<%@ include file="sidebarOn.jsp" %>
		</div>
		<div class="content1" style="border-top: 2px solid black;">
        <!-- 메인 콘텐츠 -->
	        <div class="main-content">
	            <input type="hidden" name="unq_num" value="${unq_num}">
	            <c:set var="prevContsNm" value="" />
	            <c:forEach items="${onln_Lctr_List}" var="lL">
	                <!-- 중복 체크: conts_nm이 이전 값과 동일하면 건너뛰기 -->
	                <c:if test="${lL.conts_nm != prevContsNm}">
	                    <div class="course-card">
	                        <!-- 썸네일 -->
	                        <img id="img" alt="유튜브 썸네일" 
	                             src="https://img.youtube.com/vi/${lL.vdo_id}/maxresdefault.jpg">
	                        
	                        <!-- 강의 정보 -->
	                        <div class="course-info">
	                            <div class="course-details">
	                                <div><strong>강의번호:</strong> ${lL.lctr_num}</div>
	                                <div><strong>차시번호:</strong> ${lL.unit_num}</div>
	                                <div><strong>컨텐츠명:</strong> ${lL.conts_nm}</div>
	                                <div><strong>수강시간:</strong> <span id="max_dtl_${lL.unit_num}">${lL.max_dtl}</span></div>
	                                <div><strong>강의시간:</strong> <span id="play_hr_${lL.unit_num}">${lL.play_hr}</span></div>
	                                <!-- 차시 진도율을 Progress Bar로 표시 -->
	                                <div class="progress-bar-container">
	                                    <label for="progress">차시 진도율: ${lL.lctr_pace} %</label>
	                                    <progress id="progress" value="${lL.lctr_pace}" max="100"></progress>
	                                </div>
	                            </div>
	                            
	                            <!-- 버튼 -->
	                            <button 
	                                onclick="onlnViewDet(
	                                    '${lL.vdo_id}', '${lL.unit_num}', 
	                                    '${lL.conts_nm}', '${lL.play_hr}', '${lL.max_dtl}', 
	                                    '${lL.last_dtl}', '${lL.ch_nm}', '${lL.play_start}', 
	                                    '${lL.lctr_num}', '${unq_num}', '${lL.file_group}')"
	                                <c:if test="${lL.last_dtl < lL.play_start}">disabled</c:if>
	                            >
	                                강의보기
	                            </button>
	                        </div>
	                    </div>
	                    <!-- prevContsNm을 현재 conts_nm으로 설정 -->
	                    <c:set var="prevContsNm" value="${lL.conts_nm}" />
	                </c:if>
	            </c:forEach>
	        </div>
		</div>
    </div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>