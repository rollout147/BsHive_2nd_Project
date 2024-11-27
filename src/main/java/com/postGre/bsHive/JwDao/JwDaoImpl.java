package com.postGre.bsHive.JwDao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.postGre.bsHive.Adto.Onln_Lctr_List;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.Conts_Ch;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Onln_Lctr;
import com.postGre.bsHive.Amodel.Syllabus_Unit;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JwDaoImpl implements JwDao {
	private final SqlSession session;

// 1. 강의계획서 작성
	
	// 강의번호 뒷자리 가장 큰 값 불러오기aa
	@Override
	public int getMaxLastTwoDigitstmax() {
		System.out.println("JwDaoImpl getMaxLastTwoDigitstmax Start...");
		
		int maxTwoDigits = 0;
		maxTwoDigits = session.selectOne("selectMaxLctrNum");		
		
		return maxTwoDigits;
	}
	
	
	// 교수정보 불러오기aa
	@Override
	public User_Table getUserTable(int unq_num) {
		System.out.println("JwDaoImpl detail start..");
		
		User_Table user_Table = new User_Table();
		
		try {
			user_Table = session.selectOne("selectUserTable",    unq_num);
			System.out.println("JwDaoImpl getUserTable user_Table->"+user_Table);
		
		} catch (Exception e) {
			System.out.println("JwDaoImpl getUserTable Exception->"+e.getMessage());
		}
		
		return user_Table;
	}

	// Onln_Lctr TBL insert 
	@Override
	public int insertOnlnLctr(Onln_Lctr onln_lctr) {
		int onlnLctrResult = 0;
		System.out.println("JwDaoImpl insertOnlnLctr Start...");
		
		try {
			onlnLctrResult = session.insert("insertOnln_Lctr", onln_lctr);
			System.out.println("JwDaoImpl insertOnlnLctr insertResult->"+onlnLctrResult);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl insertOnlnLctr Exception->"+e.getMessage());
		}
		
		return onlnLctrResult;
	}
	
	// LCTR TBL insert
	@Override
	public int insertLctr(Lctr lctr) {
		int LctrinsertResult = 0;
		System.out.println("JwDaoImpl insertLctr Start...");
		
		try {
			LctrinsertResult = session.insert("insertLCTR", lctr);
			System.out.println("JwDaoImpl insertLctr LctrinsertResult->"+LctrinsertResult);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl insertLctr Exception->"+e.getMessage());
		}
		return LctrinsertResult;
	}	
	
	
	// 온라인강의 승인전 리스트 불러오기 aa
	@Override
	public List<Onln_Lctr> beforeOnlnList() {
		List<Onln_Lctr> selectBeforeList = null;
		System.out.println("JwDaoImpl beforeOnlnList Start...");
		
		try {
			selectBeforeList = session.selectList("selectBeforeList");
			System.out.println("JwDaoImpl beforeOnlnList selectBeforeList.size()->"+selectBeforeList.size());
			
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl beforeOnlnList Exception->"+e.getMessage());
		}
		
		return selectBeforeList;
	}


	
	//로그인한 교수의 미완성 강의번호 List 가져오기
	@Override
	public List<Onln_Lctr_List>  getOnlnLctrNum(Integer unq_num) {
		List<Onln_Lctr_List>  selectOnlnLctrNum = null;
		System.out.println("JwDaoImpl getOnlnLctrNum Start...");
		
		try {
			selectOnlnLctrNum = session.selectList("selectOnlnLctrNum", unq_num);
			System.out.println("JwDaoImpl getOnlnLctrNum selectUserNum->"+selectOnlnLctrNum);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl getOnlnLctrNum Exception->"+e.getMessage());
		}
		
		return selectOnlnLctrNum;
	}
	
	
	
	// 온라인강의차시 TBL insert + FILE TBL insert
	@Override
	public int insertOnlnCont(Syllabus_Unit syllabus_Unit, List<File> fileList) {
		int contResult = 0;
		System.out.println("JwDaoImpl insertOnlnCont Start...");
		
		 // 파일 그룹 ID 생성
        int fileGroupId = createNewFileGroupId();
        System.out.println("JwDaoImpl insertOnlnCont fileGroupId->"+fileGroupId);
       
        // 차시정보 먼저 저장
        // 파일 정보가 있다면 저장
        if (fileList != null && !fileList.isEmpty()) {
        	System.out.println("JwDaoImpl insertOnlnCont 파일정보 저장 시작...");
        		
            for (File fileUpload : fileList) { // Filegroup 객체를 순회
                int fileSeq = createNewFileSeq(fileGroupId);
                System.out.println("JwDaoImpl insertOnlnCont fileSeq->"+fileSeq);
                
                fileUpload.setFile_group(fileGroupId); // 파일 그룹 ID 설정
                fileUpload.setFile_no(fileSeq); // 파일 시퀀스 설정
                System.out.println("JwDaoImpl insertOnlnCont filegroup->"+fileUpload);
                
                int fileResult = session.insert("insertFileUpload", fileUpload);
                System.out.println("JwDaoImpl insertOnlnCont fileResult->"+fileResult);
                System.out.println("파일 업로드 완료!");

                if (fileResult <= 0) {
                    // 파일 업로드 실패 처리
                    System.out.println("파일 업로드 실패");
                }
            }
        } 

		
		try {
			syllabus_Unit.setFile_group(fileGroupId);
			System.out.println("JwDaoImpl insertOnlnCont insertSyll syllabus_Unit->"+syllabus_Unit);
		
			contResult = session.insert("insertSyll", syllabus_Unit);
			System.out.println("JwDaoImpl insertOnlnCont contResult->"+contResult);
			System.out.println("JwDaoImpl insertOnlnCont syllabus_Unit->"+syllabus_Unit);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl insertOnlnCont Exception->"+e.getMessage());
		}
		
		return contResult;
	}
	
	//파일 보조 메소드: createNewFileGroupId
	private int createNewFileGroupId() {
	      int createNewFileGroupId = session.selectOne("selectNextFileGroupId"); // 새로운 파일 그룹 ID 생성
	      System.out.println("createNewFileGroupId ->" +createNewFileGroupId);
	      return createNewFileGroupId;

	    }

	//파일 보조 메소드: createNewFileSeq
    private int createNewFileSeq(int fileGroupId) {
        // file_seq는 파일 그룹에 대해 최대값을 가져오는 방법
        Integer maxFileSeq = session.selectOne("selectMaxFileSeq", fileGroupId);
        System.out.println("maxFileSeq->" +maxFileSeq);
        return (maxFileSeq == null) ? 1 : maxFileSeq + 1; // maxFileSeq가 null이면 1을 반환
    }
    
    

	// 콘텐츠챕터 TBL insert aa
	@Override
	public int insertContsCh(Conts_Ch conts_ch) {
		int contsChInsert = 0;
		System.out.println("JwDaoImpl insertContsCh Start...");
		
		try {
			contsChInsert = session.insert("insertContsCh", conts_ch);
			System.out.println("JwDaoImpl insertContsCh contsChInsert->"+contsChInsert);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl insertOnlnCont Exception->"+e.getMessage());
		}

		return contsChInsert;
	}

	// 유저가 삽입한 목록을 조회
	@Override
	public List<Onln_Lctr> getOnlnLctrList(Integer unq_num) {
		List<Onln_Lctr> onlnLctrList = null;
		System.out.println("JwDaoImpl  Start...");
		
		try {
			onlnLctrList = session.selectList("selectListOnlnLctr", unq_num);
			System.out.println("JwDaoImpl getOnlnLctrList onlnLctrList.size()->"+onlnLctrList.size());
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl getOnlnLctrList Exception->"+e.getMessage());
		}
		
		
		return onlnLctrList;
	}


	@Override
	public List<Syllabus_Unit> getSyllabusUnitList(Syllabus_Unit syllabus_Unit) {
		List<Syllabus_Unit> syllList = null;
		System.out.println("JwDaoImpl getSyllabusUnitList Start...");
		
		try {
			System.out.println("JwDaoImpl getSyllabusUnitList syllabus_Unit->"+syllabus_Unit);
			syllList = session.selectList("selectListSyll", syllabus_Unit);
			System.out.println("JwDaoImpl getSyllabusUnitList syllList.size()->"+syllList.size());
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl getSyllabusUnitList Exception->"+e.getMessage());
		}
		return syllList;
	}

	@Override
	public List<Conts_Ch> getContsChList(Integer unq_num) {
		List<Conts_Ch> contsChList = null;
		System.out.println("JwDaoImpl getContsChList Start...");
		
		try {
			contsChList = session.selectList("selectListContsCh", unq_num);
			System.out.println("JwDaoImpl getContsChList contsChList.size()->"+contsChList.size());
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl getContsChList Exception->"+e.getMessage());
		}
		return contsChList;
	}

	
	// 마이페이지 나의 강의실에서 강의번호 클릭하면 상세보기
	@Override
	public List<Onln_Lctr_List> detailOnlnLctr(Integer lctr_num) {
		List<Onln_Lctr_List> onln_list = null;
		System.out.println("JwDaoImpl detailOnlnLctr Start...");
		System.out.println("JwDaoImpl detailOnlnLctr lctr_Num->"+lctr_num);
		

		try {
			onln_list = session.selectList("detailOnlnLctr", lctr_num);
			System.out.println("JwDaoImpl detailOnlnLctr onln_list->"+onln_list);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl detailOnlnLctr Exception->"+e.getMessage());
		}
		
		return onln_list;
	}

	// 수정완료후 이동
	@Override
	public int updateLctr(Lctr lctr) {
		System.out.println("JwDaoImpl updateLctr Start...");
		
		int lctrUpdate = 0;
		try {
			lctrUpdate = session.update("updateLctr", lctr);
			System.out.println("JwDaoImpl updateLctr lctrUpdate->"+lctrUpdate);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl updateLctr Exception->"+e.getMessage());
		}
		return lctrUpdate;
	}


	@Override
	public int updateOnlnLctr(Onln_Lctr onln_lctr) {
		System.out.println("JwDaoImpl updateOnlnLctr Start...");
		
		int onlnLctrUpdate = 0;
		try {
			onlnLctrUpdate = session.update("updateOnlnLctr", onln_lctr);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl updateOnlnLctr Exception->"+e.getMessage());
		}
		return onlnLctrUpdate;
	}


	@Override
	public int updateSyll(Syllabus_Unit syllabus_unit) {
		System.out.println("JwDaoImpl updateSyll Start...");
		
		int syllUpdate = 0;
		try {
			syllUpdate = session.update("updateSyll", syllabus_unit);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl updateSyll Exception->"+e.getMessage());
		}
		
		return syllUpdate;
	}


	@Override
	public int updateContsCh(Conts_Ch conts_ch) {
		System.out.println("JwDaoImpl updateContsCh Start...");
		
		int contsChUpdate = 0;
		try {
			contsChUpdate = session.update("updateContsCh", conts_ch);
			
		} catch (Exception e) {
			System.out.println("JwDaoImpl updateContsCh Exception->"+e.getMessage());
		}
		
		return contsChUpdate;
	}

	
}
