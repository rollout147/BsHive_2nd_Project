package com.postGre.bsHive.SeService;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.postGre.bsHive.Adto.Onln_Lctr_List;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Lctr_Aply;
import com.postGre.bsHive.Amodel.Lctr_View;
import com.postGre.bsHive.Amodel.Stdnt;
import com.postGre.bsHive.SeDao.SeDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SeServiceImpl implements SeService {
	
	private final SeDao sd;

	@Override
	public int onlnTotal() {
		System.out.println("SeService onlnTotal start");
		int onlnTotal = sd.onlnTotal();
		System.out.println("SeService onlnTotal "+onlnTotal);
		return onlnTotal;
	}

	@Override
	public List<Onln_Lctr_List> onlnList(Onln_Lctr_List onln_Lctr_List) {
		List<Onln_Lctr_List> onlnList = null;
		System.out.println("SeService onlnList start");
		onlnList = sd.onlnList(onln_Lctr_List);
		System.out.println("SeService onlnList"+onlnList);
		return onlnList;
	}

	@Override
	public Onln_Lctr_List onlnDtl(Integer lctr_Num) {
		System.out.println("SeService onlnDtl start");
		Onln_Lctr_List onlnDtl = null;
		onlnDtl =sd.onlnDtl(lctr_Num);
		System.out.println("SeService onlnDtl "+onlnDtl);
		return onlnDtl;
	}

	@Override
	public List<Onln_Lctr_List> lctrViewList(Integer unq_Num, Integer lctr_num) {
		System.out.println("SeService lctrViewList start");
		
		List<Onln_Lctr_List> onln_Lctr_List = null;
		onln_Lctr_List = sd.lctrviewList(unq_Num, lctr_num);
		
		return onln_Lctr_List;
	}

	@Override
	public void updateView(int maxDtl, int lastDtl, int unqNum, int unitNum, int lctrNum, int lctrPace) {
	    System.out.println("진행률 " + lctrPace);
	    System.out.println("맥스값 " + maxDtl);
		sd.updateLastDtl(maxDtl, lastDtl, unqNum, unitNum, lctrNum, lctrPace);
	    return;
	}


	@Override
	public void updateMaxDtl(int lastDtl, int unqNum, int unitNum, int lctrNum) {
		sd.updateMaxDtl(lastDtl, unqNum, unitNum, lctrNum); // 수정된 메소드 호출
	    return;
	}

	@Override
	public List<Onln_Lctr_List> getChaptersForVideo(String vdoId) {
		List<Onln_Lctr_List> chapterList = null;
		chapterList = sd.chapterList(vdoId);
		return chapterList;
	}

	@Override
	public int getMaxDtl(Lctr_View lctr_View) {
		int getMaxDtl = sd.getMaxDtl(lctr_View);
		return getMaxDtl;
	}

	@Override
	public List<File> filePath(int file_group) {
		List<File> filePath = null;
		filePath = sd.filePath(file_group);
		return filePath;
	}

	@Override
	public List<Map<String, Object>> myLctrList(int unq_num) {
		List<Map<String, Object>> myLctrList = null;
		myLctrList = sd.myLctrList(unq_num);
		return myLctrList;
	}

	@Override
	public Onln_Lctr_List onlnAply(Integer lctr_num) {
		Onln_Lctr_List onlnAply = null;
		onlnAply = sd.onlnAply(lctr_num);
		System.out.println("SeService onlnAply "+onlnAply);
		return onlnAply;
	}

	@Override
	public void lctrOnlnInsert(Onln_Lctr_List onln_Lctr_List) {
		System.out.println("SeService lctrOnlnInsert Start");
		sd.lctrOnlnInsert(onln_Lctr_List);	
		return; 
	}

	@Override
	public User_Table stdntDtl(Integer unq_num) {
		User_Table stdntDtl = null;
		stdntDtl = sd.stdntDtl(unq_num);
		return stdntDtl;
	}

	@Override
	public void insertLctrView(int lctrNum, int userUnqNum) {
		sd.insertLctrView(lctrNum,userUnqNum);
		return;
	}

	public boolean checkLctrView(int lctrNum, int userUnqNum) {
        // DAO에서 데이터를 조회하여 존재 여부를 판단
        Lctr_View lctrView = sd.checkLctrView(lctrNum, userUnqNum);
        return lctrView != null;
    }

	
}
