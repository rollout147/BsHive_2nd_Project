package com.postGre.bsHive.JwService;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.postGre.bsHive.Adto.Onln_Lctr_List;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.Conts_Ch;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Onln_Lctr;
import com.postGre.bsHive.Amodel.Syllabus_Unit;
import com.postGre.bsHive.JwDao.JwDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JwServiceImpl implements JwService {
	private final JwDao jd;

// 1. 강의계획서
	
	// 강의번호 뒷자리 가장 큰 값 불러오기
	@Override
	public int getMaxLastTwoDigits() {
		System.out.println("JwServiceImpl getMaxLastTwoDigits Start...");
		
		int maxTwoDigits = 0;
		maxTwoDigits = jd.getMaxLastTwoDigitstmax();
		System.out.println("JwServiceImpl getMaxLastTwoDigits maxTwoDigits->"+maxTwoDigits);
		
		return maxTwoDigits;
	}

	
	// 교수정보 불러오기
	@Override
	public User_Table getUserTable(int unq_num) {
		System.out.println("JwServiceImpl getUserTable Start...");
		
		User_Table user_Table =  jd.getUserTable(unq_num);
		System.out.println("JwServiceImpl getUserTable user_Table->"+user_Table);
		
		return user_Table;
	}

	// Onln_Lctr TBL insert 
	@Override
	public int insertOnlnLctr(Onln_Lctr onln_lctr) {
		int OnlnLctrinsert = 0;
		System.out.println("JwServiceImpl insertOnlnLctr Start...");
		
		OnlnLctrinsert = jd.insertOnlnLctr(onln_lctr);
		System.out.println("JwServiceImpl insertOnlnLctr OnlnLctrinsert->"+OnlnLctrinsert);
		
		return OnlnLctrinsert;
	}
	
	// LCTR TBL insert
	@Override
	public int insertLctr(Lctr lctr) {
		int insertLctr = 0;
		System.out.println("JwServiceImpl insertOnlnLctr insertLctr->"+insertLctr);
		
		insertLctr = jd.insertLctr(lctr);
		System.out.println("JwServiceImpl insertOnlnLctr insertLctr->"+insertLctr);
		
		return insertLctr;
	}
	
	//로그인한 교수의 미완성 강의번호 List 가져오기
	@Override
	public List<Onln_Lctr_List>  getOnlnLctrNum(Integer unq_num) {
		List<Onln_Lctr_List> userOnlnLctrNum = null;
		System.out.println("JwServiceImpl getOnlnLctrNum Start...");
		
		userOnlnLctrNum = jd.getOnlnLctrNum(unq_num);
		System.out.println("JwServiceImpl getOnlnLctrNum userOnlnLctrNum->"+userOnlnLctrNum);
		
		return userOnlnLctrNum;
	}
	
	
	// 온라인강의차시 TBL insert 
	@Override
	public int insertOnlnCont(Syllabus_Unit syllabus_Unit, List<File> fileList) {
		int onlnContInsert = 0;
		System.out.println("JwServiceImpl insertOnlnCont Start...");
		
		onlnContInsert = jd.insertOnlnCont(syllabus_Unit, fileList);
		System.out.println("JwServiceImpl insertOnlnCont onlnContInsert->"+onlnContInsert);
		
		return onlnContInsert;
	}

	// 콘텐츠챕터 TBL insert
	@Override
	public int insertContsCh(Conts_Ch conts_ch) {
		int conthChInsert = 0;
		System.out.println("JwServiceImpl insertContsCh conthChInsert Start...");
		
		conthChInsert = jd.insertContsCh(conts_ch);
		System.out.println("JwServiceImpl insertContsCh conthChInsert->"+conthChInsert);
					
		return conthChInsert;
	}

	
	// 유저가 삽입한 목록을 조회
	@Override
	public List<Onln_Lctr> getOnlnLctrList(Integer unq_num) {
		List<Onln_Lctr> onlnLctrList = null;
		System.out.println("JwServiceImpl getOnlnLctrList conthChInsert Start...");
		
		onlnLctrList = jd.getOnlnLctrList(unq_num);
		System.out.println("JwServiceImpl getOnlnLctrList onlnLctrList->"+onlnLctrList);
		
		return onlnLctrList;
	}


	@Override
	public List<Syllabus_Unit> getSyllabusUnitList(Syllabus_Unit syllabus_Unit) {
		List<Syllabus_Unit> syllList = null;
		System.out.println("JwServiceImpl getSyllabusUnitList conthChInsert Start...");
		
		syllList = jd.getSyllabusUnitList(syllabus_Unit);
		System.out.println("JwServiceImpl getSyllabusUnitList syllList->"+syllList);
		
		return syllList;
	}


	@Override
	public List<Conts_Ch> getContsChList(Integer unq_num) {
		List<Conts_Ch> constChList = null;
		System.out.println("JwServiceImpl getContsChList conthChInsert Start...");
		
		constChList = jd.getContsChList(unq_num);
		System.out.println("JwServiceImpl getContsChList constChList->"+constChList);
		
		return constChList;
	}

	// 마이페이지 나의 강의실에서 강의번호 클릭하면 상세보기
	@Override
	public List<Onln_Lctr_List> detailOnlnLctr(Integer lctr_num) {
		List<Onln_Lctr_List> onln_list = null;
		System.out.println("JwServiceImpl detailOnlnLctr Start...");
		
		System.out.println("JwServiceImpl detailOnlnLctr lctr_num->"+lctr_num);
		onln_list = jd.detailOnlnLctr(lctr_num);
		System.out.println("JwServiceImpl detailOnlnLctr onln_list->"+onln_list);
		
		return onln_list;
	}

	// 수정완료후 이동
	@Override
	public int updateLctr(Lctr lctr) {
		System.out.println("JwServiceImpl updateLctr Start...");
		
		int lctrUpdate = 0;
		lctrUpdate = jd.updateLctr(lctr);		
		System.out.println("JwServiceImpl updateLctr lctrUpdate->"+lctrUpdate);
		
		return lctrUpdate;
	}


	@Override
	public int updateOnlnLctr(Onln_Lctr onln_lctr) {
		System.out.println("JwServiceImpl updateOnlnLctr Start...");
		
		int onlnLctrUpdate = 0;
		onlnLctrUpdate = jd.updateOnlnLctr(onln_lctr);
		System.out.println("JwServiceImpl updateOnlnLctr onlnLctrUpdate->"+onlnLctrUpdate);
		
		return onlnLctrUpdate;
	}


	@Override
	public int updateSyll(Syllabus_Unit syllabus_unit) {
		System.out.println("JwServiceImpl updateSyll Start...");
		
		int syllUpdate = 0;
		syllUpdate = jd.updateSyll(syllabus_unit);
		System.out.println("JwServiceImpl updateSyll syllUpdate->"+syllUpdate);
		return syllUpdate;
	}


	@Override
	public int updateContsCh(Conts_Ch conts_ch) {
		System.out.println("JwServiceImpl updateContsCh Start...");
		
		int contsChUpdate = 0;
		contsChUpdate = jd.updateContsCh(conts_ch);
		System.out.println("JwServiceImpl updateContsCh contsChUpdate->"+contsChUpdate);
		return contsChUpdate;
	}

}
