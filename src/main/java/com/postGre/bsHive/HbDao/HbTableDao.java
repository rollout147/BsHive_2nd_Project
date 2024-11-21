package com.postGre.bsHive.HbDao;

import java.util.List;
import java.util.Map;

import com.postGre.bsHive.Adto.Hb_Evl;
import com.postGre.bsHive.Adto.Hb_Test;
import com.postGre.bsHive.Amodel.Crans_Qitem;
import com.postGre.bsHive.Amodel.Evl_Sbmsn;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Test;
import com.postGre.bsHive.Amodel.Test_Qitem;


public interface HbTableDao {
	void addCourseEval(Evl_Sbmsn evl_sbmsn);
	List<Hb_Evl> getCourseEval(Hb_Evl hb_Evl);
	
	// 학생의 성적 확인
	List<Hb_Evl> getAllClass(Hb_Evl hb_Evl);
	Hb_Evl getDetailGrade(int unqNum, int lctrNum);
	List<Hb_Evl> getAllClass(int lctr_num, Hb_Evl hb_Evl);
	Hb_Evl hbgetStudentDetail(int unq_num, int lctr_num);
	
	// 강의 정보 확인
	Lctr HbLctr_num(int lctr_num);
	
	// 수료 여부 업데이트
	List<Hb_Evl> updateStudentAfterClass(int lctr_num);
	// 학생 성적 업데이트용
	int findAttendanceScoreByUnqNum(int lctr_num, int unq_num);
	int findAssessmentScoreByUnqNum(int lctr_num, int unq_num);
	// 강의평가
	Integer getCompletedEvaluationCount(int lctr_num, int unq_num);
	Hb_Evl hbgetGradeByUnqNum(int unqNum);
	

	
	
	// 사용 xx
	// 시험 제출 : 학생용
	void saveStudentAnswers(Map<String, String> answers, int lctrNum, int unqNum);
	List<Hb_Test> hbgetQuestionByQitemNo(int qitemNo, int itemsPerPage, int pageNumber);
	Hb_Test findExamByLctrNum(int lctrNum);
	// 학생 시험 제출 메소드
	int submitExamAnswers(Hb_Test exam, Map<String, String> answers);
	// 출석 점수 업데이트
	boolean updateAttendanceScore(int unq_num, int atndc_scr, Integer lctr_num);
	// 과제 점수 업데이트
	boolean updateAssignmentScore(int unq_num, int asmt_scr, Integer lctr_num);
	// 시험 문제 가지고 오기
	List<Map<String, Object>> findProblemsByLctrNum(int lctrNum);
	// 존재하는 시험 문제
	Hb_Test getProblemById(int qitem_no);
	// 교수 시험 제출
	int checkTestExist(Hb_Test exam);
	int insertTest(Hb_Test exam);
	void insertTestQitemAndCrans(Test_Qitem testQitem, Crans_Qitem cransQitem);
	

}
