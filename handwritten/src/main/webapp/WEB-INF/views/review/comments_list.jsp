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
	<table style="width: 700px;">
		<%
		pageContext.setAttribute("newLineChar", "\n");
		%>
		<c:forEach var="row" items="${list}">
			<c:set var="str"
				value="${fn:replace(row.commenttext, '  ','&nbsp;&nbsp;')}" />
			<c:set var="str" value="${fn:replace(str,newLineChar,'<br>')}" />
			<tr>
				<td>${row.name}(<fmt:formatDate value="${row.regdate}"
						pattern="yyyy-MM-dd HH:mm:ss" />)<br> 
					${str} <c:if test="${sessionScope.admin_email != null}">
					<input type="button" value="Modify" id="showModify('${row.cno}')">
					 </c:if> 
				</td>
			</tr>
		</c:forEach>
		<tr>
			<td><c:if test="${pager.curBlock > 1}">
					<a href="javascript:listComments('${pager.prevPage}')">[이전]</a>&nbsp;
		</c:if> <c:forEach var="num" begin="${pager.blockBegin}"
					end="${pager.blockEnd}">
					<c:choose>
						<c:when test="${num == pager.curPage}">${num}&nbsp;</c:when>
						<c:otherwise>
							<a href="javascript:listComments('${num}')">${num}</a>&nbsp;
		</c:otherwise>
					</c:choose>
				</c:forEach> <c:if test="${pager.curBlock <= pager.totBlock}">
					<a href="javascript:listComments('${pager.nextPage}')">[다음]</a>&nbsp;
		</c:if></td>
		</tr>
	</table>
</body>
</html>