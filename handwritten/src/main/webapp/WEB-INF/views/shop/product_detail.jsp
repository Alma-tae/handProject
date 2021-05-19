<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
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
	<h2>Product details</h2>
	<table border="0">
		<tr>
			<td>
				<div class="card mb-3" style="max-width: 30rem;">
					<div class="card-body">
						<h6 class="card-subtitle text-muted">예시 이미지입니다.</h6>
					</div>
					<img src="/peekaboo21/images/${dto.picture_url}" width="100%" height="300px">
				</div>
			</td>
			

			<td align="center">
			<div class="card mb-3">
 
  <ul class="list-group list-group-flush">
    <li class="list-group-item">Cras justo odio</li>
    <li class="list-group-item">Dapibus ac facilisis in</li>
    <li class="list-group-item">Vestibulum at eros</li>
  </ul>
  <div class="card-body">
    <a href="#" class="card-link">Card link</a>
    <a href="#" class="card-link">Another link</a>
  </div>
  
</div>

			
				<table border="0">
					<tr>
						<td class="table-warning">상품명</td>
						<td>${dto.product_name}</td>
					</tr>
					<tr>
						<td>가격</td>
						<td>${dto.price}</td>
					</tr>
					<tr>
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
								</select>&nbsp;개 &ensp; <input type="submit" class="btn btn-danger" value="장바구니에 담기">
							</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<input type="button" value="목록" class="btn btn-success"
		onclick="location.href='/peekaboo21/shop/product/list.do';">
</body>
</html>