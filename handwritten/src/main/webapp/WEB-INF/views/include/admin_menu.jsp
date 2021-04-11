<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
	$(function() {
		$("#btnAlogin").click(function() {
			location.href = "/peekaboo21/admin/login.do";
		});
	});
</script>
</head>
<body>
	<div>
		<button type="button" class="btn btn-outline-primary">Home</button>
		<button type="button" class="btn btn-outline-success">Member</button>
		<button type="button" class="btn btn-outline-info">Order</button>
		<button type="button" class="btn btn-outline-warning">Warning</button>
	</div>
</body>
</html>