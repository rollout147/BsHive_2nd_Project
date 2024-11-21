package com.postGre.bsHive.JwDao;

import java.util.List;
import java.util.Map;

import com.postGre.bsHive.Adto.Onln_Lctr_List;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.Conts_Ch;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Onln_Lctr;
import com.postGre.bsHive.Amodel.Syllabus_Unit;

public interface JwDao {
	
	// 강의번호 뒷자리 가장 큰 값 불러오기
	int getMaxLastTwoDigitstmax();
	
	// 교수정보 불러오기
	User_Table              getUserTable(int unq_num);
	
	// LCTR, Onln_Lctr TBL insert 
	int 					insertOnlnLctr(Onln_Lctr onln_lctr);
	int 					insertLctr(Lctr lctr);

	
	// 온라인강의 승인전 리스트 불러오기
	List<Onln_Lctr> 		beforeOnlnList();
	
	// DB에 입력된 강의번호 가져오기 
	List<Onln_Lctr_List> 		getOnlnLctrNum(Integer unq_num);

	
	//로그인한 유저의 List<Onln_Lctr>  가져오기.
	//Onln_Lctr 				detailOnlnLctr(int lctr_num);
	// List<Onln_Lctr> 		getLctrNum(Integer unq_num);
	
	// 강의 누르면 상세정보 입력창 불러오기
	//int onln_lctr(Integer lctr_num);
	
	// 온라인강의차시 TBL insert 
	int 					insertOnlnCont(Syllabus_Unit syllabus_Unit, List<File> fileList);
	
	// 콘텐츠챕터 TBL insert 
	int insertContsCh(Conts_Ch conts_ch);
	
	// 유저가 삽입한 목록을 조회
	List<Onln_Lctr> 		getOnlnLctrList(Integer unq_num);

	List<Syllabus_Unit> 	getSyllabusUnitList(Syllabus_Unit syllabus_Unit);

	List<Conts_Ch> 			getContsChList(Integer unq_num);
	
	// 마이페이지 나의 강의실에서 강의번호 클릭하면 상세보기
	List<Onln_Lctr_List>	detailOnlnLctr(Integer lctr_num);

}
