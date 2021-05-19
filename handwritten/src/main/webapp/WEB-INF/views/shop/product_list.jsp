<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script>
	$(function() {
		$("#btnAdd").click(function() {
			location.href = "/peekaboo21/shop/product/write.do"
		});
	});
</script>
<style>
table {
  border-spacing: 30px;
  border-collapse: separate;
  background: transparent;
  margin-left: auto;
  margin-right: auto;
}
table td {
  background: transparent;
}
</style>
</head>
<body>
	<h2>Products</h2>
	<c:if test="${sessionScope.admin_email != null}">
		<button type="button" id="btnAdd" class="btn btn-secondary disabled">상품등록</button>
	</c:if>
	<c:set var="i" value="0"/>
	<c:set var="j" value="4"/>
	<table border = "0">
	<c:forEach var="row" items="${list}">
	<c:if test="{i%j == 0}">
	<tr>
	</c:if>
	<td>
		<div class="card mb-3" style="max-width: 20rem;">
			<h3 class="card-header">
				<a href="/peekaboo21/shop/product/detail/${row.product_id}">${row.product_name}</a>
			</h3>
			<%--  <div class="card-body">
   				  <h6 class="card-subtitle text-muted">${row.product_id}</h6>
 				  </div> --%> 				  
			<img src="/peekaboo21/images/${row.picture_url}" width="100%" height="200px">
			<div class="card-body">
				<p class="card-text">
					<c:if test="${sessionScope.admin_email != null}">
						<br>
						<a href="/peekaboo21/shop/product/edit/${row.product_id}">[편집]</a>
					</c:if>
				</p>
				<fmt:formatNumber value="${row.price}" pattern="#,###" />
			</div>
		</div>
		</td>
		<c:if test="${i%j == j-1}">
	</tr>
		</c:if>
		<c:set var="i" value="${i+1}"/>
	</c:forEach>
	</table>
</body>
</html>