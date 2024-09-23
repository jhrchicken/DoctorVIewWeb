<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/board-view.css" />
<script>
function deletePost(board_idx) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		var form = document.deletePostForm;
		form.method = "post";
		form.action = "/freeboard/deletePost.do";
		form.submit();
	}
}
function deleteComment(board_ref, comm_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteCommentForm;
		// hidden 필드에 값을 동적으로 설정
        form.board_ref.value = board_ref;
        form.comm_idx.value = comm_idx;
		form.method = "post";
		form.action = "/freeboard/deleteComment.do";
		form.submit();
	}
}
function openWriteModal(board_idx) {
	document.getElementById("board_idx").value = board_idx;
}
function openEditModal(board_ref, comm_idx, content) {
	document.getElementById("board_ref").value = board_ref;
    document.getElementById("content").value = content;
    document.getElementById("comm_idx").value = comm_idx;
}
function validateCommentForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>
</head>
<body>
	<%@include file="../common/main_header.jsp" %>
	
	<main id="container">
		<div class="content">
			<!-- 게시글 -->
			<h2>게시글 상세보기</h2>	
			<div class="board_inner">
				<form name="deletePostForm">
					<input type="hidden" name="board_idx" value="${ boardDTO.board_idx }" />
				</form>
				
				<table class="board">
					<!-- 게시글 정보 -->
					<tr>
						<td class="left">제목</td>
						<td colspan="3">${ boardDTO.title }</td>
					</tr>
					<tr>
						<td class="left">작성자</td>
						<td colspan="3">${ boardDTO.writer_ref }</td>
					</tr>
					<tr>
						<td class="left">작성일</td> <td>${ boardDTO.postdate }</td>
						<td class="left">조회수</td> <td>${ boardDTO.visitcount }</td>
					</tr>
					<tr>
						<td class="left">내용</td>
						<td class="board_content" colspan="3">${ boardDTO.content }</td>
					</tr>
					<tr>
						<td class="left">좋아요</td> <td>${ likecount }</td>
						<td class="left">댓글</td> <td>${ commentcount }</td>
					</tr>
					<!-- 하단 메뉴(버튼) -->
				</table>
				<div class="board_btn">
					<button type="button" onclick="location.href='../freeboard.do';">뒤로가기</button>
					<button type="button" onclick="location.href='../freeboard/editPost.do?board_idx=${ param.board_idx }';">수정하기</button>
					<button type="button" onclick="deletePost(${ param.board_idx });">삭제하기</button>
				</div>
			</div>
		</div>
		
		<div class="board_btn">
			<button type="button" onclick="location.href='../freeboard/plusLike.do?board_idx=${ param.board_idx }';">
				<img src="/images/like.png" width="24px">
				${ likecount }
			</button>
			<button type="button" onclick="location.href='../freeboard/plusReport.do?board_idx=${ param.board_idx }';">
				<img src="/images/dislike.png" width="24px">
				${ boardDTO.reportcount }
			</button>
		</div>
		
		<form name="deleteCommentForm" method="post">
		    <input type="hidden" name="board_ref" value="" />
		    <input type="hidden" name="comm_idx" value="" />
		</form>
		<div>
		<div>
	  		<!-- 댓글 작성하기 버튼 -->
	  		<div class="comment_btn">
		  		<button type="button" data-bs-toggle="modal" data-bs-target="#writeCommentModal"
		  			onclick="openWriteModal(${ param.board_idx })">
	                댓글 작성하기
	            </button>
	  		</div>
		</div>
	</div>
		<table class="comment">
			<thead>
				<tr>
					<th width="150px">작성자</th>
					<th width="*">내용</th>
					<th width="150px">작성일</th>
					<th width="150px">수정 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${ empty commentsList }">
						<tr>
							<td colspan="4" align="center">
								댓글을 남겨보세요
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${ commentsList }" var="row" varStatus="loop">
							<tr align="center">
					            <td class="writer">${ row.writer_ref }</td>
					            <td class="comm_content" align="left">${ row.content }</td> 
					            <td class="postdate">${ row.postdate }</td>
							  	<td class="board_btn">
									<%-- <c:if test="${ row.id == id }"> --%>
										<!-- 수정 버튼 클릭 시 댓글 내용을 모달에 표시 -->
							            <button type="button" data-bs-toggle="modal" data-bs-target="#editCommentModal"
							                    onclick="openEditModal(${ row.board_ref }, ${ row.comm_idx }, '${ row.content }')">
							                수정
							            </button>
										<button type="button" onclick="deleteComment(${ row.board_ref }, ${ row.comm_idx });">
											삭제
										</button>
									<%-- </c:if> --%>
								</td>
					        </tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</main>
    <%-- <%@include file="../common/main_footer.jsp" %> --%>
    
    <!-- 댓글 작성 모달창 -->
	<form method="post" action="../freeboard/writeComment.do" onsubmit="return validateCommentForm(this);">
		<input type="hidden" id="board_idx" name="board_idx" value="" />
		<div class="modal" id="writeCommentModal" >
			<div class="modal-dialog">
				<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">댓글을 작성하세요</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<input type="text" name="id" placeholder="아이디를 작성하세요" />
					<textarea class="form-control" name="content" style="height: 100px;" placeholder="내용을 입력하세요"></textarea>
				</div>
				<!-- Modal Footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">작성하기</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
				</div>
			</div>
		</div>
	</form>

	<!-- 댓글 수정 모달창 -->
	<form method="post" action="../freeboard/editComment.do" onsubmit="return validateCommentForm(this);">
		<input type="hidden" id="board_ref" name="board_ref" value="" />
		<div class="modal" id="editCommentModal" >
			<div class="modal-dialog">
				<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">댓글을 수정하세요</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<input type="hidden" id="comm_idx" name="comm_idx" value="">
					<textarea class="form-control" id="content" name="content" style="height: 100px;"></textarea>
				</div>
				<!-- Modal Footer -->
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">수정하기</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
				</div>
			</div>
		</div>
	</form>
</body>   
</html>
	
	
	
	
	
	
	
	
	

