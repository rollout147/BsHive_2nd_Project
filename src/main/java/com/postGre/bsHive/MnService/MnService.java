package com.postGre.bsHive.MnService;

import java.util.List;

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


public interface MnService {

	List<Crans_Qitem> selAll();

	List<Pst> pstList();

	List<Mn_LctrAplyOflWeek> joinLctrAplyAllList(int startIndex, int endIndex);

	List<Mn_LctrAplyOflWeek> searchLctrAplyList();

	List<Lctrm> lctrmListAll();

	List<Sort_Code> selectLctrm();

	List<Lctrm> getLcrtmRoomNumber(String roomNumber);

	int subminPageLctr(Mn_LctrAplyOflWeek lctrAplyOflWeek, List<Lctr_Week> lctrWeeks);

	Stdnt getUserTable(int userSess);

	int lctrListCount();

	List<Mn_LctrInfoPage> selGetLctrList(String lctr_num);

	List<Lctr_Week> selWeekList(String lctr_num);

	List<File> imgInsertList(List<File> fileList);

	Mn_LctrAplyOflWeek selAllListCurPage(Integer lctr_num);

	User_Table selUserInfo(String unq_num);

	List<Sort_Code> selSortCode(int sortco);

	int insertConPage(Lctr_Aply lctr_Aply);

	int updCount(Lctr_Aply lctr_Aply);

	int lctrkeywordListCount(String keyword);

	List<Mn_LctrAplyOflWeek> joinLctrAplyKeywordList(String keyword, int startIndex, int endIndex);

}