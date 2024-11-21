<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BsHiVE</title>
</head>
<body>
    <header>
        <%@ include file="header_main.jsp" %>
    </header>

    <script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        const images = document.querySelectorAll('.main_banner_image');
        const navigators = document.querySelectorAll('.main_navigator');
        const eventImages = document.querySelectorAll('.main_event_image');
        const eventNavigators = document.querySelectorAll('.event_navigator');
        let currentIndex = 0;
        let currentEventIndex = 0;
        let slideInterval;

        function showImage(index) {
            images.forEach((img, i) => {
                img.classList.toggle('active', i === index);

                // 비디오일 경우 재생 제어
                if (img.tagName === 'VIDEO') {
                    if (i === index) {
                        img.play().catch(() => {
                            img.muted = true;
                            img.play();
                        });
                    } else {
                        img.pause();
                        img.currentTime = 0;
                    }
                }
            });
            
            navigators.forEach((navigator, i) => {
                navigator.classList.toggle('active', i === index);
            });
            
            updateBannerPosition();
            
            // 슬라이드 전환 시간 업데이트
            updateSlideInterval();
        }

        function updateSlideInterval() {
            // 기존의 interval 제거
            clearInterval(slideInterval);

            // 첫 번째 슬라이드(비디오)일 때 20초, 나머지는 10초
            let intervalTime = (currentIndex === 0) ? 18000 : 10000;
            slideInterval = setInterval(() => {
                currentIndex = (currentIndex + 1) % images.length;
                showImage(currentIndex);
            }, intervalTime);
        }

        // 네비게이터 클릭 시 슬라이드 이동
        navigators.forEach((navigator, index) => {
            navigator.addEventListener('click', () => {
                currentIndex = index;
                showImage(currentIndex);
            });
        });

        // 페이지 로드 시 첫 번째 슬라이드(비디오)에 active 클래스 적용
        images[0].classList.add('active');
        if (images[0].tagName === 'VIDEO') {
            images[0].play().catch(() => {
                images[0].muted = true;
                images[0].play();
            });
        }

        // 초기 슬라이드 전환 시간 설정
        updateSlideInterval();

        // 이벤트 네비게이터 관련 함수들
        function showEventImage(index) {
            eventImages.forEach((img, i) => {
                img.classList.toggle('active', i === index);
            });
            eventNavigators.forEach((navigator, i) => {
                navigator.classList.toggle('active', i === index);
            });
        }

        eventNavigators.forEach((navigator, index) => {
            navigator.addEventListener('click', () => {
                currentEventIndex = index;
                showEventImage(currentEventIndex);
                updateEventNavigator();
            });
        });

        function updateBannerPosition() {
            const bannerBox = document.querySelector('.main_event_banner_box');
            const offset = currentIndex * -100;
            bannerBox.style.transform = `translateX(${offset}%)`;
        }

        function updateEventNavigator() {
            eventNavigators.forEach((navigator, i) => {
                navigator.classList.toggle('active', i === currentEventIndex);
            });
        }

        // 스크롤 애니메이션 기능
        const sections = document.querySelectorAll('.main_header_banner, .main_body_container, .main_footer_container, footer');
        let currentSectionIndex = 0;

        window.addEventListener('wheel', function(event) {
            event.preventDefault();
            if (event.deltaY > 0) {
                if (currentSectionIndex < sections.length - 1) {
                    currentSectionIndex++;
                    sections[currentSectionIndex].scrollIntoView({ behavior: 'smooth' });
                }
            } else {
                if (currentSectionIndex > 0) {
                    currentSectionIndex--;
                    sections[currentSectionIndex].scrollIntoView({ behavior: 'smooth' });
                }
            }
        });
        
        document.getElementById('youtube-thumbnail').addEventListener('click', function() {
            var videoId = 'FYPTXVg-5MI'; // Video ID
            var youtubeUrl = 'https://www.youtube.com/watch?v=' + videoId; // Construct URL
            window.open(youtubeUrl, '_blank'); // Open the YouTube video in a new tab
        });
    });

    // 링크 이동 함수
    function goToLink(url) {
        window.location.href = url;
    }
    
    
	
    </script>

    <div class="main_container">
        <div class="main_header_banner">
        	<div class="main_header_img">
	            <%-- <img alt="" src="<%=request.getContextPath()%>/images/main/banner_1.jpg" class="main_banner_image active"> --%>
	            
	            <img alt="" src="<%=request.getContextPath()%>/images/main/banner_1.png" class="main_banner_image">
	            <img alt="" src="<%=request.getContextPath()%>/images/main/banner_2.png" class="main_banner_image">
	            <img alt="" src="<%=request.getContextPath()%>/images/main/banner_3.png" class="main_banner_image">
	            <img alt="" src="<%=request.getContextPath()%>/images/main/banner_4.png" class="main_banner_image">
            </div>
            <div class="main_banner_navigetor">
                <div class="main_navigator active" data-index="0"></div>
                <div class="main_navigator" data-index="1"></div>
                <div class="main_navigator" data-index="2"></div>
                <div class="main_navigator" data-index="3"></div>
                <div class="main_navigator" data-index="4"></div>
            </div>
        </div>
        <div class="main_body_container">
            <div class="main_body_content">
            <div class="rotating-background" style="background-image: url('<%= request.getContextPath() %>/images/main/backgr_3.png');"></div>
            	<div class="main_table_div">
	            	<div class="main_gogi_title">
	            		공지사항
	            	</div>
	                <table class="main_gogi_table">
	                    <c:forEach var="gogi" items="${pstList }">
		                    <tr onclick="goToLink('/mh/gongView?pst_num=${gogi.pst_num}')" style="cursor: pointer;" class="col_2">
		                        <td class="main_gogi_table_td1">공지사항</td>
		                        <td class="main_gogi_table_td2">${gogi.pst_ttl }</td>
		                        <td class="main_gogi_table_td3">
		                        	${gogi.wrt_ymd }
		                        </td>
		                        <td class="main_gogi_table_img">
		                        	<c:choose>
		                        		<c:when test="${gogi.file_group == null || gogi.file_group == ''}">
		                        			<div class="main_gogi_table_img_text">없음</div>
		                        		</c:when>
		                        		<c:otherwise>
		                        			<img alt="파일icon" src="<%=request.getContextPath()%>/images/main/파일.png" class="main_gogi_table_img_images">
		                        		</c:otherwise>
		                        	</c:choose>
		                        </td>
		                    </tr>
	                    </c:forEach>
	                </table>
                </div>
                <div class="main_but_img">
                    <a href=""><img alt="증명서발급" src="<%=request.getContextPath()%>/images/main/증명서_icon.png" class="main_but_img_src"><div class="main_but_img_text">증명서발급</div></a>
                    <a href=""><img alt="수료증발급" src="<%=request.getContextPath()%>/images/main/수료증_icon.png" class="main_but_img_src"><div class="main_but_img_text">수료증발급</div></a>
                    <a href=""><img alt="수강신" src="<%=request.getContextPath()%>/images/main/수강_icon.png" class="main_but_img_src"><div class="main_but_img_text">수강신청</div></a>
                    <a href=""><img alt="1:1상담" src="<%=request.getContextPath()%>/images/main/상담_icon.png" class="main_but_img_src"><div class="main_but_img_text">1:1 상담</div></a>
                </div>
                <div class="main_calendar">
                    <div class="main_calendar_header">강의일정</div>
                    <div class="main_calendar_card_list">
                    <c:forEach var="lctr" items="${lctr }">
                    <a href="/mn/mn_lctrInfo?lctr_num=${lctr.lctr_num}" class="main_calendar_card_list_a">
                        <div class="main_calender_card">
                            <div class="main_calender_card_date">
                                <div class="main_calender_card_week">
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
                                </div>
                                <div class="main_calender_card_day">
                               		 ${lctr.end_date }
                                </div>
                            </div>
                            <div class="main_calender_card_content">
                                <div class="main_calender_card_content_img">강의</div>
                                <div class="main_calender_card_content_title">${lctr.lctr_name }</div>
                                <div class="main_calender_card_content_date">${lctr.bgng_ymd }~${lctr.end_ymd }</div>
                            </div>
                        </div>
                    </a>
                    </c:forEach>
                    </div>
                </div>
                <div class="main_event_banner">
                    <div class="main_event_banner_box">
                        <img src="<%=request.getContextPath()%>/images/main/banner_가로_001.png" class="main_event_image active" alt="Banner 1">
                        <img src="<%=request.getContextPath()%>/images/main/banner_가로_002.png" class="main_event_image" alt="Banner 2">
                        <img src="<%=request.getContextPath()%>/images/main/banner_가로_003.png" class="main_event_image" alt="Banner 3">
                    </div>
                    <div class="main_event_banner_text">
                        <div class="main_event_banner_navigetor">
                            <div class="event_navigator active" data-index="0"></div>
                            <div class="event_navigator" data-index="1"></div>
                            <div class="event_navigator" data-index="2"></div>
                        </div>
                        <div class="view_more">VIEW MORE</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main_footer_container">
        	<div class="main_footer_content">
    			<div class="main_footer_left">
    				<div class="main_footer_left_title">
    					<b class="gaojo">BSHiVE</b> YOUTUBE
    				</div>
    				<div class="youtube" id="youtube-thumbnail" style="cursor: pointer;">
		                <!-- YouTube Thumbnail -->
		                <img class="sem" src="https://img.youtube.com/vi/FYPTXVg-5MI/hqdefault.jpg" alt="YouTube Video Thumbnail" style="cursor: pointer;" />
		                <div class="youtube_title">
		                	<div class="youtube_title_text">
		                		<div class="youtube_title_text_back">
			                		<img class="youtube_title_text_img" src="<%=request.getContextPath()%>/images/main/유튜브_icon.png"/>
			                	</div>
			                	<div class="youtube_title_text_1">부산시 하이브 홍보영상</div>
		                	</div>
		                	<div class="youtube_title_text_2">하이브홍보 영상</div>
		                </div>
		            </div>
    			</div>
    			<div class="main_footer_right">
    			<div class="rotating-background_2" style="background-image: url('<%= request.getContextPath() %>/images/main/backgr_2.png');"></div>
				    <div class="instagram_right_title">
				        <b class="gaojo">Instagram</b> Posts
				    </div>
				    <div class="instagram_embed">
				        <!-- Instagram Embed Code -->
				        <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DCE25-UhwqA/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DB6MDt-hgGF/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DB3HLgYB6In/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DBypAstJtpB/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DBqC6uEhPs5/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DBqmgnIScMM/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DBxqk1HSNhJ/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DCK0SiIP1FP/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DCAvxrryHLO/" data-instgrm-version="12"></blockquote>
				        </div>
				         <div class="instagram_post">
				            <blockquote class="instagram-media" data-instgrm-permalink="https://www.instagram.com/p/DBZ92JaSotd/" data-instgrm-version="12"></blockquote>
				        </div>
				        <script async src="//www.instagram.com/embed.js"></script>
				    </div>
				</div>
        	</div>
        </div>
        <footer>
		    <%@ include file="footer.jsp" %>
		</footer>
    </div>
</body>
<%@ include file="jh/tempPswd.jsp" %>
</html>
