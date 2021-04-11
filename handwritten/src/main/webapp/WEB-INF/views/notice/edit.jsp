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
</script>
</head>
<body>
<h2>Notice edit</h2>
<form id="form1" name="form1" method="post">
<div>작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/></div>
<div>조회수 : ${dto.viewcnt}</div>
<div>이름 : ${dto.name}</div>
<div>제목 : <input name="title" value="${dto.title}"></div>
<div>
내용 : <textarea rows="3" cols="80" name="content" id="content">${dto.content}</textarea>
</div>
<script>
CKEDITOR.replace("content",{filebrowserUploadUrl : "/peekaboo21/imageUpload.do", height:"800px"});
</script><br>
<div>
<input type="hidden" name="nno" value="${dto.nno}">
	<button type="button" id="btnUpdate">수정</button>
	<button type="button" id="btnDelete">삭제</button>
	<button type="button" id="btnList">목록</button>
</div>
</form>
</body>
</html>