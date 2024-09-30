<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰 | 병원 찾기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%@include file="../common/head.jsp" %>
<link rel="stylesheet" href="/css/hosp-view.css" />
<script>
function deleteReview(api_ref, review_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteReviewForm;
		// hidden 필드에 값을 동적으로 설정
        form.api_ref.value = api_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/hospital/deleteReview.do";
		form.submit();
	}
}
function deleteReply(api_ref, review_idx) {
	if (confirm("답변을 삭제하시겠습니까?")) {
		var form = document.deleteReplyForm;
		// hidden 필드에 값을 동적으로 설정
        form.api_ref.value = api_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/hospital/deleteReply.do";
		form.submit();
	}
}

function openReviewWriteModal(api_idx) {
	document.getElementById("review_write_api_idx").value = api_idx;
}
function openReviewEditModal(api_ref, review_idx, score, content, cost, treat, doctor) {
	document.getElementById("review_edit_api_ref").value = api_ref;
    document.getElementById("review_edit_score").value = score;
    document.getElementById("review_edit_content").value = content;
    document.getElementById("review_edit_cost").value = cost;
    document.getElementById("review_edit_treat").value = treat;
    document.getElementById("review_edit_doctor").value = doctor;
    document.getElementById("review_edit_review_idx").value = review_idx;
}
function openReplyWriteModal(api_ref, review_idx) {
	document.getElementById("reply_write_api_ref").value = api_ref;
    document.getElementById("reply_write_review_idx").value = review_idx;
}
function openReplyEditModal(api_ref, review_idx, content) {
	document.getElementById("reply_edit_api_ref").value = api_ref
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
// 채팅
function chat(userId, hospId) {
	window.open('/chat/index.html#/chat/talk?room=' + hospId + ' - ' + userId + '&user=' + userId,
			hospId + '-' + userId, 'width=500, height=650')
}
</script>
</head>
<body>
<%@include file="../common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">

			<div class="hosp_info">
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
							<p class="blue">주소</p>
							<p>${ hospitalDTO.address }</p>
						</div>
						<div class="details">
							<div class="detail_flex">
								<p class="blue">교통편</p>
								<p>${ doctorDTO.parking }</p>
							</div>
							<div class="detail_flex">
								<p class="blue">주차</p>
								<p>${ doctorDTO.parking }</p>
							</div>
							<div class="detail_flex">
								<p class="blue">예약제</p>
								<p>${ doctorDTO.system }</p>
							</div>
							<div class="detail_flex">
								<p class="blue">입원</p>
								<p>${ doctorDTO.hospitalize }</p>
							</div>
							<div class="detail_flex">
								<p class="blue">PCR 검사</p>
								<p>${ doctorDTO.pcr }</p>
							</div>
						</div>
					</div>
					<!-- 해시태그 -->
					<%-- <c:if test="${ not empty hashtagList }">
						<div class="hashtag">
							<ul>
								<c:forEach items="${ hashtagList }" var="hashrow" varStatus="loop">
									<c:if test="${ hashrow.hosp_ref == row.id }">
										<li class="hash">
											<p>${ hashrow.tag }</p>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</c:if> --%>
					
					<div class="btn_wrap">
						<!-- 사용자가 로그인 했고 임점한 병원인 경우에만 채팅 가능 -->
						<!-- ****************** 수정 필요 ****************** -->
						<c:if test="${ hospitalDTO.enter == 'T' && sessionScope.userName != null }">
							<button>예약하기</button>
						</c:if>
						
						<!-- 사용자가 로그인 했고 입점한 병원인 경우에만 채팅 가능 -->
						<c:if test="${ hospitalDTO.enter == 'T' && sessionScope.userName != null }">
						    <button onclick="chat('${ sessionScope.userName }', '${ hospitalDTO.name }');">채팅하기</button>
						</c:if>
					</div>
					
					<div class="like_wrap">
						<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
						<c:if test="${ hosplikecheck == 0 }">
							<button type="button" onclick="location.href='../hospital/clickHospLike.do?api_idx=${ param.api_idx }';">
								<img src="/images/mark.svg" alt="" style="width: 30px; height: 30px;" />
								${ hospitalDTO.likecount }
							</button>
						</c:if>
						<!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
						<c:if test="${ hosplikecheck == 1 }">
							<button type="button" onclick="location.href='../hospital/clickHospLike.do?api_idx=${ param.api_idx }';">
								<img src="/images/mark_full.svg" alt="" style="width: 30px; height: 30px;" />
								${ hospitalDTO.likecount }
							</button>
						</c:if>
					</div>
				</div>
			</div>
			
			<!-- 의사 정보 -->
			<div class="list">
				<c:choose>
					<c:when test="${ empty doctorList }">
						<tr>
							<p>등록된 의사가 없습니다.</p>
						</tr>
					</c:when>
					<c:otherwise>
						<ul class="doctor">
							<c:forEach items="${ doctorList }" var="row" varStatus="loop">
								<li>
									<div class="doc_wrap">
										<span class="doc_img">
											<c:if test="${ row.photo == 'NULL' }">
												<img src="/images/doctor.png" alt="" />
											</c:if>
											<c:if test="${ row.photo != 'NULL' }">
												<img src="/uploads/${ row.photo }" />
											</c:if>
										</span>
										<div class="doc_title">
											<h3>${ row.name }</h3>
											<p>${ row.major }</p>
										</div>
									</div>
									<div class="doc_content">
										<div class="doc_detail">
											<p class="blue">경력</p>
											<p>${ row.career }</p>
										</div>
										<div class="doc_detail">
											<p class="blue">진료 요일</p>
											<p>${ row.hours }</p>
										</div>
									</div>
									<a href="../doctor/viewDoctor.do?doc_idx=${ row.doc_idx }"><span class="blind">의사 바로가기</span></a>
								</li>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
				
				<!-- 페이지네이션 -->
				<div class="pagination">
					<div class="pagination_inner">
						${ pagingImg }
					</div>
				</div>
			</div>
		</div>
		
		<div class="comment_inner">
			<!-- 댓글 -->
			<form name="deleteReviewForm" method="post">
			    <input type="hidden" name="api_ref" value="" />
			    <input type="hidden" name="review_idx" value="" />
			</form>
			<form name="deleteReplyForm" method="post">
			    <input type="hidden" name="api_ref" value="" />
			    <input type="hidden" name="review_idx" value="" />
			</form>
			<!-- 로그인 한 경우 리뷰 작성 버튼 -->
	  		<c:if test="${ not empty sessionScope.userId }">
		  		<div class="comment_btn">
			  		<button type="button" data-bs-toggle="modal" data-bs-target="#writeReviewModal"
			  			onclick="openReviewWriteModal(${ param.api_idx })">
		                리뷰 작성하기
		            </button>
	  			</div>
	  		</c:if>
	  		
	  		<c:choose>
				<c:when test="${ empty reviewsList }">
					<p>리뷰를 남겨보세요.</p>
				</c:when>
				<c:otherwise>
					<c:forEach items="${ reviewsList }" var="row" varStatus="loop">
						<c:if test="${ row.original_idx == row.review_idx }">
							<div class="review_wrapper">
								<div class="review_wrap">
									<img src="/images/hospital.png" alt="" />		
									<div class="review">
										<div class="review_score">
											<div class="star">
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
												<img src="/images/star.svg" alt="" />
											</div>
											<p>${ row.score }</p>
										</div>
										<div class="review_title">
											<p>${ row.nickname }</p>
											<p>•</p>
											<p>${ row.postdate }</p>
											<p class="edit">(${ row.rewrite })</p>
										</div>
										<div class="review_hash">
											<p>해시태그</p>
											<p>해시태그</p>
											<p>해시태그</p>
											<p>해시태그</p>
										</div>
										<div class="review_content">
											<p>${ row.content }</p>					
										</div>
										<div class="review_other">
											<!-- 로그인 한 사용자가 좋아요를 누르지 않은 경우 -->
							                <c:if test="${ reviewlikecheck == 0 }">
							                    <button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
							                    	<img src="/images/heart.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
							                	</button>
							                </c:if>
							                <!-- 로그인 한 사용자가 좋아요를 누른 경우 -->
							                <c:if test="${ reviewlikecheck == 1 }">
							                    <button class="comm_like_btn" type="button" onclick="location.href='../doctor/clickReviewLike.do?doc_ref=${ param.doc_idx }&review_idx=${ row.review_idx }';">
							                    	<img src="/images/heart_full.svg" style="width: 24px; height: 24px;" /> ${ row.likecount }
						                        </button>
							                </c:if>
											<button class="re_btn" type="button" data-bs-toggle="modal" data-bs-target="#writeReplyModal"
						                        	onclick="openReplyWriteModal(${ row.doc_ref }, ${ row.review_idx })">
						                        댓글 달기
					                        </button>
										</div>
									</div>
									<!-- 로그인 사용자와 댓글 작성자가 일치하는 경우 수정 삭제 버튼 -->
						            <c:if test="${ row.writer_ref.equals(sessionScope.userId) }">
										<div class="manage">
											<button type="button" data-bs-toggle="modal" data-bs-target="#editReviewModal"
						                        	onclick="openReviewEditModal(${ row.doc_ref }, ${ row.review_idx }, ${ row.score }, '${ row.content }')">
						                        수정하기
					                        </button>
											<button type="button" onclick="deleteReview(${ row.doc_ref }, ${ row.review_idx });">
												삭제하기
											</button>
										</div>
									</c:if>
								</div>
								
								<!-- 리뷰에 대한 답변 출력 -->
							    <c:forEach items="${ reviewsList }" var="replyRow">
							    	<c:if test="${ replyRow.original_idx == row.review_idx and replyRow.review_idx != replyRow.original_idx }">
										<div class="recomm">
											<div class="recomm_wrap">
												<div class="recomm_title_wrap">
													<div class="recomm_title">
														<p>${ replyRow.nickname }</p>
														<p>•</p>
														<p>${ replyRow.postdate }</p>
														<p class="edit">(${ replyRow.rewrite })</p>
													</div>
													
													<!-- 로그인 사용자와 답변 작성자가 일치하는 경우 수정 삭제 버튼 -->
								                    <c:if test="${ replyRow.writer_ref.equals(sessionScope.userId) }">
														<div class="recomm_btn">
															<button type="button" data-bs-toggle="modal" data-bs-target="#editReplyModal"
								                                	onclick="openReplyEditModal(${ replyRow.doc_ref }, ${ replyRow.review_idx }, '${ replyRow.content }')">
							                                	수정
						                                	</button>
															<button type="button"  onclick="deleteReply(${ replyRow.doc_ref }, ${ replyRow.review_idx });">
																삭제
															</button>
														</div>
													</c:if>
												</div>
												<div class="recomm_content">
													<p>${ replyRow.content }</p>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>	
</main>
<%@include file="../common/main_footer.jsp" %>
   
<!-- 리뷰 작성 모달창 -->
<form method="post" action="../hospital/writeReview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="review_write_api_idx" name="api_idx" value="" />
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
					<textarea class="form-control mb-3" name="score" style="height: 20px;" placeholder="점수(1-5) *"></textarea>
					<textarea class="form-control mb-3" name="content" style="height: 100px;" placeholder="내용 *"></textarea>
					<textarea class="form-control mb-3" name="cost" style="height: 20px;" placeholder="비용"></textarea>
					<textarea class="form-control mb-3" name="treat" style="height: 20px;" placeholder="치료 내용"></textarea>
					<textarea class="form-control mb-3" name="doctor" style="height: 20px;" placeholder="의사"></textarea>
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
<form method="post" action="../hospital/editReview.do" onsubmit="return validateReviewForm(this);">
	<input type="hidden" id="review_edit_api_ref" name="api_ref" value="" />
	<div class="modal" id="editReviewModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">병원 리뷰 수정</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal Body -->
				<div class="modal-body">
					<input type="hidden" id="review_edit_review_idx" name="review_idx" value="">
					<textarea class="form-control mb-3" id="review_edit_score" name="score" style="height: 20px;"></textarea>
					<textarea class="form-control mb-3" id="review_edit_content" name="content" style="height: 100px;"></textarea>
					<textarea class="form-control mb-3" id="review_edit_cost" name="cost" style="height: 20px;"></textarea>
					<textarea class="form-control mb-3" id="review_edit_treat" name="treat" style="height: 20px;"></textarea>
					<textarea class="form-control mb-3" id="review_edit_doctor" name="doctor" style="height: 20px;"></textarea>
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
<form method="post" action="../hospital/writeReply.do" onsubmit="return validateReplyForm(this);">
	<input type="hidden" id="reply_write_api_ref" name="api_ref" value="" />
	<input type="hidden" id="reply_write_review_idx" name="review_idx" value="" />
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
<form method="post" action="../hospital/editReply.do" onsubmit="return validateReplyForm(this);">
	<input type="hidden" id="reply_edit_api_ref" name="api_ref" value="" />
	<div class="modal" id="editReplyModal" >
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">병원 답변 수정</h4>
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