<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Edit</title>
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
				var html="<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a><br>";
				html+="<input type='hidden' name='files' value='"+fileInfo.fullName+"'>";
				$("#uploadedList").append(html);
			}
		});
	});

	listAttach();
	
	$("#uploadedList").on("click", "file_del", function(e){
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
	
	$("#btnList").click(function(){
		location.href="/peekaboo21/notice/list.do";
	});
	$("#btnUpdate").click(function(){
		var str="";
		$("#uploadedList .file").each(function(i){
			str+="<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
		});
		$("#form1").append(str);
		document.form1.action="/peekaboo21/notice/update.do";
		document.form1.submit();
	});
	$("#btnDelete").click(function(){
		if(confirm("삭제하시겠습니까?")){
			document.form1.action="/peekaboo21/notice/delete.do";
			document.form1.submit();
		}
	});
});
function listAttach(){
	$.ajax({
		type:"post",
		url:"${path}/notice/getAttach/${dto.nno}",
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
<h2>Notice edit</h2>
<form id="form1" name="form1" method="post" enctype="multipart/form-data">
<div>작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></div>
<div>조회수 : ${dto.viewcnt}</div>
<div>이름 : ${dto.name}</div>
<div>제목 : <input name="title" value="${dto.title}"></div>
<div>
내용 <textarea rows="3" cols="80" name="content" id="content">${dto.content}</textarea>
</div>
<script>
CKEDITOR.replace("content",{filebrowserUploadUrl : "/peekaboo21/imageUpload.do", height:"800px"});
</script><br>
<div>
첨부파일 등록<br>
<div class="fileDrop"></div>
<div id="uploadedList"></div>
</div><br>
<div>
<input type="hidden" name="nno" value="${dto.nno}">
	<button type="button" id="btnUpdate" class="btn btn-warning">수정</button>
	<button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
	<button type="button" id="btnList" class="btn btn-success">목록</button>
</div>
</form>
</body>
</html>