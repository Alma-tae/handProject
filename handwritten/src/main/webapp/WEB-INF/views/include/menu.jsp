<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/factor.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(function() {
		$("#btnMjoin").click(function() {
			location.href = "/peekaboo21/member/join.do";
		});
		$("#btnMlogin").click(function() {
			location.href = "/peekaboo21/member/login.do";
		});
		$("#btnMview").click(function() {
			location.href = "/peekaboo21/member/view.do";
		});
		$("#btnMlogout").click(function() {
			location.href = "/peekaboo21/member/logout.do";
		});
		$("#btnAlogin").click(function() {
			location.href = "/peekaboo21/admin/login.do";
		});
		$("#btnAdmin").click(function() {
			location.href = "/peekaboo21/admin/page.do";
		});
		$("#btnAlogout").click(function() {
			location.href = "/peekaboo21/admin/logout.do";
		});
	});
</script>
</head>
<body>
	<h1>Hand Written Letter</h1>
	<p class="text-info">어느날, 당신에게 손편지가</p>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="collapse navbar-collapse" id="navbarColor03">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
				<a class="nav-link" href="/peekaboo21">Home<span class="sr-only"></span></a></li>
				<li class="nav-item">
				<a class="nav-link" href="/peekaboo21/shop/product/list.do">Product</a></li>
				<li class="nav-item">
				<a class="nav-link" href="/peekaboo21/notice/list.do">Notice</a></li>
				<li class="nav-item">
				<a class="nav-link" href="/peekaboo21/review/list.do">Review</a></li>
				<li class="nav-item">
				<a class="nav-link" href="/peekaboo21/shop/cart/list.do">Cart</a></li>
				<li class="nav-item">
				<a class="nav-link" href="/peekaboo21/post/list.do">Post office</a></li>
			</ul>
		</div>
		<div class="form-row float-right">
			<c:choose>
				<c:when test="${sessionScope.email == null}">
					<button type="button" class="btn btn-success" id="btnMjoin">Join us</button>
					<button type="button" class="btn btn-warning" id="btnMlogin">Login</button>
					<button type="button" class="btn btn-outline-danger" id="btnAlogin">A.Login</button>
				</c:when>
				<c:when test="${sessionScope.admin_email != null}">
					<button type="button" class="btn btn-outline-secondary"
						id="btnAdmin">A.page</button>
					<button type="button" class="btn btn-outline-danger"
						id="btnAlogout">A.Logout</button>
				</c:when>
				<c:otherwise>${sessionScope.name}님, 환영합니다. &nbsp;
		<button type="button" class="btn btn-success" id="btnMview">My page</button>
					<button type="button" class="btn btn-warning" id="btnMlogout">Logout</button>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
</body>
</html>