package com.postGre.bsHive.Amodel;

import lombok.Data;

@Data
	// 수강신청
public class Lctr_Aply {
	private int lctr_num;		// 강의번호
	private int unq_num;		// 고유(학생)번호
	private String aply_stts;	// 신청상태
	private String aply_ymd;	// 신청일
	private int atndc_scr;		// 출석점수
	private int asmt_scr;		// 과제점수
	private String fnsh_yn;		// 수료여부
	private int pace;			// 강의진도율
	private int evl_total; 		// 총점
	private int priority_type;
	private int ptcp_type;
	
}
