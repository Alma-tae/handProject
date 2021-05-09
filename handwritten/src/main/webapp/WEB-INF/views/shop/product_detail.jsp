<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
</head>
<body>
<h2>Product details</h2>
<table class="table table-hover">
	<tr>
		<td><img src="/peekaboo21/images/${dto.picture_url}" width="300px" height="300px"></td>
		<td align="center">
			<table border="1">
				<tr class="table-danger">
					<td>상품명</td>
					<td>${dto.product_name}</td>
				</tr>
				<tr class="table-warning">
					<td>가격</td>
					<td>${dto.price}</td>
				</tr>
				<tr class="table-success">
					<td>설명</td>
					<td>${dto.description}</td>
				</tr>
				<tr>
					<td colspan="2">
					<form name="form1" method="post" action="/peekaboo21/shop/cart/insert.do">
					<input type="hidden" name="product_id" value="${dto.product_id}">
					<select name="amount">
					<c:forEach begin="1" end="10" var="i">
						<option value="${i}">${i}</option>
					</c:forEach>
					</select>&nbsp;개
					<input type="submit" value="장바구니에 담기">
					</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<input type="button" value="목록" onclick="location.href='/peekaboo21/shop/product/list.do';">
</body>
</html>