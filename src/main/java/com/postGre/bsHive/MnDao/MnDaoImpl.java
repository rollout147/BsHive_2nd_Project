package com.postGre.bsHive.MnDao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
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

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MnDaoImpl implements MnDao {
	private final SqlSession session;
	
	@Override
	public List<Crans_Qitem> selAll() {
		List<Crans_Qitem> critem = null;
		System.out.println("selAll start//////////////");
		try {
			critem = session.selectList("com.postGre.bsHive.Mapper.mnMapper.selAll");
			System.out.println("daoCrit >>>>>>>>>>" + critem);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return critem;
	}

	@Override
	public List<Pst> pstAllList() {
		List<Pst> listPst = null;
		System.out.println("MnDaoImpl pstAllList start...");
		
		try {
			listPst = session.selectList("com.postGre.bsHive.Mapper.mnMapper.selPstAllList");
		} catch (Exception e) {
			System.out.println("MnDaoImpl pstAllList e.getMessage() >> " + e.getMessage());
		}
		
		return listPst;
	}

	@Override
	public List<Mn_LctrAplyOflWeek> lctrAplyJoinAllList(int startIndex, int endIndex) {
		List<Mn_LctrAplyOflWeek> mnList = null;
		System.out.println("MnDaoImpl lctrAplyJoinAllList start...");
		Map<String, Object> parm = new HashMap<>();
		parm.put("startIndex", startIndex);
		parm.put("endIndex", endIndex);
		
		try {
			mnList = session.selectList("com.postGre.bsHive.Mapper.mnMapper.joinAplyLctrAllList", parm);
		} catch (Exception e) {
			System.out.println("MnDaoImpl lctrAplyJoinAllList e.getMessage() >>>" + e.getMessage());
		}
		
		return mnList;
	}

	@Override
	public List<Mn_LctrAplyOflWeek> lctrSearchList() {
		List<Mn_LctrAplyOflWeek> searchList = null;
		System.out.println("MnDaoImpl lctrAplyJoinAllList start...");
		
		try {
			searchList = session.selectList("com.postGre.bsHive.Mapper.mnMapper.lctrSearchListMap");
		} catch (Exception e) {
			System.out.println("MnDaoImpl lctrSearchList e.getMessage() >>>" + e.getMessage());
		}
		
		return searchList;
	}

	@Override
	public List<Lctrm> lctrmListAll() {
		System.out.println("MnDaoImpl lctrmListAll start...");
		List<Lctrm> listLctrm = null;
		
		try {
			listLctrm = session.selectList("com.postGre.bsHive.Mapper.mnMapper.listLctrmAllList");
		} catch (Exception e) {
			System.out.println("MnDaoImpl lctrmListAll e.getMessage() >>>" + e.getMessage());
		}
		
		return listLctrm;
	}

	@Override
	public List<Sort_Code> selectLctrm() {
		System.out.println("MnDaoImpl selectLctrm start...");
		List<Sort_Code> sortList = null;
		
		try {
			sortList = session.selectList("com.postGre.bsHive.Mapper.mnMapper.selLctrmList");
		} catch (Exception e) {
			System.out.println("MnDaoImpl selectLctrm e.getMessage() >>>" + e.getMessage());
		}
		return sortList;
	}

	@Override
	public List<Lctrm> getLctrmRomNum(String roomNumber) {
		System.out.println("MnDaoImpl getLctrmRomNum start...");
		List<Lctrm> lctrList = null;
		System.out.println(roomNumber);
		
		try {
			lctrList = session.selectList("com.postGre.bsHive.Mapper.mnMapper.getSelLctrRomNum", roomNumber);
			System.out.println("MnDaoImpl getLctrmRomNum lctrList>>>>>" + lctrList);
		} catch (Exception e) {
			System.out.println("MnDaoImpl getLctrmRomNum e.getMessage() >>>" + e.getMessage());
		}
		
		return lctrList;
	}

	@Transactional
	@Override
	public int subminInsertLctrList(Mn_LctrAplyOflWeek lctrAplyOflWeek, List<Lctr_Week> lctrWeeks) {
	    System.out.println("MnDaoImpl subminInsertLctrList start...");
	    int rowsInserted = 0;

	    try {
	        rowsInserted += session.insert("com.postGre.bsHive.Mapper.mnMapper.insertLctrRomNum", lctrAplyOflWeek);
	        
	        for (Lctr_Week lctrWeek : lctrWeeks) {
	            rowsInserted += session.insert("com.postGre.bsHive.Mapper.mnMapper.insertLctrWeek", lctrWeek);
	        }
	    } catch (Exception e) {
	    	System.out.println("MnDaoImpl subminInsertLctrList e.getMessage() >>>" + e.getMessage());
	    }

	    return rowsInserted; // 삽입된 총 행 수 반환
	}

	@Override
	public Stdnt getUserStdnt(int userSess) {
		System.out.println("MnDaoImpl getUserStdnt start...");
		Stdnt stdntList = null;
		
		try {
			stdntList = (Stdnt) session.selectOne("com.postGre.bsHive.Mapper.mnMapper.getSelStdnt", userSess);
		} catch (Exception e) {
			System.out.println("MnDaoImpl getUserStdnt e.getMessage() >>>" + e.getMessage());
		}
		
		return stdntList;
	}

	@Override
	public int countLctrList() {
		System.out.println("MnDaoImpl countLctrList start...");
		int countList = 0;
		
		try {
			countList = session.selectOne("com.postGre.bsHive.Mapper.mnMapper.selcountLctr");
		} catch (Exception e) {
			System.out.println("MnDaoImpl countLctrList e.getMessage() >>>" + e.getMessage());
		}
		
		return countList;
	}

	@Override
	public List<Mn_LctrInfoPage> selGetLctrList(String lctr_num) {
		System.out.println("MnDaoImpl selGetLctrList start...");
		List<Mn_LctrInfoPage> pageSelList = null;
		
		try {
			int lctrNumInt = Integer.parseInt(lctr_num);
			
			pageSelList = session.selectList("com.postGre.bsHive.Mapper.mnMapper.selListPage", lctrNumInt);
			System.out.println("pageSelList >>> " + pageSelList);
		} catch (NumberFormatException e) {
	        System.out.println("MnDaoImpl selGetLctrList NumberFormatException: lctr_num이 숫자가 아닙니다. >>> " + e.getMessage());
	    } catch (Exception e) {
			System.out.println("MnDaoImpl selGetLctrList e.getMessage() >>>" + e.getMessage());
		}
		
		return pageSelList;
	}

	@Override
	public List<Lctr_Week> selWeeksList(String lctr_num) {
		System.out.println("MnDaoImpl selWeeksList start...");
		List<Lctr_Week> weekList = null;
		
		try {
			int lctrNumInt = Integer.parseInt(lctr_num);
			
			weekList = session.selectList("com.postGre.bsHive.Mapper.mnMapper.selWeeksList", lctrNumInt);
			System.out.println("weekList >>> " + weekList);
		} catch (Exception e) {
			System.out.println("MnDaoImpl selWeeksList e.getMessage() >>>" + e.getMessage());
		}
		
		return weekList;
	}

	@Override
	public List<File> imgInsertList(List<File> fileList) {
		System.out.println("MnDaoImpl imgInsertList start...");
//		int resultNum = 0;
//		int fileGroupNum = createNewFileGroupNum(); //파일 두개이상일시 켜두기
		List<File> resultNum = new ArrayList<>();
		
		if (fileList != null && !fileList.isEmpty()) {
			for(File fileUpload : fileList) {
				int fileGroupNum = createNewFileGroupNum();
				int fileSeq = createNewFileSeq(fileGroupNum);
				System.out.println("MnDaoImpl imgInsertList fileGroupNum >>> " + fileGroupNum);
				fileUpload.setFile_group(fileGroupNum);
				fileUpload.setFile_no(fileSeq);
				System.out.println("MnDaoImpl imgInsertList fileUpload >>> " + fileUpload);
				int fileResult = session.insert("com.postGre.bsHive.Mapper.mnMapper.FileUpload", fileUpload);
				if (fileResult <= 0) {
					System.out.println("파일 업로드 실패");
				} else {
					System.out.println("파일업로드 완료");
					File fileresult = new File();
					fileresult.setFile_group(fileGroupNum);
					resultNum.add(fileresult);
					fileGroupNum = 0;
				}
			}
		}
		
		return resultNum;
	}
	
	private int createNewFileGroupNum() {
		return session.selectOne("com.postGre.bsHive.Mapper.mnMapper.getNextFileGroupNum");
	}
	
	private int createNewFileSeq(int fileGroupNum) {
		Integer maxFileSeq = session.selectOne("com.postGre.bsHive.Mapper.mnMapper.getMaxFileSeq", fileGroupNum);
		
		return (maxFileSeq == null)? 1:maxFileSeq + 1; //maxFileSeq가 null이면 1을 반환
	}

	@Override
	public Mn_LctrAplyOflWeek selListAllCurPage(Integer lctr_num) {
		System.out.println("MnDaoImpl selListAllCurPage start...");
		Mn_LctrAplyOflWeek lctrApofList = new Mn_LctrAplyOflWeek();
		
		try {
			lctrApofList = session.selectOne("com.postGre.bsHive.Mapper.mnMapper.selCurListAll", lctr_num);
		} catch (Exception e) {
			System.out.println("MnDaoImpl selListAllCurPage e.getMessage() >>>" + e.getMessage());
		}
		
		return lctrApofList;
	}

	@Override
	public User_Table selUserInfo(String unq_num) {
		System.out.println("MnDaoImpl selUserInfo start...");
		User_Table user_info = new User_Table();
		
		try {
			user_info = session.selectOne("com.postGre.bsHive.Mapper.mnMapper.selUserInfo", unq_num);
		} catch (Exception e) {
			System.out.println("MnDaoImpl selUserInfo e.getMessage() >>>" + e.getMessage());
		}
		
		return user_info;
	}

	@Override
	public List<Sort_Code> selSortCodeList(int sortco) {
		System.out.println("MnDaoImpl selSortCodeList start...");
		List<Sort_Code> sorList = null;
		
		try {
			sorList = session.selectList("com.postGre.bsHive.Mapper.mnMapper.selSortList",sortco);
		} catch (Exception e) {
			System.out.println("MnDaoImpl selSortCodeList e.getMessage() >>>" + e.getMessage());
		}
		
		return sorList;
	}

	@Override
	public int insertConPage(Lctr_Aply lctr_Aply) {
		System.out.println("MnDaoImpl insertConPage start...");
		int coninsert = 0;
		
		try {
			coninsert = session.insert("com.postGre.bsHive.Mapper.mnMapper.insertConPage", lctr_Aply);
		} catch (Exception e) {
			System.out.println("MnDaoImpl insertConPage e.getMessage() >>>" + e.getMessage());
		}
		
		return coninsert;
	}

	@Override
	public int updCount(Lctr_Aply lctr_Aply) {
		System.out.println("MnDaoImpl updCount start...");
		int updCount = 0;
		
		try {
			updCount = session.update("com.postGre.bsHive.Mapper.mnMapper.updateCount", lctr_Aply);
		} catch (Exception e) {
			System.out.println("MnDaoImpl updCount e.getMessage() >>>" + e.getMessage());
		}
		
		return updCount;
	}

	@Override
	public int lctrkeywordListCount(String keyword) {
		System.out.println("MnDaoImpl lctrkeywordListCount start...");
		int Countint = 0;
		
		try {
			Countint = session.selectOne("com.postGre.bsHive.Mapper.mnMapper.lctrkeywordListCount",keyword);
		} catch (Exception e) {
			System.out.println("MnDaoImpl lctrkeywordListCount e.getMessage() >>>" + e.getMessage());
		}
		
		return Countint;
	}

	@Override
	public List<Mn_LctrAplyOflWeek> joinLctrAplyKeywordList(String keyword, int startIndex, int endIndex) {
		System.out.println("MnDaoImpl joinLctrAplyKeywordList start...");
		List<Mn_LctrAplyOflWeek> lctListKey = null;
		Map<String, Object> mappam = new HashMap<>();
		mappam.put("keyword", keyword);
		mappam.put("startIndex", startIndex);
		mappam.put("endIndex", endIndex);
		
		try {
			lctListKey = session.selectList("com.postGre.bsHive.Mapper.mnMapper.lctrkeywordList", mappam);
		} catch (Exception e) {
			System.out.println("MnDaoImpl joinLctrAplyKeywordList e.getMessage() >>>" + e.getMessage());
		}
		
		return lctListKey;
	}
}
