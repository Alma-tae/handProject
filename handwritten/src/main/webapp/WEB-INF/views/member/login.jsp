<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script>
$(function(){
	$("#btnLogin").click(function(){
		var email=$("#email").val();
		var pwd=$("#pwd").val();
		if(email == ""){
			alert("이메일을 입력하세요");
			$("#email").focus();
			return;
		}
		if(pwd == ""){
			alert("비밀번호를 입력하세요");
			$("#pwd").focus();
			return;
		}
		document.form1.action = "/peekaboo21/member/login_check.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<h2>Login</h2>
<form name="form1" method="post">
  <fieldset>
    <div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Enter email">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">Password</label>
      <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password">
      <small id="emailHelp" class="form-text text-muted">We'll never share your password with anyone else.</small>
    </div>
    <button type="button" class="btn btn-primary" id="btnLogin">Login</button><br>
  </fieldset>
  <c:if test="${param.message == 'nologin'}">
  	<div style="color:red;">
  	먼저 로그인하세요.
  	</div>
  </c:if>
  <c:if test="${message == 'error'}">
  	<div style="color:red;">
  	이메일 또는 비밀번호가 일치하지 않습니다.
  	</div>
  </c:if>
  <c:if test="${message == 'logout'}">
  	<div style="color:red;">
  	로그아웃 되었습니다.
  	</div>
  </c:if>
</form>
</body>
</html>