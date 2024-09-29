package com.edu.springboot.hospital;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.edu.springboot.board.ParameterDTO;

@Mapper
public interface IHospitalService {
		
	// 병원 API 목록: 병원 API의 레코드 개수를 카운트
	public int countHospApi(ParameterDTO parameterDTO);
	// 병원 API 목록: 병원 API의 레코드에서 한 페이지에 출력할 레코드를 인출
	public ArrayList<HospitalDTO> listHospApi(ParameterDTO parameterDTO);
	// 병원 입점 여부 확인: 병원이름으로 입점 여부를 확인하여 아이디 추출
	public String selectHospId(String name);
	// 병원 조회
	public BasicDTO viewHosp(String id);
	
	// 해시태그 목록: 병원 해시태그 목록
	public ArrayList<HashtagDTO> listHashtag();
	
	// 병원 상세정보 조회
	public DetailDTO selectDetail(String id);
	
	
	
	
	
	
	
	// 리뷰 조회
	public ArrayList<HreviewDTO> listReview(HospitalDTO hospitalDTO);
	// 리뷰 작성
	public int writeReview(int score, String content, int cost, String treat, String purpose, String doctor, String userId, String hospId);
	// 리뷰 수정
	public int editReview(int review_idx, int cost, String treat, String purpose, String doctor);
	// 리뷰 삭제
	public int deleteReview(int review_idx);
	
	// 답변 작성
	public int writeReply(int review_idx, String content, String userId, String hospId);
	// 답변 수정
	public int editReply(int review_idx, String content);
	// 답변 삭제
	public int deleteReply(int review_idx);
	// 리뷰 삭제에 따른 답변 일괄 삭제
	public int deleteAllReply(int original_idx);
	
	
	
	
	
	
	
	
	
	
	
	
	// 병원 좋아요: 병원 좋아요 수 조회
	public int countHospLike(String recodenum);
	// 병원 좋아요: 병원 좋아요 레코드 존재 여부 확인
	public int checkHospLike(String userId, String hospId);
	// 병원 좋아요: 병원 좋아요 수 증가
	public int plusHospLike(String userId, String hospId);
	// 병원 좋아요: 병원 좋아요 수 감소
	public int minusHospLike(String userId, String hospId);
	
	// 리뷰 좋아요: 리뷰 좋아요 수 조회
	public int countReviewLike(String recodenum);
	// 리뷰 좋아요: 리뷰 좋아요 레코드 존재 여부 확인
	public int checkReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 좋아요 수 증가
	public int plusReviewLike(String id, String review_idx);
	// 리뷰 좋아요: 리뷰 좋아요 수 감소
	public int minusReviewLike(String id, String review_idx);
	
	// 리뷰 수 조회
	public int countReview(String id);
	// 별점 합계 조회
	public int sumScore(String id);
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
