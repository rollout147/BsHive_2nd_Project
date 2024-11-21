package com.postGre.bsHive.Adto;


import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=true)
public class Onln_Lctr_List extends User_Table {
	
	// ============= 강의정보 목록을 위해 만듬 ==============
	
	// 수강과목 LCTR TBL
	private int lctr_num;		// 강의번호   PK  (온라인강의, 온라인강의차시 TBL과 조인)
	private String aply_type;	// 강의상태 
	private String aply_ydm;	// 개설일
	private int pscp_nope;		// 정원인원수
	private String sbjct_nm;	// 과목명
	private String lctr_name;	// 강의명
	private int unq_num2;		// 강사고유번호
	private String end_date;	// 마감일
	
	private String aply_stts;	// 신청상태
	private String aply_ymd;	// 신청일
	private int atndc_scr;		// 출석점수
	private int asmt_scr;		// 과제점수
	private String fnsh_yn;		// 수료여부
	private int pace;			// 강의진도율
	
	// 온라인강의 Onln_Lctr TBL
	private String 	lctr_expln;			// 강의설명
	private String 	bgng_ymd;			// 시작일
	private String 	end_ymd;			// 종료일
	private int 	rcrt_nope;			// 모집인원수
	private String 	fnsh_crtr;			// 수료기준
	private int 	file_group;
	private int evl_total; 		// 총점
	private int priority_type;
	private int ptcp_type;
	// 교원정보 EMP TBL
	private int unq_num;		// 교직원 고유번호 (수강과목 TBL과 조인)
	private String emp_nm;		// 교직원 이름
	
	
	// ========== 차시정보 목록을 위해 만듬 ===============

	// 콘텐츠챕터 CONTS_CH TBL
	private int    ch_num;		// 챕터 ID(PK)
	private String ch_nm;		// 챕터이름	
	
	// =========== 승은씨의 강의시청 ================
	
	// 강의시청 LCTR_VIEW TBL
	private int unit_num;	// 차시번호
	private int max_dtl;		// 최대시간
	private int last_dtl;	// 최종시간			
	private int lctr_pace;		// 차시진도율
	private String conts_type;	// 컨텐츠구분
	private int play_hr;
	private String conts_nm;
	private String vdo_id;
	// Page 정보
	private int		start;
	private int		end;
	private String	currentPage;
		
	private String play_start; //시작시간
	
}
