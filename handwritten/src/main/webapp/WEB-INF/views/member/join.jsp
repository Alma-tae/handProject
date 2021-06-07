<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
<script>
	$(function() {
		$("#btnJoin").click(function() {
			var email = $("#email").val();
			var pwd = $("#pwd").val();
			var name = $("#name").val();
			var emailCheck = $("#emailCheck").val();
			if (email == "") {
				alert("이메일을 입력하세요");
				$("#email").focus();
				return;
			}
			if (pwd == "") {
				alert("비밀번호를 입력하세요");
				$("#pwd").focus();
				return;
			}
			if (name == "") {
				alert("이름을 입력하세요");
				$("#name").focus();
				return;
			}
			if (emailCheck == "N") {
				alert("중복확인 버튼을 눌러주세요");
				return false;
			} else if (emailCheck == "Y") {
				document.form1.action = "/peekaboo21/member/insert.do";
				document.form1.submit();
			}
		});
	});

	function fn_emailCheck() {
		$.ajax({
			url : "/peekaboo21/member/emailCheck.do",
			type : "post",
			dataType : "json",
			data : {
				"email" : $("#email").val()
			},
			success : function(data) {
				if (data == 1) {
					alert("중복된 이메일입니다.");
				} else if (data == 0) {
					$("#emailCheck").attr("value", "Y");
					alert("사용 가능한 이메일입니다.");
				} else {
					alert("이메일을 입력하세요.")
				}
			}
		})
	}
</script>
</head>
<body>
	<h2>Join</h2>
	<form id="form1" name="form1" method="post">
		<fieldset>
			<div class="form-group">
				<label for="exampleInputEmail1">Email address</label> <input
					type="email" class="form-control" name="email" id="email"
					aria-describedby="emailHelp" placeholder="Enter email"><br>
				<button class="emailCheck" type="button" id="emailCheck"
					onclick="fn_emailCheck();" value="N">중복확인</button>
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">Password</label> <input
					type="password" class="form-control" name="pwd"
					placeholder="Password">
			</div>
			<div class="form-group">
				<label class="col-form-label" for="inputDefault">Name</label> <input
					type="text" class="form-control" placeholder="input" name="name">
				<small id="emailHelp" class="form-text text-muted">사이트에서
					사용하실 닉네임을 적어주세요.</small>
			</div>
			<button id="btnJoin" class="btn btn-primary">Join!</button>
		</fieldset>
	</form>
</body>
</html>