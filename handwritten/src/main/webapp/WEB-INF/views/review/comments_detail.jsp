<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script>
$(function(){
	$("#btnCommentDelete").click(function(){
		$.ajax({
			type:"delete",
			url:"/peekaboo21/comments/delete/${dto.cno}",
			success:function(result){
				if(result=="success"){
					alert("삭제되었습니다.");
					$("#modifyComment").css("visibility","hidden");
					listComment_rest("1");
				}
			}
		});
	});
	$("#btnCommentUpdate").click(function(){
		var commenttext=$("#detail_commenttext").val();
		$.ajax({
			type:"put",
			url:"/peekaboo21/comments/update/${dto.cno}",
			headers:{"Content-Type":"application/json"},
			data:JSON.stringify({ commenttext : commenttext}),
			dataType:"text",
			success:function(result){
				if(result=="success"){
					$("#modifyComment").css("visibility","hidden");
					listComment_rest("1");
				}
			}
		});
	});
	$("#btnCommentClose").click(function(){
		$("#modifyComment").css("visibility", "hidden");
	});	
});
</script>
</head>
<body>
${dto.cno}<br>
<textarea id="detail_commenttext" rows="3" cols="40">${dto.commenttext}</textarea>
<div style="text-align:center;"> <!-- sessionScope.admin_email != null -->
<c:if test="${sessionScope.eamil == dto.commenter}">
	<button id="btnCommentUpdate" type="button">수정</button>
	<button id="btnCommentDelete" type="button">삭제</button>
</c:if>
	<button id="btnCommentClose" type="button">닫기</button>
</div>
</body>
</html>