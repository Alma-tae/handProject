<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice View</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script src="/peekaboo21/include/js/common.js"></script>
<script>
	$(function() {
		$("#btnEdit").click(function() {
			location.href = "/peekaboo21/notice/edit.do";
		});
		$("#btnList").click(function() {
			location.href = "/peekaboo21/notice/list.do";
		});
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
	});
	
	function listAttach(){
		$.ajax({
			type:"post",
			url:"/peekaboo21/notice/getAttach/${dto.nno}",
			success:function(list){
				$(list).each(function(){
					var fileInfo=getTileInfo(this);
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
	<h2>Notice detail</h2>
	<br>
	<form id="form1" name="form1" method="post">

		<div class="jumbotron">
			<h1>${dto.title}</h1>
			<p class="lead">${dto.content}<br>
			</p>
			<hr class="my-4">
			<p>
				<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss" />
			</p>
			<p class="text-success">조회수 : ${dto.viewcnt}</p>
			<p class="lead"></p>
		</div>
		<div>
		첨부파일<br>
		<div class="fileDrop"></div>
		<div id="uploadedList"></div>
		</div><br>
		<div>
			<c:if test="${sessionScope.admin_email != null}">
				<button type="button" class="btn btn-danger" onclick="location.href='/peekaboo21/notice/edit/${dto.nno}';">수정/삭제</button>
			</c:if> &ensp;
			<button type="button" id="btnList" class="btn btn-success">목록</button>
		</div>
		
	</form>
</body>
</html>