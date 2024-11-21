package com.postGre.bsHive.Amodel;

import lombok.Data;

//출석기준 TBL

@Data
public class Atndc_Type {
	private int crtr_cnt;	//결석횟수
	private int	atndc_sct;	//점수
}
