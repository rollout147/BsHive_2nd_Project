package com.postGre.bsHive.Adto;

import lombok.Data;

@Data
public class Hb_Test {
	
	// join 컬럼
	private int cycl; 	//차수
	private int lctr_num;	//강의번호
	private int qitem_no;	//문항번호
	
	//강의명 
	private String aply_type;	//강의상태
	private String sbjct_nm;	//과목명
	private String lctr_name;	//강의명
	
	// 시험 테이블 Test
	private String prblm; 	//시험명
	private String atch; 	//마감일시
	
	//시험 문항 테이블 Test_Qitem
	private String qitem_nm;	//문항명
	private int qitem_type;	//문항종류
	private int qitem_scr;		//점수

	// 시험 제출 테이블 Test_Submit
	private int crans_cd; 		//보기 코드
	private String qitem_expln; //객관식 보기
	private int crans_yn; 		//객관식정답
	private int crans_sbj;	 	//주관식 정답
	
	private int page; // 페이징 작업용 dto
	
	
}
