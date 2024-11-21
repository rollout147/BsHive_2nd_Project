
package com.postGre.bsHive.HbDao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.postGre.bsHive.Adto.Hb_Evl;
import com.postGre.bsHive.Adto.Hb_Test;
import com.postGre.bsHive.Amodel.Crans_Qitem;
import com.postGre.bsHive.Amodel.Evl_Sbmsn;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Test;
import com.postGre.bsHive.Amodel.Test_Qitem;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class HbTableDaoImpl implements HbTableDao {
	
	private final SqlSession session;
	
	@Override
	public Lctr HbLctr_num(int lctr_num) {
		System.out.println("hbLctr_num HbLctr_num Start...");
		Lctr lctr = new Lctr();
		
		try {
			lctr = session.selectOne("hbLctr_num", lctr_num);
		} catch (Exception e) {
			System.out.println("HbLctr_num e.getMessage()-> "+e.getMessage());
			e.printStackTrace();
		}
		return lctr;
	}

	@Override
	public List<Hb_Evl> getCourseEval(Hb_Evl hb_Evl) {
		return session.selectList("getCourseEval",hb_Evl);
	}
	
	@Transactional
	@Override
	public void addCourseEval(Evl_Sbmsn evl_sbmsn) {
	    System.out.println("HbCourseEval Start... ");
	    try {
	        // 평가 정보 삽입
	        int result = session.insert("hbaddCourseEval", evl_sbmsn);

	        // 평가 후 강의 총점 계산 및 업데이트
	        if (result > 0) {
	            System.out.println("Insert successful.");
	            // 강의 평가 총점 계산 및 업데이트
	        } else {
	            System.out.println("Insert failed.");
	        }
	        updateCourseEvalTotal(evl_sbmsn.getLctr_num(), evl_sbmsn.getUnq_num());
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
	    }
	}
	
	@Transactional
	public void updateCourseEvalTotal(int lctr_num, int unq_num) {
	    try {
	        // 해당 강의와 학생에 대한 모든 평가 점수 가져오기
	        List<Integer> evalScores = session.selectList("getEvaluationScores", Map.of("lctr_num", lctr_num, "unq_num", unq_num));
	        
	        // 총점 계산
	        if (evalScores != null && !evalScores.isEmpty()) {
	            int total = 0;
	            for (int score : evalScores) {
	                total += score; // 점수 합산
	            }

	            // LCTR_APLY 테이블 업데이트
	            Map<String, Object> params = Map.of(
	                "lctr_num", lctr_num,
	                "unq_num", unq_num,
	                "evl_total", total // 총점으로 업데이트
	            );
	            session.update("updateCourseEvalTotal", params);
	            System.out.println("Updated evl_total: " + total);
	        } else {
	            System.out.println("No evaluation scores found for lctr_num: " + lctr_num + " and unq_num: " + unq_num);
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
	    }
	}
	
	

	@Override
	public List<Hb_Evl> getAllClass(Hb_Evl hb_Evl) {
		System.out.println("HbGetStudentClass getAllClass");
	    System.out.println("getAllClass 호출" + hb_Evl);
		return session.selectList("getstudentClassList",hb_Evl);
	}

	@Override
	public Hb_Evl getDetailGrade(int unqNum, int lctrNum) {
	    System.out.println("Hb getdetailgrade start...");
	    Map<String, Object> params = new HashMap<>();
	    params.put("unq_num", unqNum);
	    params.put("lctr_num", lctrNum);
	    
	    Hb_Evl hb_evl = session.selectOne("getDetailGrade", params);
	    return hb_evl;
	}

	@Override
	public Hb_Evl hbgetStudentDetail(int unq_num, int lctr_num) {
	    System.out.println("hbgetStudentDetail Start...");
	    Hb_Evl hb_evl = null;
	    try {
	        // lctr_num과 unq_num을 전달하여 쿼리 실행
	        hb_evl = session.selectOne("hbgetStudentDetail", 
	                                    Map.of("lctr_num", lctr_num, "unq_num", unq_num)); 
	        if (hb_evl != null) {
	            System.out.println("강의 정보 가져오기 성공: " + hb_evl.getStdnt_nm());
	        } else {
	            System.out.println("해당 강의 번호와 학생 번호에 해당하는 정보가 없습니다.");
	        }
	    } catch (Exception e) {
	        System.out.println("SQL 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return hb_evl;
	}

	@Override
	public List<Hb_Evl> getAllClass(int lctr_num, Hb_Evl hb_Evl) {
		System.out.println("HbGetStudentClass getAllClass");
		return session.selectList("getstudentClassListWith",lctr_num);
	}

	@Override
	public Integer getCompletedEvaluationCount(int lctr_num, int unq_num) {
	    Integer count = 0;
	    try {
	        // "EVL_RESULT" 테이블에서 해당 강의 번호와 학생 번호에 대한 평가가 존재하는지 확인
	        count = session.selectOne("getCompletedEvaluationCount", new HashMap<String, Object>() {{
	            put("lctr_num", lctr_num);
	            put("unq_num", unq_num);
	        }});
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;

	}

	@Override
	public Hb_Evl hbgetGradeByUnqNum(int unqNum) {
		return session.selectOne("hbgetGradeByUnqNum");
	}


	@Override
	public List<Hb_Test> hbgetQuestionByQitemNo(int qitemNo, int itemsPerPage,int pageNumber) {
		 int offset = (pageNumber - 1) * itemsPerPage;
		 Map<String, Object> params = new HashMap<>();
		 params.put("qitemNo", qitemNo);
		 params.put("itemsPerPage", itemsPerPage);
		 params.put("offset", offset);
		    
		return session.selectList("hbgetQuestionByQitemNo", params);
	}
	
	@Override
	 public int checkTestExist(Hb_Test exam) {
	 return session.selectOne("checkTestExist", exam);
	    }

	@Override
	@Transactional
	public void insertTestQitemAndCrans(Test_Qitem testQitem, Crans_Qitem cransQitem) {
	   session.insert("insertTestQitem", testQitem);
	   session.insert("insertCransQitem", cransQitem);
	}

	@Override
	public int insertTest(Hb_Test exam) {
	return session.insert("insertTest", exam);
	}
	
	@Override
	public void saveStudentAnswers(Map<String, String> answers, int lctrNum, int unqNum) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Hb_Test findExamByLctrNum(int lctrNum) {
		return session.selectOne("selectExamByLctrNum", lctrNum);
	}

	@Override
	public int submitExamAnswers(Hb_Test exam, Map<String, String> answers) {
		 return session.insert("insertExamAnswers", new Object[]{exam, answers});
	}


	@Override
	public List<Map<String, Object>> findProblemsByLctrNum(int lctrNum) {
	    return session.selectList("selectProblemsByLctrNum", lctrNum);  // 문제 목록을 가져오는 쿼리 호출
	}
	
	@Override
	public List<Hb_Evl> updateStudentAfterClass(int lctr_num) {
	    Map<String, Object> newUpdateMap = new HashMap<>();
	    newUpdateMap.put("lctr_num", lctr_num);
	    int updatedRows = session.update("updateStudentAfterClass", newUpdateMap);
	    System.out.println("영향을 받은 레코드 수: " + updatedRows);
	    return null;  // 혹시라도 나중에 결과를 반환할 필요가 있다면 추가
	}
	
	@Override
	public Hb_Test getProblemById(int qitem_no) {
	    // 하나의 결과를 조회하려면 selectOne을 사용하는 것이 좋음
	    Hb_Test problem = session.selectOne("getProblemById", qitem_no);

	    // 결과가 1개 이상일 경우에만 반환
	    if (problem != null) {
	        return problem;
	    }

	    // 결과가 없으면 null 반환
	    return null;
	}
	
	@Override
	public int findAttendanceScoreByUnqNum(int lctr_num, int unq_num) {
	    // 출석 점수 업데이트
		 Map<String, Object> params = Map.of("lctr_num", lctr_num, "unq_num", unq_num);
		 Integer  result = session.selectOne("CallupdateAttendanceScore", params);

		    if (result == null) {
		        System.out.println("출석 점수 반환이 없습니다. lctr_num: " + lctr_num + ", unq_num: " + unq_num);
		        return 0; // 점수가 없으면 -1 반환
		    } else {
		        System.out.println("출석 점수 반환: " + result);  // 결과에서 출석 점수만 반환
		        return result;
		    }
	}

	 @Override
	public int findAssessmentScoreByUnqNum(int lctr_num, int unq_num) {
		 Map<String, Object> params = Map.of("lctr_num", lctr_num, "unq_num", unq_num);
		 Integer  result = session.selectOne("CallupdateAssessmentScore", params);
		    System.out.println("result-> "+result);
		    if (result == null) {
		        System.out.println("과제 점수 반환이 없습니다. lctr_num: " + lctr_num + ", unq_num: " + unq_num);
		        return 0; // 점수가 없으면 -1 반환
		    } else {
		        System.out.println("과제 점수 반환: " + result);  // 결과에서 과제 점수만 반환
		        return result;
		    }
	}
	 
	 @Override
		public boolean updateAttendanceScore(int unq_num, int atndc_scr, Integer lctr_num) {
			 Map<String, Object> params = new HashMap<>();
			 params.put("unq_num", unq_num);
			 params.put("atndc_scr", atndc_scr);
			 params.put("lctr_num", lctr_num); // lctr_num을 추가
			 System.out.println("실행합니다" + atndc_scr + unq_num);

			 return session.update("updateAttendanceScore", params) > 0;
			}
		

		@Override
		public boolean updateAssignmentScore(int unq_num, int asmt_scr, Integer lctr_num) {
			 Map<String, Object> params = new HashMap<>();
		     params.put("unq_num", unq_num);
		     params.put("asmt_scr", asmt_scr);
			 params.put("lctr_num", lctr_num); // lctr_num을 추가
			 System.out.println("실행합니다" + asmt_scr + unq_num);

		     return session.update("updateAssignmentScore", params) > 0;
		}
	

}
