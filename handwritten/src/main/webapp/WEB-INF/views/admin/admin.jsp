<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin page</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<style>
div {
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body>
<h2>A.page</h2>
<br>
<%@ include file="../include/admin_menu.jsp" %>
<br><br>
<c:if test="${message == 'success'}">
<h2>${sessionScope.admin_name}, Cheer up!</h2>
</c:if>
<div class="card text-white bg-info mb-3" style="max-width: 20rem;">
  <div class="card-header">Header</div>
  <div class="card-body">
    <h4 class="card-title">Info card title</h4>
    <p class="card-text">What do I need to do?</p>
  </div>
</div>
</body>
</html>