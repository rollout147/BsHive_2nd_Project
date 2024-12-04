package com.postGre.bsHive.Acontroller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.postGre.bsHive.Adto.Onln_Lctr_List;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.Conts_Ch;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Onln_Lctr;
import com.postGre.bsHive.Amodel.Syllabus_Unit;
import com.postGre.bsHive.JwService.JwService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/jw")

public class JwController {
	private final JwService js;
	// 파일첨부
	 @Value("${spring.file.upload.path}")
	    private String UPLOAD_DIRECTORY;
	
	//강의계획서 루틴(교수제출->직원승인->온라인강의에 등록됨)
	
	// 1. 온라인강의정보 입력
	// 로그인한 교수의 정보에서 고유번호와 이름을 들고 감
	@RequestMapping(value = "/writeFormOnlnLctr")
	public String writeFormOnlnLctr(Model model, HttpSession session) {
		System.out.println("JwController writeFormOnlnLctr Start...");	
		
		//로그인 안한 회원을 로그인 창으로 유도
		User_Table user = (User_Table) session.getAttribute("user");
	    System.out.println("JwController writeFormOnlnConts 가져온 교수정보->"+user);
	    
	    if (user == null || user.getUnq_num() == 0) {
	        model.addAttribute("msg", "로그인 정보가 필요합니다.");
	        return "forward:/jh/loginForm";  // 로그인 페이지로 리다이렉트
	    }
		
		// 랜덤 객체 생성
	    Random random = new Random();
		
		// 연도 마지막 두 자리 추출
		String yearPrefix = String.valueOf(LocalDate.now().getYear()).substring(2);
		System.out.println("연도 마지막 두 자리->"+yearPrefix);
		
		// 차수 번호 폼 입력 날짜에 따른1,2,3,4 분기로 생성
		int month = LocalDate.now().getMonthValue();
	    String unitNum;
	    
	    if (month >= 1 && month <= 3) {
	        unitNum = "1";  // 1분기 (1~3월)
	    } else if (month >= 4 && month <= 6) {
	        unitNum = "2";  // 2분기 (4~6월)
	    } else if (month >= 7 && month <= 9) {
	        unitNum = "3";  // 3분기 (7~9월)
	    } else {
	        unitNum = "4";  // 4분기 (10~12월)
	    }
	    System.out.println("분기에 따른 차수 번호 (unitNum)-> " + unitNum);


		// 학부 + 학과 번호 추출
		Integer unqNum = (Integer)session.getAttribute("unq_num");
		String unqNumStr = String.valueOf(unqNum);
		String fourFiveNumber = getFourFiveNumber(unqNumStr);
		System.out.println("교수번호에서 추출한 학부, 학과번호->"+fourFiveNumber);
		
		// 온라인 숫자 0에서 4 사이의 한 자리 숫자로 랜덤 생성
		String onNum = String.valueOf(random.nextInt(5));
	    System.out.println("랜덤 생성된 오프라인 숫자 (onNum)-> " + onNum);
		
	    // Lctr_num 새 강의번호 뒤의 두 자리  생성
	    int maxLastTwoDigits = js.getMaxLastTwoDigits();
 	    String lastTwoDigits = String.format("%02d",  maxLastTwoDigits + 1);
 	    System.out.println("Max값에서 1이 더해진 lastTwoDigits-> " + lastTwoDigits);
		
		// 위의 숫자들 합해서 구성한 강의 번호 구성
		String lctr_num = yearPrefix + unitNum + fourFiveNumber + onNum + lastTwoDigits;
		System.out.println("생성된 강의번호->"+lctr_num);
		
		// 강의번호를 모델에 추가하여 뷰로 전달
		model.addAttribute("lctr_num", lctr_num);
		
		return "jw/writeFormOnlnLctr";
	}
	

	// 온라인강의 TBL insert
	@RequestMapping(value = "/insertOnlnLctr" , method = RequestMethod.POST)
	public String insertOnlnLctr(@RequestParam("lctr_num") String lctr_num,
								 @RequestParam("lctr_name") String lctr_name,
								 Onln_Lctr onln_lctr,
								 Model model, 
								 HttpSession session,
								 HttpServletRequest request
								 ) {
		System.out.println("JwController insertOnlnLctr Start...");
		

		// 교수의 Unq_num2 가져와서 뷰로 전달
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
		User_Table user_Table3 = js.getUserTable(user_Table1.getUnq_num());
		// user_Table3.unq_num=224110017 -->교수 
		System.out.println("JwController writeFormOnlnLctr user_Table3->"+user_Table3);
		model.addAttribute("user_Table3", user_Table3);

		
		// user_Table3.unq_num에서 가져온 교수 고유번호 set
	    onln_lctr.setUnq_num2(user_Table3.getUnq_num());
	
		// 강의번호를 포함한 Onln_Lctr TBL insert 
		System.out.println("JwController insertOnlnLctr onln_lctr->"+onln_lctr);
		int insertOnlnLctr = js.insertOnlnLctr(onln_lctr);
		System.out.println("JwController insertOnlnLctr insertOnlnLctr->"+insertOnlnLctr);
		
		// Lctr TBL insert
		Lctr lctr = new Lctr();
		lctr.setLctr_num(onln_lctr.getLctr_num());
		lctr.setUnq_num(0);
		lctr.setAply_type(100);
		lctr.setAply_ydm(onln_lctr.getBgng_ymd());
		lctr.setPscp_nope(onln_lctr.getRcrt_nope());
		lctr.setLctr_name(lctr_name);
		lctr.setUnq_num2(onln_lctr.getUnq_num2());
		lctr.setEnd_date(onln_lctr.getEnd_ymd());
		lctr.setPscp_count(0);
		System.out.println("JwController insertOnlnLctr lctr->"+lctr);
		
		int insertLCTR = js.insertLctr(lctr);
		System.out.println("JwController insertOnlnLctr insertLCTR->"+insertLCTR);
		
		if(insertOnlnLctr > 0 && insertLCTR > 0) {
			System.out.println("JwController insertOnlnLctr insert 성공!");
	        session.setAttribute("message1", "강의가 성공적으로 등록되었습니다. 차시와 콘텐츠 입력을 완료해주세요.");
	        return "redirect:/jw/beforeOnlnLctrList"; 
		
		} else {
	        session.setAttribute("message", "강의 등록에 실패하였습니다. 재입력해주세요.");
			System.out.println("JwController insertOnlnLctr insertLCTR failure->"+insertLCTR);
			
			return "forward:/writeFormOnlnLctr";
		}
	
	}
	
	// 학부 + 학과 번호 추출 보조 메소드
	private String getFourFiveNumber(String unqNumStr) {
		if (unqNumStr.length() >= 5) {
			return unqNumStr.substring(3,5);
			
		} else {
			return "Invalid unq_num";
		}
	}


	
	// 2. 온라인강의 차시정보 입력 폼으로 이동
	
	// 교수 정보 가져오기+ 입력 완성이 안된 목록을 select box로 가져오기
	@RequestMapping(value = "/beforeOnlnLctrList")
	public String listOnlnConts(HttpSession session, Model model,
									 Onln_Lctr onln_lctr1) {
		System.out.println("JwController writeFormOnlnConts Start...");
		
		 // 로그인한 교수의 unq_num 가져오기
	    User_Table user = (User_Table) session.getAttribute("user");
	    System.out.println("JwController writeFormOnlnConts 가져온 교수정보->"+user);
	    
	    if (user == null || user.getUnq_num() == 0) {
	        model.addAttribute("msg", "로그인 정보가 필요합니다.");
	        return "forward:/jh/loginForm";  // 로그인 페이지로 리다이렉트
	    }
	    
	    // 세션에서 unq_num을 가져온 후 해당 교수의 상세 정보를 조회
	    Integer unq_num = user.getUnq_num();
	    System.out.println("가져온 unq_num->"+unq_num);
	    
	    
	    //교수의 unq_num을 이용하여 온라인 강의번호 조회
	    List<Onln_Lctr_List> onlnLctrNumList  = js.getOnlnLctrNum(unq_num); 
	    System.out.println("JwController writeFormOnlnConts onlnLctrNumList->"+onlnLctrNumList);
	    
	  //교수의 unq_num을 이용하여 강의명 조회
	  //    List<Lctr> lctrNameList = js.getLctrName(unq_num);
	  //  System.out.println("JwController writeFormOnlnConts lctrNameList->"+lctrNameList);
	    
	    model.addAttribute("onlnLctrNumList", onlnLctrNumList );
	    
	    String message1 = (String) session.getAttribute("message1");
		if (message1 != null) {
	        model.addAttribute("message1", message1);
	        session.removeAttribute("message1"); // 메시지 처리 후 세션에서 제거
	    }
	    
	    return "jw/beforeOnlnLctrList";
	}
	
	
	// Syllubus TBL insert와 selectr
	@PostMapping(value = "/insertOnlnConts")
	public String insertOnlnCont(@RequestParam("lctr_num") int lctr_num,    // 선택한 강의번호
	                             @RequestParam("vdo_id") String vdo_id,  	// 폼에서 넘어온 비디오 ID
	                             @RequestParam("conts_nm") String conts_nm, // 폼에서 넘어온 콘텐츠명
	                             @RequestParam("play_hr") String play_hr,  // 폼에서 넘어온 재생시간
	                             @RequestParam("file") List<MultipartFile> files,
	                             HttpServletRequest request,
	                             HttpSession session,
	                             Model model) {
	    System.out.println("JwController insertOnlnCont Start...");

	    // 1. 세션에서 로그인 정보 가져오기
	    User_Table user = (User_Table) session.getAttribute("user");
	    Integer unq_num = user != null ? user.getUnq_num() : null;

	    if (user == null || unq_num == null) {
	        model.addAttribute("msg", "로그인 정보가 필요합니다.");
	        return "forward:/jh/loginForm";  // 로그인 페이지로 리다이렉트
	    }
	    
	 // 2. 차시비디오 TBL insert
	    Syllabus_Unit syllabus_Unit = new Syllabus_Unit();
	    syllabus_Unit.setLctr_num(lctr_num);		// 강의번호 select box 선택
	    syllabus_Unit.setVdo_id(vdo_id);			// 비디오 아이디 입력
	    syllabus_Unit.setConts_nm(conts_nm);		// 콘텐츠 이름 입력
	    syllabus_Unit.setPlay_hr(play_hr);			// 비디오 총 재생시간 입력
	    

	    // 3. 파일 로직
	    List<File> fileList = new ArrayList<>();
        if (files != null) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    try {
                        String uuid = UUID.randomUUID().toString();
                        String originalFileName = file.getOriginalFilename();
                        int fileSize = (int) file.getSize();
                        String uniqueFileName = uuid + "_" + originalFileName;
                        Path filePath = Paths.get("src/main/resources/static/", UPLOAD_DIRECTORY).toAbsolutePath().normalize();
                        Files.createDirectories(filePath.getParent());
                        file.transferTo(filePath.toFile());

                        // File 객체에 파일 정보 설정
                        File fileRecord = new File();
                        fileRecord.setFile_group(0); // 필요시 그룹 이름 설정
                        fileRecord.setFile_no(0); // 파일 번호 설정
                        fileRecord.setFile_unq(uuid);
                        fileRecord.setDwnld_file_nm(originalFileName);
                        fileRecord.setFile_size(fileSize);
                        fileRecord.setFile_path_nm("/uploads/" + uniqueFileName);

                        fileList.add(fileRecord);
                        System.out.println("JwController insertOnlnCont fileList->" +fileList);

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            System.out.println("파일이 없습니다.");

        }

	    System.out.println("JwController insertOnlnCont fileList->" + fileList);
       int insertOnlnsyllUnit = js.insertOnlnCont(syllabus_Unit, fileList);
	    System.out.println("JwController insertOnlnCont insertOnlnCont1->" + insertOnlnsyllUnit);
	    
	    
	    // 3. insertOnlnsyllUnit가 성공한 경우에만 CONT_CH 삽입 진행
	    if (insertOnlnsyllUnit > 0) {
        
		    System.out.println("JwController insertOnlnCont getSyllabusUnitList syllabus_Unit->" + syllabus_Unit);
	    	List<Syllabus_Unit> syllabusUnitList = js.getSyllabusUnitList(syllabus_Unit);
	        System.out.println("JwController insertOnlnCont syllabusUnitList->"+syllabusUnitList);
	       
	        model.addAttribute("syllabusUnitList", syllabusUnitList);
	        model.addAttribute("lctr_msg", "차시가 성공적으로 등록되었습니다.콘텐츠 입력까지 완료부탁드립니다.");
	        model.addAttribute("unit_num", syllabus_Unit.getUnit_num());
	        model.addAttribute("lctr_num", lctr_num);
	        
	        return "jw/beforeOnlnLctrList";
	    
	    } else {
	        model.addAttribute("msg", "SYLLABUS_UNIT 삽입 실패");
	        return "redirect:/jw/insertOnlnConts";  // 삽입 실패 시 직전 페이지로 리다이렉트
	    }
	}
	
	
	
	// Conts_Ch TBL insert
	@PostMapping(value = "/insertContsCh")
	public String insertContsCh(@RequestParam("lctr_num") int lctr_num,
								@RequestParam("unit_num") int unit_num,
								@RequestParam("ch_num") List<Integer> ch_numList,
					            @RequestParam("play_start") List<String> play_startList,
	                            @RequestParam("ch_nm") List<String> ch_nmList,
	                            HttpSession session,
	                            Model model) {
	    System.out.println("JwController insertContsCh Start...");

	    int ch_num = 1;  // 챕터 번호는 1부터 시작

	    for (int i = 0; i < ch_numList.size(); i++) {
	        Conts_Ch conts_ch = new Conts_Ch();
	        conts_ch.setLctr_num(lctr_num); // lctr_num 설정
	        conts_ch.setUnit_num(unit_num); // lctr_num 설정
	        conts_ch.setCh_num(ch_numList.get(i)); // ch_num 설정
	        conts_ch.setPlay_start(play_startList.get(i)); // play_start 설정
	        conts_ch.setCh_nm(ch_nmList.get(i)); // ch_nm 설정
	        
	        System.out.println("JwController insertContsCh conts_Ch->" + conts_ch);

	        // insert 시작
	        int insertContsCh = js.insertContsCh(conts_ch);  
	        System.out.println("JwController insertContsCh insertContsCh->"+insertContsCh);
	        
	        if (insertContsCh > 0) {
	        	
	        	
	        	// insert 완료되면 Conts_Ch 목록 보이기
	            User_Table user = (User_Table) session.getAttribute("user");
	            System.out.println("JwController insertContsCh user->"+user);
	            // Integer unq_num = user != null ? user.getUnq_num() : null;
	            Integer unq_num = user.getUnq_num();
	            System.out.println("JwController insertContsCh unq_num->"+unq_num);
	            
	            if (unq_num != null) {
	            	// Conts_Ch 목록 표기
//	                List<Conts_Ch> contsChList = js.getContsChList(unq_num);
//	                System.out.println("JwController insertContsCh contsChList->"+contsChList);
//	                model.addAttribute("contsChList", contsChList);  

	    	        //교수의 unq_num을 이용하여 미완성한 강의목록 조회하기
	            	List<Onln_Lctr_List> onlnLctrNumList  = js.getOnlnLctrNum(unq_num); 
	        	    System.out.println("JwController writeFormOnlnConts onlnLctrNumList->"+onlnLctrNumList);
	        	    model.addAttribute("onlnLctrNumList", onlnLctrNumList );
	                
	            }
 
	        } else {
	            model.addAttribute("conts_ch_msg", "CONTS_CH 삽입 실패" + ch_num);
	            System.out.println("JwController insertContsCh insertContsChResult / CONTS_CH 삽입 실패");
	            return "redirect:/jw/insertContsCh";  // 삽입 실패 시 직전 페이지로 리다이렉트
	           
	        }
	        
	        ch_num++; // 챕터번호 증가
        	System.out.println("JwController insertContsCh ch_num++->"+ch_num);
	    }
    
	    System.out.println("전부 삽입성공!!");
	    // 삽입 완료 후 마이페이지의 나의 강의실로 이동
        session.setAttribute("message", "모든 강의 정보가 등록되었습니다. 감사합니다.");
	    return "redirect:/jh/registeredClassProfessor";  
	}
	
	// 마이페이지 나의 강의실에서 강의번호 클릭하면 상세보기
	@GetMapping(value = "/detailOnlnLctr")
	public String detailOnlnLctr(@RequestParam("Lctr_num") Integer lctr_num,
								 Model model) {
		System.out.println("JwController detailOnlnLctr Start...");
		
		System.out.println("JwController detailOnlnLctr Lctr_Num->"+lctr_num);
		List<Onln_Lctr_List> onlnLctrDetailList = js.detailOnlnLctr(lctr_num);
		System.out.println("JwController detailOnlnLctr onlnLctrDetailList->"+onlnLctrDetailList);
		
		model.addAttribute("onlnLctrDetailList", onlnLctrDetailList);
		model.addAttribute("lctr_num", lctr_num);
		System.out.println("detailOnlnLctr lctr_num->"+lctr_num);
		
		return "jw/detailOnlnLctr";
	}
	
	// 수정폼 이동
	@GetMapping(value = "/updateOnlnLctr")
	public String updateList(@RequestParam("lctr_num") Integer lctr_num,
								 Model model) {
		System.out.println("JwController updateOnlnLctr Start...");
		System.out.println("JwController updateOnlnLctr Lctr_Num->"+lctr_num);
		
		List<Onln_Lctr_List> onlnLctrDetailList = js.detailOnlnLctr(lctr_num);
		System.out.println("JwController updateOnlnLctr onlnLctrDetailList->"+onlnLctrDetailList);
		
		model.addAttribute("onlnLctrDetailList", onlnLctrDetailList);
		model.addAttribute("lctr_num", lctr_num);
		
		return "jw/updateOnlnLctr";
	}
	
	// 수정완료후 이동
	@PostMapping(value = "updateList")
	public String updateAllOnlnLctr(Onln_Lctr onln_lctr,
		 							Syllabus_Unit syllabus_unit,
		 							Conts_Ch conts_ch,
								 	Model model) {
		System.out.println("JwController updateList Start...");
		
		// Onln_Lctr 업데이트
		int onlnLctrUpdate		= js.updateOnlnLctr(onln_lctr);
		System.out.println("JwController updateList onlnLctrUpdate->"+onlnLctrUpdate);
		model.addAttribute("onlnLctrUpdate", onlnLctrUpdate);

		// Lctr 업데이트
		Lctr lctr = new Lctr();
		lctr.setAply_ydm(onln_lctr.getBgng_ymd());
		lctr.setEnd_date(onln_lctr.getEnd_ymd());
		lctr.setPscp_nope(onln_lctr.getRcrt_nope());
		
		int lctrUpdate			= js.updateLctr(lctr);
		System.out.println("JwController updateList lctrUpdate->"+lctrUpdate);
		model.addAttribute("lctrUpdate", lctrUpdate);

		// Syllabus_Unit 업데이트
		int syllabusUnitUpdate	= js.updateSyll(syllabus_unit);
		System.out.println("JwController updateList syllabusUnitUpdate->"+syllabusUnitUpdate);
		model.addAttribute("syllabusUnitUpdate", syllabusUnitUpdate);

		// Conts_Ch 업데이트
		int contsChUpdate		= js.updateContsCh(conts_ch);
		System.out.println("JwController updateList contsChUpdate->"+contsChUpdate);
		model.addAttribute("contsChUpdate", contsChUpdate);
		
		return "forward:/jw/detailOnlnLctr";
	}
	
}

