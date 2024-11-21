package com.postGre.bsHive.HbService;

import java.util.List;
import java.util.Map;

import com.postGre.bsHive.Adto.Hb_Evl;
import com.postGre.bsHive.Adto.Hb_Test;
import com.postGre.bsHive.Amodel.Crans_Qitem;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Test_Qitem;

public interface HbTableService {
	//강의 정보
	Lctr hbgerLctrNum(int lctr_num);
	//평가 문제
	List<Hb_Evl> getEvalQuestion(Hb_Evl hb_Evl);
	// 학생용 평가 제출
	Hb_Evl addAndUpdateEval(Hb_Evl hb_Evl, Map<String, String> evaluationScores, int lctr_num, int unq_num);
	// 학생용 평가 확인 페이지: 평가 제출 유무 파악
	boolean isEvaluationCompleted(int lctr_num, int unq_num);
	// 시험 결과 정보
	List<Hb_Evl> getAllClass(Hb_Evl hb_Evl);
	// 교수용 성적
	List<Hb_Evl> getAllClass(int lctr_num, Hb_Evl hb_Evl);
	//상세 성적 확인
	Hb_Evl getDetailGrade(int unqNum, int lctrNum);
	// 성적 확인 전 리스트 불러오기
	Hb_Evl hbgetStudentDetail(int unq_num, int lctr_num);
	Hb_Evl hbgetGradeByUnqNum(int unqNum);
	// 수료 확정
	List<Hb_Evl> hbUpdateStudent(int lctr_num);
	// 출석점수
	int getAttendanceScore(int lctr_num, int unq_num);
	// 과제 점수
	int getAssessmentScore(int lctr_num, int unq_num);

	
	//사용 x 
	List<Hb_Test> hbgetQuestionByQitemNo(int qitemNo, int itemsPerPage, int pageNumber);
	// 교수가 제출한 시험 유무 판단
	Hb_Test getExamByLctrNum(int lctrNum);
	// 학생의 시험 제출 성공 유무
	boolean submitExamAnswers(Hb_Test exam, Map<String, String> answers);
	// 교수의 성적 확인
	boolean submitGrades(Map<String, Object> params, Integer lctr_num);
	//시험 문제 가지고 오기
	List<Map<String, Object>> getProblemsByLctrNum(int lctrNum);
	// 존재하는 테스트 가지고 오기
	Hb_Test getProblemById(int qitem_no);
	boolean submitExam(Hb_Test exam, Test_Qitem testQitem, Crans_Qitem cransQitem);




}
