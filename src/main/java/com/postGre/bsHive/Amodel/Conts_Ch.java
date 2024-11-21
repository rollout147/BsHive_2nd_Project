package com.postGre.bsHive.Amodel;

import lombok.Data;

//콘텐츠챕터
@Data
public class Conts_Ch {
	private int		lctr_num;	// 강의번호
	private int		unit_num;	// 차시번호
	private int 	ch_num; 	//챕터번호
	private String	play_start; //시작시간
	private String 	ch_nm; 		//챕터이름
}
