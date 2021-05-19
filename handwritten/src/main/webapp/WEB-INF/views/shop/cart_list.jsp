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
	$("#btnList").click(function(){
		location.href="/peekaboo21/shop/product/list.do";
	});
	$("#btnDelete").click(function(){
		if(confirm("장바구니를 비우시겠습니까?")){
			location.href="/peekaboo21/shop/cart/deleteAll.do";
		}
	});
	$("#btnOrder").click(function(){
		if(confirm("주문하시겠습니까?")){
			location.href="/peekaboo21/shop/cart/order.do";
		}
	}); 
});
</script>
</head>
<body>
<h2>Cart</h2>
<c:choose>
	<c:when test="${map.count == 0}">장바구니가 비었습니다.
	</c:when>
	<c:otherwise>
		<form id="form1" name="form1" method="post" action="/peekaboo21/shop/cart/update.do">
		<table border="1" class="table table-hover">
			<tr class="table-secondary">
				<th scope="col">상품명</th>
				<th scope="col">단가</th>
				<th scope="col">수량</th>
				<th scope="col">금액</th>
				<th scope="col">&nbsp;</th>
			</tr>
	<c:forEach var="row" items="${map.list}">
			<tr class="table-info">
			<td>${row.product_name}</td>
			<td>${row.price}</td>
			<td><input type="number" style="width:30px;" min="0" max="100" name="amount" value="${row.amount}">
				<input type="hidden" name="cart_id" value="${row.cart_id}">
			</td>
			<td>${row.money}</td>
			<td><a href="/peekaboo21/shop/cart/delete.do?cart_id=${row.cart_id}">삭제</a></td>
			</tr>
	</c:forEach>
			<tr>
				<td colspan="5" align="right">장바구니 금액 합계:
				<fmt:formatNumber value="${map.sumMoney}" pattern="#,###,###" /><br>
				수수료 : ${map.fee}<br>
				총합계 : <fmt:formatNumber value="${map.sum}" pattern="#,###,###" /></td>
			</tr>
		</table>
			<button id="btnUpdate" class="btn btn-success disabled">수정</button>
			<button type="button"  id="btnDelete" class="btn btn-danger disabled">장바구니 비우기</button>
			<button type="button" class="btn btn-info disabled" id="btnOrder">주문</button>
		</form>
	</c:otherwise>
</c:choose>
	<div>
	<br><br>
	<button type="button" id="btnList" class="btn btn-success">상품목록</button>
	</div>
</body>
</html>