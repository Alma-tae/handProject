<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Write</title>
<script src="/peekaboo21/include/js/common.js"></script>
<script src="/peekaboo21/ckeditor/ckeditor.js"></script>
<script>
	$(function() {
		$("#btnSave").click(function() {
			var content = document.form1.content.value;
			var title = document.form1.title.value;
			if (title == "") {
				alert("제목을 입력하세요.");
				document.form1.title.focus();
				return;
			}
			document.form1.submit();
		});
	});
</script>
</head>
<body>
	<h2>Review write</h2>
	<form id="form1" name="form1" method="post"
		action="/peekaboo21/review/insert.do">
		<div>
			제목<input name="title" id="title" size="80" placeholder="제목을 입력하세요.">
		</div>
		<br>
		<div>
			내용
			<textarea id="content" name="content" rows="5" cols="80"
				placeholder="내용을 입력하세요"></textarea>
		</div>
		<script>
			CKEDITOR.replace("content", {
				filebrowserUploadUrl : "/peekaboo21/imageUpload.do"
			});
		</script>
		<br>
		<div>
			<button type="button" id="btnSave" class="btn btn-warning">확인</button>
		</div>
	</form>
</body>
</html>