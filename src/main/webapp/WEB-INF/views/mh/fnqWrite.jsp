<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header.jsp" %>
<link href="/css/pstBanner.css" rel="stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
$(document).ready(function() {
	$('#summernote').summernote({
	toolbar:[
		['custom', ['examplePlugin']],
		['style', ['style', 'examplePlugin']]
		 // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 표만들기
	    ['table', ['table']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
		
	]
	});	
});
$.extend($.summernote.options, {
	examplePlugin: {
		icon: '<i class="note-icon-pencil"/>',
		tooltip: 'Example Plugin Tooltip'
	}
});
$('.dropdown-toggle').dropdown();

</script>
<style type="text/css">

	
      table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 100%;
            border-radius: 8px;
            overflow: hidden;
        }
             th, td {
            padding: 12px;
            border: 2px solid #ddd;
            word-wrap: break-word; /* Allow word wrap */
            min-width: 0px; /* Minimum width */
        }

        th {
            background-color: #034EA2; /* Header background */
            color: white;
            text-align: center;
        }

        td {
            text-align: left;
        }

        textarea {
            width: 100%;
            height: 200px;
            resize: vertical; /* Allow vertical resize */
        }
        input {
        	outline: none;
        	border-width: 0;
        }

</style>
<link rel="stylesheet" type="text/css" href="/css/mh_PstView.css">
<meta charset="UTF-8">
<title>FAQ</title>
</head>
<body>
<div class="lctrList_main_banner">
		<div class="lctrList_main_banner_text3"><div class="lctrList_main_banner_do"></div>고객센터</div>
		<div class="lctrList_main_banner_text">FAQ</div><div class="lctrList_main_banner_text2"></div>
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/게시판_banner.jpg" class="lctrList_main_banner_img">
	</div>
<div class="container1">
		<div class="sideLeft">
			<%@ include file="sidebarPst.jsp" %>
		</div>
 <div class="main-container">
  <div class="container">
	<h2>FAQ</h2>
 <form action="faqInsert" method="post" enctype="multipart/form-data">
 <input type="hidden" name="writer" value="${writer }">
        <table border="1">
            <tr>
                <td>제목</td>
                <td><input type="text" name="pst_ttl"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea rows="10" name="pst_cn"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">작성</button>
                    &nbsp;&nbsp; 
                     <button type="button" onclick="location.href='/mh/fnqList'">목록보기</button> 
                </td>
            </tr>
        </table>
    </form>
    </div>
    </div>
    </div>
</body>
<footer>
	<%@ include file="../footer.jsp" %>
</footer>
</html>