package com.postGre.bsHive.MnService;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.postGre.bsHive.Adto.Mn_LctrAplyOflWeek;
import com.postGre.bsHive.Adto.Mn_LctrInfoPage;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.Crans_Qitem;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Lctr_Aply;
import com.postGre.bsHive.Amodel.Lctr_Week;
import com.postGre.bsHive.Amodel.Lctrm;
import com.postGre.bsHive.Amodel.Pst;
import com.postGre.bsHive.Amodel.Sort_Code;
import com.postGre.bsHive.Amodel.Stdnt;
import com.postGre.bsHive.MnDao.MnDao;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MnServiceImpl implements MnService {
	
	private final MnDao md;
	
	@Override
	public List<Crans_Qitem> selAll() {
		System.out.println("selAll start...");
		return md.selAll();
	}

	@Override
	public List<Pst> pstList() {
		System.out.println("MnServiceImpl pstList start...");
		return md.pstAllList();
	}

	@Override
	public List<Mn_LctrAplyOflWeek> joinLctrAplyAllList(int startIndex, int endIndex) {
		System.out.println("MnServiceImpl joinLctrAplyAllList start...");
		return md.lctrAplyJoinAllList(startIndex, endIndex);
	}

	@Override
	public List<Mn_LctrAplyOflWeek> searchLctrAplyList() {
		System.out.println("MnServiceImpl searchLctrAplyList start...");
		return md.lctrSearchList();
	}

	@Override
	public List<Lctrm> lctrmListAll() {
		System.out.println("MnServiceImpl lctrmListAll start...");
		return md.lctrmListAll();
	}

	@Override
	public List<Sort_Code> selectLctrm() {
		System.out.println("MnServiceImpl selectLctrm start...");
		return md.selectLctrm();
	}

	@Override
	public List<Lctrm> getLcrtmRoomNumber(String roomNumber) {
		System.out.println("MnServiceImpl getLcrtmRoomNumber start...");
		return md.getLctrmRomNum(roomNumber);
	}

	@Override
	public int subminPageLctr(Mn_LctrAplyOflWeek lctrAplyOflWeek, List<Lctr_Week> lctrWeeks) {
		System.out.println("MnServiceImpl subminPageLctr start...");
		return md.subminInsertLctrList(lctrAplyOflWeek, lctrWeeks);
	}

	@Override
	public Stdnt getUserTable(int userSess) {
		System.out.println("MnServiceImpl getUserTable start...");
		return md.getUserStdnt(userSess);
	}

	@Override
	public int lctrListCount() {
		System.out.println("MnServiceImpl lctrListCount start...");
		return md.countLctrList();
	}

	@Override
	public List<Mn_LctrInfoPage> selGetLctrList(String lctr_num) {
		System.out.println("MnServiceImpl selGetLctrList start...");
		return md.selGetLctrList(lctr_num);
	}

	@Override
	public List<Lctr_Week> selWeekList(String lctr_num) {
		System.out.println("MnServiceImpl selWeekList start...");
		return md.selWeeksList(lctr_num);
	}

	@Override
	public List<File> imgInsertList(List<File> fileList) {
		System.out.println("MnServiceImpl imgInsertList start...");
		return md.imgInsertList(fileList);
	}

	@Override
	public Mn_LctrAplyOflWeek selAllListCurPage(Integer lctr_num) {
		System.out.println("MnServiceImpl selAllListCurPage start...");
		return md.selListAllCurPage(lctr_num);
	}

	@Override
	public User_Table selUserInfo(String unq_num) {
		System.out.println("MnServiceImpl selUserInfo start...");
		return md.selUserInfo(unq_num);
	}

	@Override
	public List<Sort_Code> selSortCode(int sortco) {
		System.out.println("MnServiceImpl selSortCode start...");
		return md.selSortCodeList(sortco);
	}

	@Override
	public int insertConPage(Lctr_Aply lctr_Aply) {
		System.out.println("MnServiceImpl insertConPage staet...");
		return md.insertConPage(lctr_Aply);
	}

	@Override
	public int updCount(Lctr_Aply lctr_Aply) {
		System.out.println("MnServiceImpl updCount start...");
		return md.updCount(lctr_Aply);
	}

	@Override
	public int lctrkeywordListCount(String keyword) {
		System.out.println("MnServiceImpl lctrkeywordListCount start...");
		return md.lctrkeywordListCount(keyword);
	}

	@Override
	public List<Mn_LctrAplyOflWeek> joinLctrAplyKeywordList(String keyword, int startIndex, int endIndex) {
		System.out.println("MnServiceImpl joinLctrAplyKeywordList start...");
		return md.joinLctrAplyKeywordList(keyword, startIndex, endIndex);
	}
	
}
