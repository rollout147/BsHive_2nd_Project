package com.postGre.bsHive.HbService;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.postGre.bsHive.Adto.Hb_Evl;
import com.postGre.bsHive.Adto.Hb_Test;
import com.postGre.bsHive.Amodel.Crans_Qitem;
import com.postGre.bsHive.Amodel.Evl_Sbmsn;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Test_Qitem;
import com.postGre.bsHive.HbDao.HbTableDao;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class HbTableServiceImpl implements HbTableService {
	private final HbTableDao hbtableDao;

	@Override
	public Lctr hbgerLctrNum(int lctr_num) {
		return hbtableDao.HbLctr_num(lctr_num);
	}
	@Override
	public List<Hb_Evl> getEvalQuestion(Hb_Evl hb_Evl) {
		return hbtableDao.getCourseEval(hb_Evl);
	}
	
	@Transactional
	@Override
	public Hb_Evl addAndUpdateEval(Hb_Evl hb_Evl, Map<String, String> evaluationScores, int lctr_num, int unq_num) {
	    System.out.println("Start .. addAndEval");
	    for (Map.Entry<String, String> entry : evaluationScores.entrySet()) {
	        String key = entry.getKey();  // e.g., "evaluationScores[123]"
	        String scoreString = entry.getValue();  // e.g., "5"

	        // 평가 문항 번호 파싱
	        int startIndex = key.indexOf("[");
	        int endIndex = key.indexOf("]");

	        if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
	            // 문항 번호 추출
	            int detnum = Integer.parseInt(key.substring(startIndex + 1, endIndex));  

	            // 점수 변환
	            Integer score = Integer.parseInt(scoreString); 
	            int evl_num = score;

	            // 평가 제출 객체 생성
	            Evl_Sbmsn evl_sbmsn = new Evl_Sbmsn();
	            evl_sbmsn.setEvl_detnum(detnum);  // 문항 번호 설정
	            evl_sbmsn.setEvl_ox(score > 0 ? 1 : 0);  // 점수 유효성 체크
	            evl_sbmsn.setLctr_num(lctr_num);  // 강의 번호 설정
	            evl_sbmsn.setUnq_num(unq_num);  // 학생 번호 설정
	            evl_sbmsn.setEvl_num(evl_num);

	            // 데이터베이스에 저장
	            hbtableDao.addCourseEval(evl_sbmsn);
	        } else {
	            System.err.println("Invalid key format: " + key);  // 키 포맷 오류 처리
	        }
	    }
	    return hb_Evl;
	}

	@Override
	public List<Hb_Evl> getAllClass(Hb_Evl hb_Evl) {
		System.out.println(hb_Evl.getEvl_total());
		return hbtableDao.getAllClass(hb_Evl);
	}
	@Override
	public List<Hb_Evl> getAllClass(int lctr_num,Hb_Evl hb_Evl) {
		System.out.println(hb_Evl.getStdnt_nm());
		return hbtableDao.getAllClass(lctr_num,hb_Evl);
	}


	@Override
	public Hb_Evl getDetailGrade(int unqNum, int lctrNum) {
		return hbtableDao.getDetailGrade(unqNum,lctrNum);
	}

	@Override
	public Hb_Evl hbgetStudentDetail(int unq_num, int lctr_num) {
		return hbtableDao.hbgetStudentDetail(unq_num, lctr_num);
	}
	
	@Override
	public boolean isEvaluationCompleted(int lctr_num, int unq_num) {
		Integer count = hbtableDao.getCompletedEvaluationCount(lctr_num, unq_num);
	    // 평가가 완료되었으면 count가 1 이상이면 true 반환
	    return count > 0;
    }
	@Override
	@Transactional
	public boolean submitGrades(Map<String, Object> params, Integer lctr_num) {
	    boolean isSuccess = true;

	    // 성적을 업데이트할 학생의 리스트
	    for (Map.Entry<String, Object> entry : params.entrySet()) {
	        String key = entry.getKey();
	        Object value = entry.getValue();

	        // 출석 점수 업데이트
	        if (key.startsWith("atndc_scr_")) {
	            String unq_num_str = key.substring("atndc_scr_".length());
	            int unq_num = Integer.parseInt(unq_num_str);
	            int atndc_scr = Integer.parseInt(value.toString());
	            isSuccess &= hbtableDao.updateAttendanceScore(unq_num, atndc_scr, lctr_num); // lctr_num 전달
	        } 
	        // 과제 점수 업데이트
	        else if (key.startsWith("asmt_scr_")) {
	            String unq_num_str = key.substring("asmt_scr_".length());
	            int unq_num = Integer.parseInt(unq_num_str);
	            int asmt_scr = Integer.parseInt(value.toString());
	            isSuccess &= hbtableDao.updateAssignmentScore(unq_num, asmt_scr, lctr_num);
	        }
	    }

	    return isSuccess;
	}
	
	@Override
	public int getAttendanceScore(int lctr_num, int unq_num) {
	    return hbtableDao.findAttendanceScoreByUnqNum(lctr_num, unq_num);
	}

	@Override
	public int getAssessmentScore(int lctr_num, int unq_num) {
	    return hbtableDao.findAssessmentScoreByUnqNum(lctr_num, unq_num);
	}
	
	//사용 x 
	@Override
	public Hb_Evl hbgetGradeByUnqNum(int unqNum) {
		return hbtableDao.hbgetGradeByUnqNum(unqNum);
	}
	@Override
	@Transactional
	public boolean submitExam(Hb_Test exam, Test_Qitem testQitem, Crans_Qitem cransQitem) {
		   int count = hbtableDao.checkTestExist(exam);

	        if (count == 0) {
	            // 중복 데이터가 없으면 TEST 테이블에 삽입
	            hbtableDao.insertTest(exam);  // exam 객체는 Test 테이블에 삽입
	        }

	        // Test_Qitem 테이블과 Crans_Qitem 테이블에 데이터를 삽입
	        hbtableDao.insertTestQitemAndCrans(testQitem, cransQitem);  // 한 번에 처리

	        return true;  // 성공적으로 처리된 경우
	}
	@Override
	public List<Hb_Test> hbgetQuestionByQitemNo(int qitemNo, int itemsPerPage, int pageNumber) {
		return hbtableDao.hbgetQuestionByQitemNo(qitemNo, itemsPerPage, pageNumber);
	}
	@Override
	public Hb_Test getExamByLctrNum(int lctrNum) {
        return hbtableDao.findExamByLctrNum(lctrNum);
	}
	
	@Override
	public boolean submitExamAnswers(Hb_Test exam, Map<String, String> answers) {
        int result = hbtableDao.submitExamAnswers(exam, answers);
		return result>0;
	}
	
	@Override
	public List<Map<String, Object>> getProblemsByLctrNum(int lctrNum) {
	    return hbtableDao.findProblemsByLctrNum(lctrNum);  // 문제 목록을 가져오는 메소드
	}
	@Override
	public List<Hb_Evl> hbUpdateStudent(@Param("lctr_num") int lctr_num) {
		System.out.println("hbService 여기까지는 나옵니다" + lctr_num);
		return hbtableDao.updateStudentAfterClass(lctr_num);
	}
	@Override
	public Hb_Test getProblemById(int qitem_no) {
		System.out.println("존재하는 TEST 정보 가지고 오기 입니다 " +qitem_no);
		return hbtableDao.getProblemById(qitem_no);
	}
	

	}
	

