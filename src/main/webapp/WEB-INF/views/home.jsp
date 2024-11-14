<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닥터뷰</title>
<%@include file="common/head.jsp" %>
<link rel="stylesheet" href="/css/main.css" />
<script src="/js/freeboard.js"></script>
</head>
<body>

<!-- 회원탈퇴 알림 -->
<c:if test="${ not empty withdraw }">
	<script>
		alert("${withdraw}");
	</script>
</c:if>

<%@include file="common/main_header.jsp" %>

<main id="container">
	<div class="content">
		<div class="content_inner">
		
			<!-- 병원/의사 찾기 섹션 -->
			<section class="search">
				<div class="search_wrap">
					<img src="/images/main_search.png" alt="캐릭터" style="width: 160px; height: 160px;"/>
					
					<div class="searchForm_wrap">
						<div class="title">
							<p class="tip">병원, 의사를 검색해보세요.</p>
							<p>검색 결과는 좋아요 순으로 출력됩니다.</p>
						</div>
						<form class="searchForm" name="searchForm" onSubmit="return searchHosp();">
							<select name="searchField" class="searchField">
								<option value="hospital" selected>병원</option>
								<option value="doctor">의사</option>
							</select>
							<input class="searchWord" type="text" name="searchWord" placeholder="검색어를 입력헤주세요." />
							<input class="search_btn" type="submit" value="" />
						</form>
					</div>
				</div>
			</section>
			
			
			<!-- 해시태그 섹션 -->
			<section class="tag">
			
			
			</section>
		
		
			<!-- 바로가기 섹션 -->
			<section class="link">
				<h2>바로가기</h2>
				<ul>
					<li>
						<p>얘기 나눠요</p>
						<a href="/freeboard.do"><span class="blind">바로가기</span></a>
						<p class="go">자유게시판</p>
					</li>
					<li>
						<p>의료 지식에 필요해요</p>
						<a href="/qnaboard.do"><span class="blind">바로가기</span></a>
						<p class="go">상담게시판</p>
					</li>
					<li>
						<p>꾸며보아요</p>
						<a href="/store.do"></a>
						<p class="go">이모지 상점</p>
					</li>
				</ul>
			</section>
			
			
			<section class="notify">
				<div class="notice">
					<p class="title">2024년 5월 20일부터 병원 접수, 진료 시 신분증 지참 필수입니다!</p>
					<br />
					<strong>[의료기관 본인확인 의무화]</strong>
					<p>국민건강보호법 개정(제12조4항 신설)에 따라 2024년 5월 20일부터 본인확인 의무화 제도 시행</p>
					<br />
					<strong>[본인 확인 방법]</strong>
					<p>신분증 / 모바일 신분증 / 운전면허증 / 건강보험증 / 모바일건강보험증앱 / 여권 등
					<br />
					※ 증명서 또는 서류에 유효기간이 적혀있는 경우에는 유효기간이 지나지 않아야 하며 실물 신분증만 가능 <span>(사본, 사진으로 찍은 신분증 불가)</span>
					<br />
					※ 19세미만, 응급환자 등은 주민등록번호로 본인확인 가능
					<br />
					※ 신분증 미지참시 전액본인부담으로 진료받은 후 14일이내 신분증과 진료비영수증
					<br />
					지참하여 건강보험 적용된 금액으로 정산</p>
				</div>
			</section>

		</div>
	</div>
</main>
<%@include file="common/main_footer.jsp" %>
</body>
</html>