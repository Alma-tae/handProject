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

		listAttach();

	});

	function listAttach() {
		$.ajax({
			type : "post",
			url : "/peekaboo21/notice/getAttach/${dto.nno}",
			success : function(list) {
				$(list).each(
				function() {
				var fileInfo = getFileInfo(this);
				var html = "<div><a href='"+fileInfo.getLink+"'>" + fileInfo.fileName + "</a>&nbsp;&nbsp;";
				$("#uploadedList").append(html);
				});
			}
		});
	}
</script>
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
			<div id="uploadedList"></div>
		</div>
		<br>
		<div>
			<c:if test="${sessionScope.admin_email != null}">
				<button type="button" class="btn btn-danger"
					onclick="location.href='/peekaboo21/notice/edit/${dto.nno}';">수정/삭제</button>
			</c:if>
			&ensp;
			<button type="button" id="btnList" class="btn btn-success">목록</button>
		</div>

	</form>
</body>
</html>