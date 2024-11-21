package com.postGre.bsHive.Acontroller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import java.io.IOException;
import java.net.URLEncoder;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;

import com.postGre.bsHive.Adto.Onln_Lctr_List;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Lctr;
import com.postGre.bsHive.Amodel.Syllabus_Unit;
import com.postGre.bsHive.HsService.HsService;
import com.postGre.bsHive.SeService.Paging;
import com.postGre.bsHive.SeService.SeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/se")
public class SeController {
	
	private final SeService ss;
	
	private final HsService hss;
	
	// LMS 리스트
	@GetMapping(value = "/onlnList") 
	public String onlnList(Onln_Lctr_List onln_Lctr_List, Model model) {
		// 글갯수
		int onlnTotal  = ss.onlnTotal();
		// 페이지		
		Paging page = new Paging(onlnTotal, onln_Lctr_List.getCurrentPage());
		onln_Lctr_List.setStart(page.getStart());
		onln_Lctr_List.setEnd(page.getEnd());
		// 글리스트
		List<Onln_Lctr_List> onlnList = ss.onlnList(onln_Lctr_List);
		Lctr lctr = hss.callLctr_num(onln_Lctr_List.getLctr_num());
		model.addAttribute("lctr", lctr);
		model.addAttribute("onlnTotal", onlnTotal);
		model.addAttribute("onlnList", onlnList);
	    model.addAttribute("page", page);

	    return "se/onlnList"; 
	}
	
	@GetMapping(value = "/onlnDtl") 
	public String onlnDtl(@RequestParam(value = "Lctr_Num") Integer Lctr_Num, Model model) {
		System.out.println("onlnDtl 작동");
		
		Onln_Lctr_List onlnDtl = ss.onlnDtl(Lctr_Num);
		Lctr lctr = hss.callLctr_num(Lctr_Num);
		model.addAttribute("lctr", lctr);
		model.addAttribute("onlnDtl", onlnDtl);
		
		return "se/onlnDtl"; 
	}
	
	@GetMapping(value = "lctrViewList")
	public String lctrViewList(
	        @RequestParam(value = "unq_num") Integer unq_num, // 필수 파라미터
	        @RequestParam(value = "lctr_num") Integer lctr_num, // 필수 파라미터
	        HttpServletRequest request,
	        HttpSession session,
	        Model model) {

	    // 세션에서 사용자 정보 가져오기
	    User_Table user = (User_Table) session.getAttribute("user"); // 올바른 키로 수정
	    if (user == null) {
	        // 세션에 사용자 정보가 없으면 적절한 처리를 수행 (예: 로그인 페이지로 리다이렉트)
	        return "redirect:/jh/loginForm"; // 예시
	    }
	    
	    int userUnqNum = user.getUnq_num(); // 사용자 고유 번호 가져오기

	    // 서비스 메서드 호출
	    List<Onln_Lctr_List> onln_Lctr_List = ss.lctrViewList(userUnqNum , lctr_num); 
		 // 값이 이미 존재하는지 확인
		    boolean isExist = ss.checkLctrView(lctr_num, userUnqNum);  // 예시: 값 존재 여부 확인 메서드
		    
		    if (!isExist) {
		        // 값이 없으면 인설트
		        ss.insertLctrView(lctr_num, userUnqNum);
		    }
	    // 모델에 추가
	    model.addAttribute("onln_Lctr_List", onln_Lctr_List);
	    System.out.println("onln_Lctr_List 값 "+onln_Lctr_List);
	    Lctr lctr = hss.callLctr_num(lctr_num);
		model.addAttribute("lctr", lctr);
	    return "se/lctrViewList"; // JSP 페이지로 이동
	}

	@GetMapping(value = "/lctrView")
	public String lctrViewList(Syllabus_Unit syllabus_Unit, HttpServletRequest request, HttpSession session, Model model) {
	    // 세션에서 사용자 정보 가져오기
	    User_Table user = (User_Table) session.getAttribute("user"); // 올바른 키로 수정
	    if (user == null) {
	        // 세션에 사용자 정보가 없으면 적절한 처리를 수행 (예: 로그인 페이지로 리다이렉트)
	        return "redirect:/jh/loginForm"; // 예시
	    }
	    int userUnqNum = user.getUnq_num(); // 사용자 고유 번호 가져오기
	    System.out.println("lctrViewList 컨트롤 작동완료");
	    Lctr lctr = hss.callLctr_num(syllabus_Unit.getLctr_num());
		model.addAttribute("lctr", lctr);
	    // 파일 경로 가져오기
	    List<File> filePath = ss.filePath(syllabus_Unit.getFile_group());
	    System.out.println("filePath 컨트롤 " + filePath);

	    // 쿼리 파라미터에서 값 가져오기
	    String vdoId = request.getParameter("vdo_id");
	    String lastDtl = request.getParameter("last_dtl");
	    String maxDtl = request.getParameter("max_dtl");
	    String chnm = request.getParameter("ch_nm");
	    String playstart = request.getParameter("play_start");

	    int lctrNum = Integer.parseInt(request.getParameter("lctr_num"));
	    int unitNum = Integer.parseInt(request.getParameter("unit_num"));
	    int playHr = Integer.parseInt(request.getParameter("play_hr"));
	    String contsNm = request.getParameter("conts_nm");

	    

	    // 모델에 객체 추가
	    model.addAttribute("vdoId", vdoId);
	    model.addAttribute("lastDtl", lastDtl);
	    model.addAttribute("maxDtl", maxDtl);
	    model.addAttribute("chnm", chnm);
	    model.addAttribute("playstart", playstart);
	    model.addAttribute("lctrNum", lctrNum);
	    model.addAttribute("unitNum", unitNum);
	    model.addAttribute("unqNum", userUnqNum);
	    model.addAttribute("playHr", playHr);
	    model.addAttribute("contsNm", contsNm);

	    // 챕터 리스트 가져오기
	    List<Onln_Lctr_List> chapterList = ss.getChaptersForVideo(vdoId);
	    request.setAttribute("chapterList", chapterList);

	    // 파일 경로 추가
	    model.addAttribute("filePath", filePath);

	    // JSP 페이지로 이동
	    return "se/lctrView";
	}


	
	@GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(@RequestParam("filePath") String filePath) {
        try {
            Path fullPath = Paths.get(filePath).toAbsolutePath();
            Resource resource = new UrlResource(fullPath.toUri());

            if (resource.exists() && resource.isReadable()) {
                String fileName = URLEncoder.encode(fullPath.getFileName().toString(), "UTF-8").replaceAll("\\+", "%20");
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
	
	@GetMapping(value = "/myLctrList")
	public String myLctrList(HttpSession session, Model model) {
		System.out.println("나의 수강목록 페이지로 이동");
		int unq_num = (int) session.getAttribute("unq_num");
		List<Map<String, Object>> myLctrList = ss.myLctrList(unq_num);
		
		System.out.println("수강신청현황 갯수 = " + myLctrList);
		model.addAttribute("myLctrList", myLctrList);
		return "se/myLctrList";
	}
	
	@GetMapping(value = "onlnAply")
	public String onlnAply(
	        @RequestParam(value = "lctr_num") Integer lctr_num, // 필수 파라미터
	        HttpServletRequest request,
	        HttpSession session,
	        Model model) {

	    // 세션에서 사용자 정보 가져오기
	    User_Table user = (User_Table) session.getAttribute("user"); // 올바른 키로 수정
	    if (user == null) {
	        // 세션에 사용자 정보가 없으면 적절한 처리를 수행 (예: 로그인 페이지로 리다이렉트)
	        return "redirect:/jh/loginForm"; // 예시
	    }
	    Integer unq_num = user.getUnq_num();
	    User_Table stdnt = ss.stdntDtl(unq_num);
	    Lctr lctr = hss.callLctr_num(lctr_num);
	  		model.addAttribute("lctr", lctr);
	    Onln_Lctr_List lctr_Aply = ss.onlnAply(lctr_num); 

	    // 모델에 추가
	    model.addAttribute("onlnAply", lctr_Aply);
	    model.addAttribute("user", stdnt);               //
	    System.out.println("onlnAply 값 "+lctr_Aply);
	    System.out.println("user 값 "+stdnt);
	    return "se/onlnAply"; // JSP 페이지로 이동
	}
	
	@PostMapping(value = "/lctrOnlnInsert")
	public String lctrOnlnInsert(
	        @RequestParam(value = "lctr_num") Integer lctr_num, // 필수 파라미터
	        HttpServletRequest request,
	        HttpSession session,
	        Model model) {

	    // 세션에서 사용자 정보 가져오기
	    User_Table user = (User_Table) session.getAttribute("user"); // 올바른 키로 수정
	    if (user == null) {
	        // 세션에 사용자 정보가 없으면 적절한 처리를 수행 (예: 로그인 페이지로 리다이렉트)
	        return "redirect:/jh/loginForm"; // 예시
	    }
	    Date currentDate = new Date();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    String formattedDate = dateFormat.format(currentDate);
	    
	    Onln_Lctr_List onln_Lctr_List = new Onln_Lctr_List();
	    onln_Lctr_List.setLctr_num(Integer.parseInt(request.getParameter("lctr_num")));
	    onln_Lctr_List.setUnq_num(user.getUnq_num());
	    onln_Lctr_List.setAply_ymd(formattedDate);
	    onln_Lctr_List.setPtcp_type(Integer.parseInt(request.getParameter("ptcp_type")));
	    onln_Lctr_List.setPriority_type(Integer.parseInt(request.getParameter("priority_type")));
	    ss.lctrOnlnInsert(onln_Lctr_List);
	    
	    return "redirect:/se/onlnList"; // JSP 페이지로 이동
	}
	
	@GetMapping(value = "/hanPage")
	public String hanPage() {
		return "se/hanPage";
	}
	@GetMapping(value = "/lctrmethod")
	public String lctrmethod() {
		return "se/lctrmethod";
	}
	
	
}