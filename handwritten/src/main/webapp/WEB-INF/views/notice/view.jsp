<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice View</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script>
	$(function() {
		$("#btnEdit").click(function() {
			location.href = "/peekaboo21/notice/edit.do";
		});
		$("#btnList").click(function() {
			location.href = "/peekaboo21/notice/list.do";
		});
	});
</script>
<style>
.oriImg {width:500px; height:auto;}
</style>
</head>
<body>
	<h2>Notice detail</h2>
	<form id="form1" name="form1" method="post">

		<div class="jumbotron">
			<h1>${dto.title}</h1>
			<p class="lead">${dto.content}<br>
			</p>
			<p><img src="${dto.img}" class="oriImg"/></p>
			<hr class="my-4">
			<p>
				<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss" />
			</p>
			<p class="text-success">조회수 : ${dto.viewcnt}</p>
			<p class="lead"></p>
		</div>
		<div>
			<c:if test="${sessionScope.admin_email != null}">
				<button type="button" onclick="location.href='/peekaboo21/notice/edit/${dto.nno}';">수정/삭제</button>
			</c:if>
			<button type="button" id="btnList">목록</button>
		</div>

	</form>
</body>
</html>