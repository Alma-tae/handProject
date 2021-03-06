<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review List</title>
<%@ include file="/WEB-INF/views/include/factor.jsp"%>
<script>
	$(function() {
		$("#btnWrite").click(function() {
			location.href = "/peekaboo21/review/write.do";
		});
	});
	
	function list(page) {
		location.href = "/peekaboo21/review/list.do?curPage=" + page
				+ "&search_option=${map.search_option}"
				+ "&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<h2>Review board</h2>
	<form name="form1" method="post" action="/peekaboo21/review/list.do">
		<select name="search_option">
			<option value="all"
				<c:out value="${map.search_option =='all'?'selected':''}"/>>이름+내용+제목</option>
			<option value="name"
				<c:out value="${map.search_option =='name'?'selected':''}"/>>이름</option>
			<option value="content"
				<c:out value="${map.search_option =='content'?'selected':''}"/>>내용</option>
			<option value="title"
				<c:out value="${map.search_option =='title'?'selected':''}"/>>제목</option>
		</select>
		 <input name="keyword" style="width:300px;" value="${map.keyword}"> 
		 <input type="submit" class="btn btn-danger disabled" value="조회">
		&ensp;
		<c:choose>
			<c:when
				test="${sessionScope.email != null && sessionScope.admin_email == null}">
				<button type="button" id="btnWrite"
					class="btn btn-outline-secondary">글쓰기</button>
			</c:when>
			<c:when test="${sessionScope.admin_email != null}">
				<button type="button" id="btnManage"
					class="btn btn-outline-secondary">글관리</button>
			</c:when>
			<c:otherwise>
				
			</c:otherwise>
		</c:choose>
	</form>
	${map.count}개의 게시물이 있습니다.
	<table class="table table-hover" border="1">
		<tr class="table-danger">
			<th>번호</th>
			<th>제목</th>
			<th>이름</th>
			<th>내용</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="row" items="${map.list}">
			<c:choose>
				<c:when test="${row.show == 'Y'}">
					<tr>
						<td>${row.rno}</td>
						<td><a href="/peekaboo21/review/view.do?rno=${row.rno}&curPage=${map.pager.curPage}&search_option=${map.search_option}&keyword=${map.keyword}">${row.title}</a>
							<c:if test="${row.cnt > 0}">
								<span style="color: red">( ${row.cnt} )</span>
							</c:if></td>
						<td>${row.name}</td>
						<td>${row.content}</td>
						<td>${row.viewcnt}</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="5" align="center"><c:if test="${row.cnt > 0}">
								<a href="/peekaboo21/review/view.do?rno=${row.rno}&curPage=${map.pager.curPage}&search_option=${map.search_option}&keyword=${map.keyword}">삭제된 게시물입니다.</a>
								<span style="color: red">( ${row.cnt} )</span>
							</c:if> <c:if test="${row.cnt == 0}">삭제된 게시물입니다.</c:if></td>
					</tr>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<tr>
			<td colspan="5" align="center">
				<c:if test="${map.pager.curBlock > 1}">
					<a href="javascript:list('1')">[처음]</a>
				</c:if> 
				<c:if test="${map.pager.curBlock > 1}">
					<a href="javascript:list('${map.pager.prevPage}')">[이전]</a>
				</c:if> 
				<c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
					<c:choose>
						<c:when test="${num == map.pager.curPage}">
							<span style="color: red">${num}</span>&nbsp;
						</c:when>
						<c:otherwise>
							<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach> 
				<c:if test="${map.pager.curBlock <= map.pager.totBlock}">
					<a href="javascript:list('${map.pager.nextPage}')">[다음]</a>
				</c:if>
				<c:if test="${map.pager.curPage <= map.pager.totPage}">
					<a href="javascript:list('${map.pager.totPage}')">[끝]</a>
				</c:if>
			</td>
		</tr>
	</table>
</body>
</html>