 package com.postGre.bsHive.Acontroller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;


import org.springframework.ui.Model;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.postGre.bsHive.Adto.Hb_Evl;
import com.postGre.bsHive.Adto.Hb_Test;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.Crans_Qitem;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Lgn;
import com.postGre.bsHive.Amodel.Test_Qitem;
import com.postGre.bsHive.HbService.HbTableService;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "hb")
public class HbController {
	private final HbTableService hbtableService;
	
	//강의 평가 리스트 불러오기
	@GetMapping("/courseEval")
	public String courEvalStart(HttpServletRequest request, 
	                             HttpServletResponse response,
	                             HttpSession session, 
	                             Model model,
	                             @RequestParam("lctr_num") int lctr_num,
	                             Hb_Evl hb_evl) throws ServletException, IOException {
	    System.out.println("hbController courseEval Start");

	    User_Table user = (User_Table) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/jh/loginForm"; // 로그인 페이지로 리디렉션
	    }
		
 		Lgn lgn = new Lgn();
 		lgn.setUnq_num(user.getUnq_num());
 		model.addAttribute("lgn", lgn);

	    Integer unqNum = (Integer) session.getAttribute("unq_num");
	    model.addAttribute("unqNum", unqNum); // 학생 번호를 모델에 추가

	    // 강의 정보 가져오기
	    Lctr lctr = hbtableService.hbgerLctrNum(hb_evl.getLctr_num());
	    model.addAttribute("lctr", lctr);

	    boolean isEvaluationCompleted = hbtableService.isEvaluationCompleted(lctr.getLctr_num(), unqNum);
	    
	    if (isEvaluationCompleted) {
	        model.addAttribute("message", "이 강의에 대한 평가는 이미 완료되었습니다.");
	        return "hb/courseEvalEnd"; // 평가 완료된 페이지로 이동
	    }
	    
	    System.out.println("나는 없지롱");
	    // 평가 문항 리스트 가져오기 (새로운 평가용)
	    List<Hb_Evl> evalQuestions = hbtableService.getEvalQuestion(hb_evl);
	    model.addAttribute("evalQuestions", evalQuestions); // 평가 문항 리스트 모델에 추가

	    return "hb/courseEval"; // 새로운 강의 평가 폼을 띄움
	}
	// 강의 평가 제출
	@PostMapping("/submitEvaluation")
	public String courseEvalSubmit(Model model, 
	                                @RequestParam Map<String, String> evaluationScores,
	                                @RequestParam("lctr_num") Integer lctr_num,  // lctr_num을 명시적으로 받음
	                                @RequestParam("unq_num")  Integer unq_num,   // unq_num을 명시적으로 받음
	                                RedirectAttributes redirectAttributes,
	                                @ModelAttribute Hb_Evl hb_evl,
	                                HttpSession session) {
	    // 로그인 확인
	    User_Table user = (User_Table) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/jh/loginForm"; // 로그인 안 되어 있으면 로그인 페이지로 리디렉션
	    }
		
 		Lgn lgn = new Lgn();
 		lgn.setUnq_num(user.getUnq_num());
 		model.addAttribute("lgn", lgn);

	    // 평가 점수와 강의 정보 출력 (디버깅용)
	    System.out.println("lctr_num: " + lctr_num);
	    System.out.println("unq_num: " + unq_num);
	    System.out.println("Evaluation Scores: " + evaluationScores);

	    // 평가 점수 데이터베이스에 저장
	    hbtableService.addAndUpdateEval(hb_evl, evaluationScores, lctr_num, unq_num);
	    
	    redirectAttributes.addAttribute("lctr_num", lctr_num);

	    // 평가 결과 페이지
	    return "redirect:/hb/courseEval";
	}
	
	//성적 확인
	@GetMapping("/showResult")
	public String showResult(Model model, HttpSession session,
			 				@RequestParam("lctr_num") Integer lctr_num,  // lctr_num을 명시적으로 받음
			 				@RequestParam("unq_num")  Integer unq_num,
			 				@ModelAttribute Hb_Evl hb_evl ) {
	    User_Table user = (User_Table) session.getAttribute("user"); 
	    if (user == null) {
	        return "redirect:/jh/loginForm"; // 로그인 안된 경우
	    }
		
 		Lgn lgn = new Lgn();
 		lgn.setUnq_num(user.getUnq_num());
 		model.addAttribute("lgn", lgn);
 		
	    Integer unqNum = (Integer) session.getAttribute("unq_num");
	    Lctr lctr = hbtableService.hbgerLctrNum(hb_evl.getLctr_num());
	    model.addAttribute("lctr", lctr);
	    // 강의 정보 가져오기
	    System.out.println(lctr_num + unqNum);
	    hb_evl = hbtableService.hbgetStudentDetail(unqNum,lctr_num);
	    
	    if (hb_evl == null) {
	        // 학생 정보가 없을 경우 처리 (예: 오류 메시지)
	        model.addAttribute("error", "학생 정보를 찾을 수 없습니다.");
	        return "hb/errorPage"; // 예시: 오류 페이지로 리디렉션
	    } else {
	        System.out.println("강의 정보 가져오기 성공: " + hb_evl.getStdnt_nm()+ hb_evl.getLctr_name());
	    }
	    System.out.println(hb_evl);
	    String evalStatus = (hb_evl.getEvl_total() > 0) ? "강의 평가 완료" : "강의 평가 미완";
	    model.addAttribute("evalStatus", evalStatus);
	    model.addAttribute("stdntName", hb_evl.getStdnt_nm() != null ? hb_evl.getStdnt_nm() : "정보 없음");
	    model.addAttribute("classname", hb_evl.getLctr_name() != null ? hb_evl.getLctr_name() : "정보 없음");
	    model.addAttribute("lctr_num", hb_evl.getLctr_num());
	    
	    System.out.println("학생 이름: " + hb_evl.getStdnt_nm());
	    System.out.println("강의번호:  " + hb_evl.getLctr_num());
	    System.out.println("강의 평가 상태: " + evalStatus);
	    	      
		return "hb/showResult"; // 정상적인 페이지로 이동
	}
	//상세 성적 확인
	@GetMapping("/detailResult")
	public String detailResult(HttpSession session,
								@RequestParam("unq_num") int unq_num, 
            				    @RequestParam("lctr_num") int lctr_num,
            				    Hb_Evl hb_evl, Model model) {
				System.out.println("상세 성적 확인 페이지, unq_num: " + unq_num + " / " + lctr_num);
				User_Table user = (User_Table) session.getAttribute("user"); 
				if (user == null) {
					return "redirect:/jh/loginForm"; // 로그인 안된 경우
				}
						
				Lgn lgn = new Lgn();
		 		lgn.setUnq_num(user.getUnq_num());
		 		model.addAttribute("lgn", lgn);
				
				// unq_num을 모델에 추가하여 JSP에서 사용 가능하도록 전달
				model.addAttribute("unq_num", unq_num);
				model.addAttribute("lctr_num", lctr_num);
				
				 Lctr lctr = hbtableService.hbgerLctrNum(hb_evl.getLctr_num());
				 model.addAttribute("lctr", lctr);
				// 단일 객체를 가져옴
				hb_evl = hbtableService.getDetailGrade(unq_num, lctr_num);
				
				// null 체크 후 리스트로 감싸기
				if (hb_evl != null) {
				    List<Hb_Evl> studentGradeList = new ArrayList<>();
				    studentGradeList.add(hb_evl);  // 단일 객체를 리스트에 추가
				    model.addAttribute("studentGrade", studentGradeList);  // 모델에 리스트 전달
				    System.out.println("여기가 detailResult입니다" + studentGradeList);
				} else {
				    System.out.println("hb_evl 객체가 null입니다.");  // 디버깅
				}
				
				
				model.addAttribute("studentList", hb_evl);  // 학생 목록을 JSP로 전달
				
				return "hb/detailResult";  // 리스트를 JSP로 전달

	}
	
	
	@GetMapping("/lecTestResult")
	public String lecTestResult(Model model, HttpSession session, Hb_Evl hb_evl, 
	                             @RequestParam("lctr_num") int lctr_num) {
	    // 세션에서 사용자 정보를 가져옵니다.
	    User_Table user = (User_Table) session.getAttribute("user"); 
	    if (user == null) {
	        return "redirect:/jh/loginForm"; // 로그인 되어 있지 않으면 로그인 페이지로 리다이렉트
	    }
	    
	    // 로그인 정보 설정
	    Lgn lgn = new Lgn();
	    lgn.setUnq_num(user.getUnq_num());
	    model.addAttribute("lgn", lgn);
	    
	    // 강좌 정보 가져오기
	    Lctr lctr = hbtableService.hbgerLctrNum(lctr_num); // 강좌 번호로 강좌 정보 조회
	    model.addAttribute("lctr", lctr);
	    
	    // 강좌에 대한 모든 학생들의 출석 점수와 과제 점수를 가져오기
	    List<Hb_Evl> hbEvlList = hbtableService.getAllClass(hb_evl); // 전체 수업 정보
	    for (Hb_Evl hbEvl : hbEvlList) {
	        int unq_num = hbEvl.getUnq_num();
	        
	        // 출석 점수와 과제 점수 가져오기
	        int attendanceScore = hbtableService.getAttendanceScore(lctr_num, unq_num);
	        int assessmentScore = hbtableService.getAssessmentScore(lctr_num, unq_num);
	        
	        // 각 학생 객체에 출석 점수와 과제 점수 설정
	        hbEvl.setAtndc_scr(attendanceScore);
	        hbEvl.setAsmt_scr(assessmentScore);
	    }
	    	model.addAttribute("classlist", hbEvlList);  // 모델에 데이터 추가
	        model.addAttribute("lctr_num", lctr_num);
	    
	    return "hb/lecTestResult"; // JSP 페이지로 반환
	}

	
	//성적 입력 후 제출
	@PostMapping("/hbsubmitGrade")
	public String submitGrades(HttpSession session, Hb_Evl hb_Evl,
	                            @RequestParam("lctr_num") Integer lctr_num,
	                            @RequestParam Map<String, Object> params, Model model) {

	    // 로그인 정보 설정
	    User_Table user = (User_Table) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/jh/loginForm"; // 예시
	    }

	    Lgn lgn = new Lgn();
	    lgn.setUnq_num(user.getUnq_num());
	    model.addAttribute("lgn", lgn);
	    
	    // 강좌 정보 설정
	    Lctr lctr = hbtableService.hbgerLctrNum(lctr_num); // lctr_num을 사용하여 강좌 정보 조회
	    model.addAttribute("lctr", lctr);

	    try {
	        // 성적 제출 처리
	        boolean success = hbtableService.submitGrades(params, lctr_num);
	        
	        if (success) {
	            model.addAttribute("message", "성적이 성공적으로 제출되었습니다.");
	        } else {
	            model.addAttribute("message", "성적 제출에 실패했습니다.");
	        }
	    } catch (Exception e) {
	        model.addAttribute("message", "에러 발생: " + e.getMessage());
	    }

	    // lctr_num을 쿼리 파라미터로 전달하여 리다이렉트
	    return "redirect:/hb/lecTestResult?lctr_num=" + lctr_num;
	}


	
	 // 교수용 최종 성적 확인
 	@GetMapping("/showFinalResult")
 	public String showFinalResult(Model model,Hb_Evl hb_Evl, HttpSession session,    
 								  @RequestParam("lctr_num") Integer lctr_num)  {
 		System.out.println("finalResultPage");
 		User_Table user = (User_Table) session.getAttribute("user"); // 올바른 키로 수정
 		if (hb_Evl == null) {
 			hb_Evl = new Hb_Evl();  // Hb_Evl 객체가 전달되지 않으면 새로 생성
 		}
 		
 		Lgn lgn = new Lgn();
 		lgn.setUnq_num(user.getUnq_num());
 		model.addAttribute("lgn", lgn);
 		 
 	 		
 		Integer unqNum = (Integer) session.getAttribute("unq_num");
 		Lctr lctr = hbtableService.hbgerLctrNum(hb_Evl.getLctr_num());
 		model.addAttribute("lctr", lctr);
 		

 	    hb_Evl.setLctr_num(lctr.getLctr_num());  // lctr_num을 Hb_Evl에 설정

 		List<Hb_Evl> hbEvl = hbtableService.getAllClass(hb_Evl);
 		System.out.println("showFinalResult start...");
 		
 		model.addAttribute("studentList",hbEvl);
 		model.addAttribute("classname", hb_Evl.getLctr_name());
 		return "hb/showFinalResult";
 	}
 	// 최종 성적 확정 후 수료 여부 change
 	@PostMapping("submitFinalApproval")
 	public String hbsubmitFinalApproval(Model model, 
 	                                    HttpSession session,
 	                                    @RequestParam("lctr_num") int lctr_num,
 	                                    Hb_Evl hb_Evl) {
 	    System.out.println("finalResultPage");
 	    
 	    User_Table user = (User_Table) session.getAttribute("user"); // 올바른 키로 수정
 	    if (hb_Evl == null) {
 	        hb_Evl = new Hb_Evl();  // Hb_Evl 객체가 전달되지 않으면 새로 생성
 	    }
 	    
 	    Lgn lgn = new Lgn();
 	    lgn.setUnq_num(user.getUnq_num());
 	    model.addAttribute("lgn", lgn);
 	    
 	    // 기존의 lctr_num을 사용하여 추가 작업
 	    Lctr lctr = hbtableService.hbgerLctrNum(hb_Evl.getLctr_num());
 	    model.addAttribute("lctr", lctr);
 	    
 	    System.out.println("받은 lctr_num: " + lctr_num);
 	    
 	    List<Hb_Evl> hbEvl = hbtableService.hbUpdateStudent(lctr_num);
 	    
 	    // lctr_num을 쿼리 파라미터로 전달하여 리다이렉트
 	    return "redirect:/hb/showFinalResult?lctr_num=" + lctr_num;
 	}

 	
	
	//아래는 사용 X : 시험 method
	//강의 내 시험 제출
	@GetMapping("/lecTestWrite")
	public String lecTestWrite(Model model, HttpSession session, Hb_Evl hb_evl,
	                            HttpServletRequest request,
	                            @RequestParam(name = "qitem_no", defaultValue = "1") int qitemNo,
	                            @RequestParam(name = "page", defaultValue = "1") int pageNumber,
	                            @RequestParam("lctr_num") int lctrNum) {

	    System.out.println("lecTestWrite start...");
	    System.out.println("lecTestWrite User_Table start..");

	    // 세션에서 사용자 정보 가져오기
	    User_Table user = (User_Table) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/jh/loginForm"; // 로그인 페이지로 리디렉션
	    }

	    // 강의 정보 가져오기
	    Lctr lctr = hbtableService.hbgerLctrNum(lctrNum);
	    model.addAttribute("lctr", lctr);  // 강의 객체를 모델에 추가
	    model.addAttribute("lctr_name", lctr.getLctr_name());  // 강의 이름을 모델에 추가

	    // 빈 시험 정보 객체 추가
	    model.addAttribute("exam", new Hb_Test());  // 빈 Hb_Test 객체를 전달

	    // 한 페이지에 표시할 문제의 수 설정
	    int itemsPerPage = 1;  // 1문제씩 표시

	    // 문제 목록 가져오기
	    List<Hb_Test> hbQuestions = hbtableService.hbgetQuestionByQitemNo(qitemNo, itemsPerPage, pageNumber);
	    model.addAttribute("questions", hbQuestions);  // 문제 목록을 모델에 추가

	    // 총 문제 수 및 페이지 수 계산
	    int totalQuestions = 10; // 총 문제 수 (임시로 10으로 설정, 실제로는 DB에서 구해야 함)
	    int totalPages = (int) Math.ceil((double) totalQuestions / itemsPerPage);
	    model.addAttribute("totalQuestions", totalQuestions);  // 총 문제 수를 모델에 추가
	    model.addAttribute("totalPages", totalPages);  // 총 페이지 수를 모델에 추가
	    model.addAttribute("currentQitemNo", qitemNo);  // 현재 문제 번호를 모델에 추가

	    return "hb/lecTestWrite";  // JSP 페이지로 이동
	}
	
	// 시험 문제 존재하면 ajax로 가지고 오기
	   @GetMapping("/getProblemInfo")
	    @ResponseBody
	    public Map<String, Object> getProblemInfo(@RequestParam("qitem_no") int qitem_no) {
	        Hb_Test hbproblemGet = hbtableService.getProblemById(qitem_no);
	        Map<String, Object> response = new HashMap<>();

	        if (hbproblemGet != null) {
	            response.put("qitem_nm", hbproblemGet.getQitem_nm());
	            response.put("qitem_expln1", hbproblemGet.getQitem_expln());
	            response.put("qitem_expln2", hbproblemGet.getQitem_no());
	            response.put("qitem_expln3", hbproblemGet.getQitem_scr());
	            response.put("qitem_expln4", hbproblemGet.getQitem_type());
	        }

	        return response;
	    }

	// 시험 제출 이후 처리
	@PostMapping("submitExam")
    public String submitExam(@ModelAttribute Hb_Test exam,
            				 @ModelAttribute Test_Qitem testQitem,
            				 @ModelAttribute Crans_Qitem cransQitem, 
						     Model model) {

        // 시험 정보 DB 저장
        boolean isSuccess = hbtableService.submitExam(exam, testQitem, cransQitem);

        if (isSuccess) {
            model.addAttribute("message", "시험 정보가 성공적으로 제출되었습니다.");
        } else {
            model.addAttribute("message", "시험 제출에 실패했습니다.");
        }

        return "hs/hsClassmain"; // 제출 결과 페이지로 이동
    }
	
	//시험 시작
	@GetMapping("/lecTest")
	public String hblecTest(@RequestParam("lctr_num") int lctrNum,
							HttpSession session,
							Model model) {
		System.out.println("hbLectTest start...");
		
		User_Table user = (User_Table) session.getAttribute("user");
		    if (user == null) {
		        return "redirect:/jh/loginForm"; // 로그인 페이지로 리디렉션
		    }
        
		Hb_Test studentExam = hbtableService.getExamByLctrNum(lctrNum);
		if (studentExam != null) {
                  // 마감일시 비교
           String atch = studentExam.getAtch();  // 마감일시 (String 형식)
                  
           DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
           LocalDate deadline = LocalDate.parse(atch, formatter);
           LocalDate currentDate = LocalDate.now();  // 현재 날짜

           // 시험 응시 가능 여부 판단
           boolean isExamOpen = currentDate.isBefore(deadline);
           List<Map<String, Object>> problems = hbtableService.getProblemsByLctrNum(lctrNum);
           System.out.println("HbListExam : " + problems);
           model.addAttribute("exam", studentExam);
           model.addAttribute("isExamOpen", isExamOpen);  // 시험 응시 여부 모델에 추가
           model.addAttribute("problems", problems);     // 문제 목록 모델에 추가

           return "hb/lecTest"; // 시험 응시 페이지로 이동
        } else {
            model.addAttribute("message", "시험이 존재하지 않거나 마감되었습니다.");
            return "hb/lecTest"; // 시험이 없으면 메인 페이지로 돌아감
        }
    
	}
	//답안 제출
	@PostMapping("/submitExamAnswers")
    public String submitExamAnswers(@ModelAttribute Hb_Test exam, @RequestParam Map<String, String> answers, Model model) {
        boolean isSuccess = hbtableService.submitExamAnswers(exam, answers);
        
        if (isSuccess) {
            model.addAttribute("message", "시험이 성공적으로 제출되었습니다.");
        } else {
            model.addAttribute("message", "시험 제출에 실패했습니다.");
        }

        return "hb/showResult"; // 결과 페이지로 이동
    }

	
}
