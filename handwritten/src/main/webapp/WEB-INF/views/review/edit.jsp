<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Edit</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script src="/peekaboo21/include/js/common.js"></script>
<script src="/peekaboo21/ckeditor/ckeditor.js"></script>
<script>
	$(function() {
		$("#btnList").click(function() {
			location.href = "/peekaboo21/review/list.do";
		});
		
		$("#btnUpdate").click(function() {
			var str = "";
			$("#form1").append(str);
			document.form1.action = "/peekaboo21/review/update.do";
			document.form1.submit();
		});
		
		$("#btnDelete").click(function() {
			if (confirm("삭제하시겠습니까?")) {
				document.form1.action = "/peekaboo21/review/delete.do";
				document.form1.submit();
			}
		});
	});
</script>
</head>
<body>
	<h2>Review edit</h2>
	<form id="form1" name="form1" method="post">
		<div>
			작성일자 :
			<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss" />
		</div>
		<div>조회수 : ${dto.viewcnt}</div>
		<div>이름 : ${dto.name}</div>
		<div>
			제목 : <input name="title" style="width:300px;" value="${dto.title}">
		</div>
		<br>
		<div>
			내용
			<textarea rows="3" cols="80" name="content" id="content">${dto.content}</textarea>
		</div>
		<script>
			CKEDITOR.replace("content", {
				filebrowserUploadUrl : "/peekaboo21/imageUpload.do"
			});
		</script>
		<br>
		<div>
			<input type="hidden" name="rno" value="${dto.rno}">
			<button type="button" id="btnUpdate" class="btn btn-warning">수정</button>
			<button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
			<button type="button" id="btnList" class="btn btn-success">목록</button>
		</div>
	</form>
</body>
</html>