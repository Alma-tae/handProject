<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
<script>
$(function(){
	$("#btnJoin").click(function(){
		document.form1.action="/peekaboo21/member/insert.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<h2>Join</h2>
<form id="form1" name="form1" method="post">
  <fieldset>
    <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" name="email" aria-describedby="emailHelp" placeholder="Enter email">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">Password</label>
      <input type="password" class="form-control" name="pwd" placeholder="Password">
    </div>
   <div class="form-group">
  		<label class="col-form-label" for="inputDefault">Name</label>
  		<input type="text" class="form-control" placeholder="input" name="name">
     	<small id="emailHelp" class="form-text text-muted">사이트에서 사용하실 닉네임을 적어주세요.</small>
    </div>
     <button id="btnJoin" class="btn btn-primary">Join!</button>
  </fieldset>
</form>
</body>
</html>