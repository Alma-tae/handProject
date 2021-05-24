<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Comments Detail</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script>
	$(function() {
		$("#btnCommentsDelete").click(function() {
			$.ajax({
				type : "delete",
				url : "/peekaboo21/comments/delete/${dto.cno}",
				success : function(result) {
					if (result == "success") {
						alert("삭제되었습니다.");
						$("#modifyComments").css("visibility", "hidden");
						listComments("1");
					}
				}
			});
		});
		
		$("#btnCommentsUpdate").click(function() {
			var commenttext = $("#detail_commenttext").val();
			$.ajax({
				type : "put",
				url : "/peekaboo21/comments/update/${dto.cno}",
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					commenttext : commenttext
				}),
				dataType : "text",
				success : function(result) {
					if (result == "success") {
						$("#modifyComments").css("visibility", "hidden");
						listComments("1");
					}
				}
			});
		});
		
		$("#btnCommentsClose").click(function() {
			$("#modifyComments").css("visibility", "hidden");
		});
	});
</script>
</head>
<body>
	${dto.cno}
	<br>
	<textarea id="detail_commenttext" rows="3" cols="40">${dto.commenttext}</textarea>
	<div style="text-align: center;">
		<c:if test="${sessionScope.admin_email != null}">
			<button id="btnCommentsUpdate" type="button">수정</button>
			<button id="btnCommentsDelete" type="button">삭제</button>
			<button id="btnCommentsClose" type="button">닫기</button>
		</c:if>
	</div>
</body>
</html>