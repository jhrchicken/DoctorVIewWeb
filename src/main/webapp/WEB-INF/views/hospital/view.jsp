<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
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
<link rel="stylesheet" href="/css/doc-view.css" />
<script>
function deleteReview(doc_ref, review_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteReviewForm;
		// hidden 필드에 값을 동적으로 설정
        form.doc_ref.value = doc_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/doctor/deleteReview.do";
		form.submit();
	}
}
function deleteReply(doc_ref, review_idx) {
	if (confirm("답변을 삭제하시겠습니까?")) {
		var form = document.deleteReplyForm;
		// hidden 필드에 값을 동적으로 설정
        form.doc_ref.value = doc_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/doctor/deleteReply.do";
		form.submit();
	}
}

function openReviewWriteModal(doc_idx) {
	document.getElementById("doc_idx").value = doc_idx;
}
function openReviewEditModal(doc_ref, review_idx, score, content) {
	document.getElementById("doc_ref").value = doc_ref;
    document.getElementById("score").value = score;
    document.getElementById("content").value = content;
    document.getElementById("review_idx").value = review_idx;
}
function openReplyWriteModal(doc_ref, review_idx) {
	document.getElementById("reply_doc_ref").value = doc_ref;
    document.getElementById("reply_review_idx").value = review_idx;
}
function openReplyEditModal(doc_ref, review_idx, content) {
	document.getElementById("reply_edit_doc_ref").value = doc_ref;
    document.getElementById("reply_edit_content").value = content;
    document.getElementById("reply_edit_review_idx").value = review_idx;
}
function validateReviewForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
function validateReplyForm(form) {
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
		<div class="content_inner">

			<div class="doc_info">
				<!-- 병원 사진 -->
				<c:if test="${ hospitalDTO.photo == null }">
					<span class="img">
						<img src="/images/hospital.png" alt="" />
					</span>
				</c:if>
				<c:if test="${ hospitalDTO.photo != null }">
					<span class="img">
						<img src="/uploads/${ row.photo }"><br/>
					</span>
				</c:if>
				
				<div class="info">
					<div class="info_top">
						<p>${ hospitalDTO.department }</p>
						<h3>${ hospitalDTO.name }</h3>
					</div>
					<div class="detail">
						<div class="details">
							<p class="blue">전화</p>
							<p>${ hospitalDTO.tel }</p>
						</div>
						<div class="details">
							<p class="blue">교통편</p>
							<p>${ doctorDTO.parking }</p>
						</div>
						<div class="details">
							<p class="blue">주차</p>
							<p>${ doctorDTO.parking }</p>
						</div>
						<div class="details">
							<p class="blue">PCR 검사 가능 여부</p>
							<p>${ doctorDTO.pcr }</p>
						</div>
						<div class="details">
							<p class="blue">예약제</p>
							<p>${ doctorDTO.system }</p>
						</div>
						<div class="details">
							<p class="blue">입원</p>
							<p>${ doctorDTO.hospitalize }</p>
						</div>
					</div>
					
					<div class="doc_like">
						<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
						<c:if test="${ hosplikecheck == 0 }">
							<div class="like_wrap">
								<button type="button" onclick="location.href='../hospital/clickHospLike.do?hospId=${ param.id }';"></button>
								<p class="like">${ hospitalDTO.likecount }</p>
							</div>
						</c:if>
						<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
						<c:if test="${ hosplikecheck == 1 }">
							<div class="like_wrap">
								<button class="push" type="button" onclick="location.href='../hospital/clickHospLike.do?hospId=${ param.id }';"></button>
								<p class="like">${ hospitalDTO.likecount }</p>
							</div>
						</c:if>
					</div>
					
					<!-- 하단 메뉴(버튼) -->
					<div class="board_btn">
						<button type="button" onclick="location.href='../doctor/editDoctor.do?doc_idx=${ param.doc_idx }';">수정하기</button>
						<button type="button" onclick="deleteDoctor(${ param.doc_idx });">삭제하기</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="comment_inner">
			<!-- 댓글 -->
			<form name="deleteReviewForm" method="post">
			    <input type="hidden" name="doc_ref" value="" />
			    <input type="hidden" name="review_idx" value="" />
			</form>
			<form name="deleteReplyForm" method="post">
			    <input type="hidden" name="doc_ref" value="" />
			    <input type="hidden" name="review_idx" value="" />
			</form>
			<!-- 로그인 한 경우 리뷰 작성 버튼 -->
	  		<c:if test="${ not empty sessionScope.userId }">
		  		<div class="comment_btn">
			  		<button type="button" data-bs-toggle="modal" data-bs-target="#writeReviewModal"
			  			onclick="openReviewWriteModal(${ param.doc_idx })">
		                리뷰 작성하기
		            </button>
	  			</div>
	  		</c:if>
			
			<table class="comment">
				<thead align="center">
					<th width="100px">작성자</th>
					<th width="*">내용</th>
					<th width="100px">별점</th>
					<th width="150px">작성일</th>
					<th width="100px">수정 여부</th>
					<th width="150px">수정 / 삭제</th>
					<th width="150px">답변달기</th>
					<th width="150px">좋아요</th>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${ empty reviewsList }">
							<tr>
								<td colspan="8" align="center">
									댓글을 남겨보세요
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${ reviewsList }" var="row" varStatus="loop">
								<c:if test="${ row.original_idx == row.review_idx }">
									
								    <!-- 리뷰 출력 -->
								    <tr align="center">
								        <td class="writer">${ row.nickname }</td>
								        <td class="content" align="left">${ row.content }</td>
								        <td class="score">${ row.score }</td>
								        <td class="postdate">${ row.postdate }</td>
								        <td class="rewrite">${ row.rewrite }</td>
								        <td class="comm_btn">
								            <!-- 로그인 사용자와 댓글 작성자가 일치하는 경우 수정 삭제 버튼 -->
								            <c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
								                <button type="button" data-bs-toggle="modal" data-bs-target="#editReviewModal"
								                        onclick="openReviewEditModal(${ row.doc_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }')">
								                    수정
								                </button>
								                <button type="button" onclick="deleteReview(${ row.doc_ref }, ${ row.review_idx });">
								                    삭제
								                </button>
								            </c:if>
								        </td>
								        <td>
								            <div class="comm_write_btn">
								                <button type="button" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
								                        onclick="openReplyWriteModal(${ row.doc_ref }, ${ row.review_idx })">
								                    답변 작성하기
								                </button>
								            </div>
								        </td>
								        <td>
								            <div class="comm_like_btn">
								                <!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
								                <c:if test="${ reviewlikecheck == 0 }">
								                	<div class="like_wrap">
									                    <button type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';"></button>
								                        <p class="like">${ row.likecount }</p>
								                	</div>
								                </c:if>
								                <!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
								                <c:if test="${ reviewlikecheck == 1 }">
								                    <div class="like_wrap">
									                    <button class="push" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';"></button>
								                        <p class="like">${ row.likecount }</p>
								                    </div>
								                </c:if>
								            </div>
								        </td>
							    	</tr>
							    </c:if>
							
							    <!-- 리뷰에 대한 답변 출력 -->
							    <c:forEach items="${ reviewsList }" var="replyRow">
							        <c:if test="${ replyRow.original_idx == row.review_idx and replyRow.review_idx != replyRow.original_idx }">
							            <tr class="replyRow" align="center">
							                <td class="writer reply">하하${ replyRow.nickname }</td>
							                <td class="content reply" align="left">${ replyRow.content }</td>
							                <td class="score"></td>
							                <td class="postdate">${ replyRow.postdate }</td>
							                <td class="rewrite">${ replyRow.rewrite }</td>
							                <td class="comm_btn">
							                    <!-- 로그인 사용자와 답변 작성자가 일치하는 경우 수정 삭제 버튼 -->
							                    <c:if test="${ replyRow.writer_ref.equals(sessionScope.userId) }">
							                        <button type="button" data-bs-toggle="modal" data-bs-target="#editReplyModal"
							                                onclick="openReplyEditModal(${ replyRow.doc_ref }, ${ replyRow.review_idx }, '${ replyRow.content }')">
							                            수정
							                        </button>
							                        <button type="button" onclick="deleteReply(${ replyRow.doc_ref }, ${ replyRow.review_idx });">
							                            삭제
							                        </button>
							                    </c:if>
							                </td>
							            </tr>
							        </c:if>
							    </c:forEach>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>	
</main>
<%@include file="../common/main_footer.jsp" %>
   
<!-- 리뷰 작성 모달창 -->
<form method="post" action="../doctor/writeReview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="doc_idx" name="doc_idx" value="" />
	<div class="modal" id="writeReviewModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">의사 리뷰 작성</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
	
					<textarea class="form-control mb-3" name="score" style="height: 20px;" placeholder="점수를 입력하세요 (1~5)"></textarea>
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

<!-- 리뷰 수정 모달창 -->
<form method="post" action="../doctor/editReview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="doc_ref" name="doc_ref" value="" />
	<div class="modal" id="editReviewModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">의사 리뷰 수정</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<input type="hidden" id="review_idx" name="review_idx" value="">
					<textarea class="form-control mb-3" id="score" name="score" style="height: 20px;"></textarea>
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

<!-- 답변 작성 모달창 -->
<form method="post" action="../doctor/writeReply.do" onsubmit="return validateReplyForm(this);">
	<input type="hidden" id="reply_doc_ref" name="doc_ref" value="" />
	<input type="hidden" id="reply_review_idx" name="review_idx" value="" />
	<div class="modal" id="writeReplyModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">답변을 작성합니다</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
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

<!-- 답변 수정 모달창 -->
<form method="post" action="../doctor/editReply.do" onsubmit="return validateReplyForm(this);">
	<input type="hidden" id="reply_edit_doc_ref" name="doc_ref" value="" />
	<div class="modal" id="editReplyModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">의사 답변 수정</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<input type="hidden" id="reply_edit_review_idx" name="review_idx" value="">
					<textarea class="form-control" id="reply_edit_content" name="content" style="height: 100px;"></textarea>
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