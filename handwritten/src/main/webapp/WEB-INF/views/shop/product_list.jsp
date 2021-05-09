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
	$("#btnAdd").click(function(){
		location.href="/peekaboo21/shop/product/write.do"
	});
});
</script>
<style>
tr {display : block; float: left;}
th, td {display: block;}
</style>
</head>
<body>
<h2>Products</h2>
<c:if test="${sessionScope.admin_email != null}">
	<button type="button" id="btnAdd">상품등록</button>
</c:if>
<table class="table table-hover" border="1">
    <tr class="table-success">
      <th scope="col">상품 ID</th>
      <th scope="col"><br><br>예시 이미지<br><br></th>
      <th scope="col">상품명</th>
      <th scope="col">가격</th>
    </tr>
  <c:forEach var="row" items="${list}">
    <tr class="table-warning">
     <!--  <th scope="row">Success</th> -->
      <td>${row.product_id}</td>
      <td><img src="/peekaboo21/images/${row.picture_url}" width="100px" height="100px"></td>
      <td><a href="/peekaboo21/shop/product/detail/${row.product_id}">${row.product_name}</a>
      <c:if test="${sessionScope.admin_email != null}"><br>
      <a href="/peekaboo21/shop/product/edit/${row.product_id}">[편집]</a></c:if></td>
      <td><fmt:formatNumber value="${row.price}" pattern="#,###"/></td>
    </tr>
   </c:forEach>
</table>
</body>
</html>