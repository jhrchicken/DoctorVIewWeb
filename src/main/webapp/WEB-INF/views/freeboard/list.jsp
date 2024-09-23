<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-edit.css" />
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	<main id="container">
		<div class="content">
			<h2>자유게시판</h2>
			<div class="board_inner">
				<div class="board_top">
					<p class="board_total">
						총 <strong>${ maps.total }</strong>건의 게시글이 있습니다.
					</p>
				</div>
				<!-- 검색 폼 -->
				<div class="board_search">
					<form class="searchForm" method="get" name="searchForm">
						<select class="searchField" name="searchField">
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
						<input class="searchWord" type="text" name="searchWord" placeholder="검색어를 입력하세요" />
						<input class="search_btn" type="submit" value="검색">
					</form>
				</div>
				
				<!-- 게시글 목록 -->
				<table class="board">
					<thead>
						<tr>
							<th width="100px">NO</th>
							<th width="150px">작성자</th>
							<th>제목</th>
							<th width="120px">작성일</th>
							<th width="100px">좋아요</th>
							<th width="100px">댓글</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${ empty postsList }">
								<tr>
									<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${ postsList }" var="row" varStatus="loop">
									<tr>
										<td class="num">${ maps.total - (((maps.pageNum-1) * maps.postsPerPage)	+ loop.index)}</td>
										<td class="name">${ row.writer_ref }</td>
										<td class="title">
											<a href="./freeboard/viewPost.do?board_idx=${ row.board_idx }">
												<p>${ row.title }</p>
												<p class="intro">${ row.content }</p>
											</a>
										</td>
										<td class="date">${ row.postdate }</td>
										<td class="like">하트 201</td>
										<td class="comment">댓글 138</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
				<!-- ***************** 로그인 한 경우에만 나타나도록 처리 ***************** -->
				<div class="write_btn">
					<button type="button" onclick="location.href='../freeboard/writePost.do';">글쓰기</button>
				</div>
				
				<!-- 하단 메뉴(바로가기, 글쓰기) -->
				<div class="pagination">
					<a class="prev" href="#"> < </a>
					<a class="active" href="#">1</a>
					<a href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a class="next" href="#"> > </a>
				</div>
<%-- 			    <table border="1" width="90%">
			        <tr align="center">
			            <td>
			                ${ pagingImg }
			            </td>
			            <td width="100"><button type="button"
			                onclick="location.href='./freeboard/writePost.do';">글쓰기</button></td>
			        </tr>
    			</table> --%>
				
			</div>
		</div>
	</main>
	<%-- <%@include file="../common/main_footer.jsp" %> --%>
</body>
</html>






