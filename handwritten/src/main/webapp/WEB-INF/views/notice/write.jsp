<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Write</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script src="/peekaboo21/include/js/common.js"></script>
<script src="/peekaboo21/ckeditor/ckeditor.js"></script>
<script>
$(function(){
	$(".fileDrop").on("dragenter dragover", function(e){
		e.preventDefault(); //기본 효과를 막음
	});
	$(".fileDrop").on("drop", function(e){
		e.preventDefault();
		var files=e.originalEvent.dataTransfer.files; //첨부파일 배열
		var file=files[0]; //첫번째 파일
		var formData=new FormData(); //폼 데이터
		formData.append("file", file); //폼 데이터에 첨부파일 추가
		$.ajax({
			url:"/peekaboo21/upload/uploadAjax",
			data:formData,
			dataType:"text",
			processData:false,
			contentType:false,
			type:"post",
			success:function(data){
				console.log(data);
				var fileInfo=getFileInfo(data);
				var html = "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a><br>";
				html += "<input type='hidden' name='files' value='"+fileInfo.fullName+"'>";
				$("#uploadedList").append(html);
			}
		});
	});
	//첨부파일 목록
	listAttach();
	//첨부파일 삭제
	$("#uploadedList").on("click", ".file_del", function(e){
		var that=$(this);
		$.ajax({
			type:"post",
			url:"/peekaboo21/upload/deleteFile",
			data:{fileName:$(this).attr("data-src")},
			dataType:"text",
			success:function(result){
				if(result == "deleted"){
					that.parent("div").remove();
				}
			}
		});
	});
	
	$("#btnSave").click(function(){
		var content=document.form1.content.value;
		var title=document.form1.title.value;
		if(title==""){
			alert("제목을 입력하세요.");
			document.form1.title.focus();
			return;
		}
		document.form1.submit();
	});	
});
function listAttach(){
	$.ajax({
		type:"post",
		url:"/peekaboo21/notice/getAttach/${dto.nno}",
		success:function(list){
			$(list).each(function(){
				var fileInfo = getFileInfo(this);
				var html = "<div><a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a>&nbsp;&nbsp;";
				html += "<a href='#' class='file_del' data-src='"+this+"'>[삭제]</a></div>";
				$("#uploadedList").append(html);
			});
		}
	});
}
</script>
<style>
.fileDrop{
	width : 600px;
	height : 100px;
	border : 1px dotted gray;
	background-color : gray;
	margin : auto;
}
</style>
</head>
<body>
<h2>Notice write</h2><br>
<form id="form1" name="form1" method="post" action="/peekaboo21/notice/insert.do" enctype="multipart/form-data">
<div>제목 &ensp; <input name="title" id="title" size="80" placeholder="제목을 입력하세요."></div>
<br>
<div>
내용 <textarea id="content" name="content" rows="5" cols="80" placeholder="내용을 입력하세요"></textarea>
</div>
<script>
CKEDITOR.replace("content",{filebrowserUploadUrl:"/peekaboo21/imageUpload.do"});
</script>
<br>
<div>
첨부파일 등록<br>
<!-- <input type="file" name="fileDrop"> -->
<div class="fileDrop"></div>
<div id="uploadedList"></div>
</div><br>
<div>
	<button type="button" id="btnSave" class="btn btn-warning">확인</button>
</div>
</form>
</body>
</html>