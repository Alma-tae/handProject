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
	$("#btnEdit").click(function(){
		location.href="/peekaboo21/review/edit.do";
	});
	$("#btnList").click(function(){
		console.log("list");
		location.href="/peekaboo21/review/list.do";
	});
	
	listComments("1"); //댓글 1페이지
	$("#btnComments").click(function(){
		comments();
	});
});
function comments(){
	var commenttext=$("#commenttext").val();
	var rno="${dto.rno}";
	var param ={"commenttext":commenttext, "rno":rno};
	$.ajax({
		type:"post",
		url:"/peekaboo21/comments/insert.do",
		data : param,
		success:function(){
			alert("댓글이 등록되었습니다.");
			listComments("1");
		}
	});
}
/* function listComments2(){
	$.ajax({
		type:"get",
		contentType:"application/json",
		url:"/peekaboo21/comments/list_json.do?rno=${dto.rno}",
		success:function(result){
			console.log(result);
			var output="<table>";
			for(var i in result){
				var commentl = result[i].commenttext;
				commentl = commentl.replace(/\n/gi,"<br>");
				commentl = commentl.replace(/  /gi, "&nbsp;&nbsp;");
				output += "<tr>";
				output += "<td>"+result[i].name;
				output += "(" + changeDate(result[i].regdate)+")";
				output += "<br>" + commentl;
				output += "<input type='button' value='Modify' onclick='showModify(\""+result[i].cno+"\")'>";
				output += "</td></tr>";
			}
			output += "</table>";
			$("#listComments").html(output);
		}
	});
} */
function changeDate(date){
	date = new Date(parseInt(date));
	year = date.getFullYear();
	month = date.getMonth();
	day = date.getDate();
	hour = date.getHours();
	minute = date.getMinutes();
	second = date.getSeconds();
	strDate = year +"-"+ month +"-"+ day +" "+ hour +":"+ minute +":"+ second;
	return strDate;
}
function listComments(num){
	$.ajax({
		type:"get",
		url:"/peekaboo21/comments/list.do?rno=${dto.rno}&curPage="+num,
		success : function(result){
			$("#listComments").html(result);
		}
	});
}
/* function showModify(cno){
	$.ajax({
		type:"get",
		url:"/peekaboo21/comments/detail/"+ cno,
		success:function(result){
			$("#modifyComment").html(result);
			// 태그.css("속성","값")
			$("#modifyComment").css("visibility","visible");
		}
	});
} */
</script>
<style>
div {
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body>
<h2>Review detail</h2>
<form id="form1" name="form1" method="post">

<div class="jumbotron">
  <h1>${dto.title}</h1>
  <p class="lead">${dto.content}<br></p>
  <hr class="my-4">
  <p><fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></p>
  <p class="text-success">조회수 : ${dto.viewcnt}</p>
  <p class="lead">
  </p>
</div>
<div>
<input type="hidden" name="rno" value="${dto.rno}">
<c:if test="${sessionScope.email == dto.writer}">
	<button type="button" class="btn btn-danger" onclick="location.href='/peekaboo21/review/edit/${dto.rno}';">수정/삭제</button>
</c:if>
	<button type="button" id="btnList" class="btn btn-success">목록</button>
</div>
</form>
<br>
<div style="width:700px; text-aligh:center;">
<c:if test="${sessionScope.admin_email != null}">
<textarea rows="5" cols="80" name="commenttext" id="commenttext" placeholder="댓글을 작성하세요"></textarea><br>
<button type="button" id="btnComments" class="btn btn-outline-secondary">댓글쓰기</button>
</c:if>
</div>
<div style="margin:auto;" id="listComments"></div>
</body>
</html>