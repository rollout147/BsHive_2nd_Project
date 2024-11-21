package com.postGre.bsHive.Acontroller;


import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.postGre.bsHive.Adto.Hs_Assignment;
import com.postGre.bsHive.Adto.User_Table;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Pst;
import com.postGre.bsHive.JhService.JhService;
import com.postGre.bsHive.MhService.MhService;
import com.postGre.bsHive.MhService.Paging;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping(value="/mh")
public class MhController {
	@Value("${spring.file.upload.path}")
    private String UPLOAD_DIRECTORY;
	
	@Autowired
	private final MhService ms;
	@Autowired
	private final JhService js;
	
	@GetMapping("/gongList")
	public String GongGiList(Pst pst, Model model, HttpSession session) {
		int totalGongList = ms.totalGongList();
		Paging page = new Paging(totalGongList, pst.getCurrentPage());
		pst.setStart(page.getStart());
		pst.setEnd(page.getEnd());
		List<Pst> listGong = ms.listGong(pst);
		
		System.out.println("pst.listGong()->" +listGong);
	   
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
	    if (user_Table1 == null) {
	        System.out.println("사용자 정보가 없습니다. 로그인이 필요합니다.");
	        model.addAttribute("admin", 0);  // 기본값 할당 (관리자 아님)
	        model.addAttribute("writer", 0); // 기본값 할당 (작성자 번호 없음)
			model.addAttribute("totalGongList", totalGongList);
			model.addAttribute("listGong", listGong);
			model.addAttribute("page", page);
	        return "mh/gongList";
	    } else {
	        int admin = user_Table1.getMbr_se();
	        int writer = user_Table1.getUnq_num();
	        System.out.println("JwController writeFormOnlnLctr user_Table->" + user_Table1);
	        System.out.println("JwController writeFormOnlnLctr admin->" + admin);
			model.addAttribute("totalGongList", totalGongList);
			model.addAttribute("listGong", listGong);
			model.addAttribute("page", page);
	        model.addAttribute("admin", admin);
	        model.addAttribute("writer", writer);
	    }
		
		return "mh/gongList";
	}
	
	@GetMapping("/gongView")
	public String GongView(Pst pst, Model model, HttpSession session) {
		 List<Pst> GongView = ms.GongView(pst);

	        List<File> filePath = ms.filePath(pst.getFile_group());
	        System.out.println("pst->" +pst);
	        System.out.println("pst.getFile_group()->" +pst.getFile_group());
	        System.out.println("GongView->" +GongView);
			User_Table user_Table1 = (User_Table) session.getAttribute("user");

		    if (user_Table1 == null) {
		        System.out.println("사용자 정보가 없습니다. 로그인이 필요합니다.");
				model.addAttribute("writer", 0);
				 model.addAttribute("GongView",GongView);
				 model.addAttribute("filePath",filePath);
		        return "mh/gongView";
		    } else {
		        int admin = user_Table1.getMbr_se();
		        int writer = user_Table1.getUnq_num();
		        System.out.println("JwController writeFormOnlnLctr user_Table->" + user_Table1);
		        System.out.println("JwController writeFormOnlnLctr admin->" + admin);
				model.addAttribute("writer", writer);
				 model.addAttribute("GongView",GongView);
				 model.addAttribute("filePath",filePath);
		    }
			
			return "mh/gongView";
	}
	
	@GetMapping("/gongDelete")
	public String GongDelete(@RequestParam("pst_num") int pst_num) {
		int result = ms.GongDelete(pst_num);
		return "redirect:gongList";	
	}
	
	@GetMapping("/gongWrite")
	public String Gongwrite(Model model, HttpSession session) {
		User_Table user = (User_Table) session.getAttribute("user"); 
        if (user == null) { 
        	 return "redirect:/jh/loginForm";
        }
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
		int writer = user_Table1.getUnq_num();
		System.out.println("writer"+writer);
		model.addAttribute("writer", writer);
		

		return "mh/gongWrite";	
	}
	
	  @GetMapping("/download")
	    public ResponseEntity<Resource> downloadFile(@RequestParam("filePath") String filePath) {
	        System.out.println("HsController downloadFile Start...");
	        try {
	            System.out.println("HsController downloadFile filePath-> "+filePath);

	            // 'filePath'가 '/uploads/'로 시작하는 경우, 이를 무시하고 'static/uploads/' 경로에 포함
	            if (filePath.startsWith("/uploads/")) {
	                filePath = filePath.substring("/uploads/".length());  // /uploads/를 제거
	            }

	            // 앞에 static 경로를 붙여서 실제 파일 경로를 지정
	            Path fullPath = Paths.get("src/main/resources/static/uploads/").normalize().resolve(filePath);
	            System.out.println("fullPath-> "+fullPath);
	            // 실제 파일을 Resource로 변환
	            Resource resource = new UrlResource(fullPath.toUri());



	            // 파일이 존재하고 읽을 수 있으면 다운로드 처리
	            if (resource.exists() && resource.isReadable()) {
	                String originalFileName = filePath.substring(filePath.indexOf('_') + 1);  // UUID 이후의 파일명 추출
	                String fileName = URLEncoder.encode(originalFileName, "UTF-8").replaceAll("\\+", "%20");
	                System.out.println("HsController downloadFile End...");
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
		
	@RequestMapping("/gongModify")
	public String gongModify (Pst pst, Model model) {
		 List<Pst> GongView = ms.GongView(pst);
		 List<File> filePath = ms.filePath(pst.getFile_group());
		 System.out.println("filePath" +filePath);
		 
		 model.addAttribute("GongView",GongView);
		 model.addAttribute("filePath",filePath);
		return "mh/gongModify";
	}
	
	@PostMapping("/gongModifyDB")
	public String gongModifyDB (@RequestParam("file") List<MultipartFile> files, Pst pst, Model model, 
        HttpServletRequest request) {
		List<File> fileList = new ArrayList<>();
		
		 if (files != null) {
	            for (MultipartFile file : files) {
	                if (!file.isEmpty()) {
	                    try {
	                        String uuid = UUID.randomUUID().toString();
	                        String originalFileName = file.getOriginalFilename();
	                        int fileSize = (int) file.getSize();
	                        String uniqueFileName = uuid + "_" + originalFileName;
	                        Path filePath = Paths.get("src/main/resources/static/", UPLOAD_DIRECTORY, uniqueFileName).toAbsolutePath().normalize();
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
	                        System.out.println("fileList controller->" +fileList);



	                    } catch (IOException e) {
	                        e.printStackTrace();
	                    }
		
	                }
	            }
		 }
		
		int updateCount = ms.updateGong(pst, fileList);
		System.out.println("updateCount->" +updateCount);
		
		return "redirect:gongList";
	}
	
	@GetMapping("/yakList")
	public String yakGiList(Pst pst, Model model, HttpSession session) {
		int totalYakList = ms.totalYakList();
		Paging page = new Paging(totalYakList, pst.getCurrentPage());
		pst.setStart(page.getStart());
		pst.setEnd(page.getEnd());
		List<Pst> listYak = ms.listYak(pst);
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
		
		
	    if (user_Table1 == null) {
	    	model.addAttribute("totalYakList", totalYakList);
			model.addAttribute("listYak", listYak);
			model.addAttribute("page", page);
			model.addAttribute("admin", 0);
	        return "mh/yakList";
	    } else {
	    	int admin = user_Table1.getMbr_se();
	    	model.addAttribute("totalYakList", totalYakList);
			model.addAttribute("listYak", listYak);
			model.addAttribute("page", page);
			model.addAttribute("admin", admin);
	    }
	
		return "mh/yakList";
	}
	
	@GetMapping("/yakView")
	public String yakView(Pst pst, Model model, HttpSession session) {
		 List<Pst> yakView = ms.yakView(pst);
			User_Table user_Table1 = (User_Table) session.getAttribute("user");
		    if (user_Table1 == null) {
		        System.out.println("사용자 정보가 없습니다. 로그인이 필요합니다.");
				model.addAttribute("writer", 0);
				 model.addAttribute("yakView", yakView);
		        return "mh/yakView";
		    } else {
		        int admin = user_Table1.getMbr_se();
				int writer = user_Table1.getUnq_num();
		        System.out.println("JwController writeFormOnlnLctr user_Table->" + user_Table1);
		        System.out.println("JwController writeFormOnlnLctr admin->" + admin);
				model.addAttribute("writer", writer);
				 model.addAttribute("yakView", yakView);
		    }
			
			return "mh/yakView";

	}
	@GetMapping("/yakWrite")
	public String yakwrite(Model model, HttpSession session) {
		User_Table user = (User_Table) session.getAttribute("user"); 
        if (user == null) { 
        	 return "redirect:/jh/loginForm";
        }
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
		int writer = user_Table1.getUnq_num();
		System.out.println("writer"+writer);
		model.addAttribute("writer", writer);
		
		return "mh/yakWrite";	
	}
	
	@PostMapping("/yakInsert")
	public String yakInsert (Pst pst, Model model, @RequestParam("writer") int writer) {
	    pst.setUnq_num(writer);
	    int insertResult = ms.yakInsert(pst); 
	    return "redirect:yakList"; // 업로드 후 목록 페이지로 이동
	}
	
	@GetMapping("/yakModify")
	public String yakModify (Pst pst, Model model) {
		 List<Pst> yakView = ms.yakView(pst);
		 
		 model.addAttribute("yakView",yakView);
		return "mh/yakModify";
	}
	
	@PostMapping("/yakModifyDB")
	public String yakModifyDB (Pst pst) {
		int updateCount = ms.updateYak(pst);
		return "redirect:yakList";
	}
	
	@GetMapping("/yakDelete")
	public String yakDelete(@RequestParam("pst_num") int pst_num) {
		int result = ms.yakDelete(pst_num);
		return "redirect:yakList";	
	}
	
	@GetMapping("/fnqList")
	public String faqList(Pst pst, Model model, HttpSession session) {
		int totalFaqList = ms.totalFaqList();
		Paging page = new Paging(totalFaqList, pst.getCurrentPage());
		pst.setStart(page.getStart());
		pst.setEnd(page.getEnd());
		List<Pst> listFaq = ms.listFaq(pst);

		User_Table user_Table1 = (User_Table) session.getAttribute("user");
	    if (user_Table1 == null) {
	    	model.addAttribute("totalFaqList", totalFaqList);
			model.addAttribute("listFaq", listFaq);
			model.addAttribute("page", page);
			model.addAttribute("admin", 0);
	        return "mh/fnqList";
	    } else {
	        int admin = user_Table1.getMbr_se();
	        model.addAttribute("totalFaqList", totalFaqList);
			model.addAttribute("listFaq", listFaq);
			model.addAttribute("page", page);
			model.addAttribute("admin", admin);
	    }
		
		return "mh/fnqList";
	}
	
	@GetMapping("/fnqView")
	public String fnqView(Pst pst, Model model, HttpSession session) {
		 System.out.println("fnqView controller pst->" + pst);
		
		 List<Pst> fnqView = ms.fnqView(pst);
			
			User_Table user_Table1 = (User_Table) session.getAttribute("user");
		    if (user_Table1 == null) {
		        System.out.println("사용자 정보가 없습니다. 로그인이 필요합니다.");
				model.addAttribute("writer", 0);
			 model.addAttribute("fnqView",fnqView);
		        return "mh/fnqView";
		    } else {
		        int admin = user_Table1.getMbr_se();
				int writer = user_Table1.getUnq_num();
		        System.out.println("JwController writeFormOnlnLctr user_Table->" + user_Table1);
		        System.out.println("JwController writeFormOnlnLctr admin->" + admin);
				model.addAttribute("writer", writer);
			 model.addAttribute("fnqView",fnqView);
		    }
			
			return "mh/fnqView";

	}
	@GetMapping("/fnqWrite")
	public String faqwrite(Model model, HttpSession session) {
		User_Table user = (User_Table) session.getAttribute("user"); 
        if (user == null) { 
        	 return "redirect:/jh/loginForm";
        }
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
		int writer = user_Table1.getUnq_num();
		System.out.println("writer"+writer);
		model.addAttribute("writer", writer);
		
		return "mh/fnqWrite";	
	}
	
	@PostMapping("/faqInsert")
	public String faqInsert (Pst pst, Model model, @RequestParam("writer") int writer) {
	    pst.setUnq_num(writer);
	    System.out.println("pst controller"+pst);
	    int insertResult = ms.faqInsert(pst); 
	   
	    return "redirect:fnqList"; // 업로드 후 목록 페이지로 이동
	}
	
	@GetMapping("/faqDelete")
	public String faqDelete(@RequestParam("pst_num") int pst_num) {
		int result = ms.faqDelete(pst_num);
		return "redirect:fnqList";	
	}
	
	@GetMapping("/fnqModify")
	public String fnqModify (Pst pst, Model model) {
		 List<Pst> fnqView = ms.fnqView(pst);
		 
		 model.addAttribute("fnqView",fnqView);
		return "mh/fnqModify";
	}
	
	@PostMapping("/faqModifyDB")
	public String faqModifyDB (Pst pst) {
		int updateCount = ms.updatefaq(pst);
		return "redirect:fnqList";
	}
	
	@GetMapping("/oneList")
	public String oneList(Pst pst, Model model, HttpSession session) {
		
		User_Table user_Table1 = (User_Table) session.getAttribute("user"); 
        if (user_Table1 == null) { 
       	 return "redirect:/jh/loginForm";
       }
		int admin = user_Table1.getMbr_se();
		int writer = user_Table1.getUnq_num();
		pst.setUnq_num(writer);
		System.out.println(pst.getUnq_num());
		
		if(admin == 3) {
			int totaloneList = ms.totaloneList();
			System.out.println("totaloneList->" +totaloneList);
			Paging page = new Paging(totaloneList, pst.getCurrentPage());
			pst.setStart(page.getStart());
			pst.setEnd(page.getEnd());
			
			List<Pst> listOne = ms.listOne(pst);


	        model.addAttribute("totaloneList", totaloneList);
			model.addAttribute("listOne", listOne);
			model.addAttribute("page", page);
			model.addAttribute("admin", admin);
			model.addAttribute("writer", writer);
			
		}
		else {
			int totaloneList = ms.totaloneList1();
			System.out.println("totaloneList->" +totaloneList);
			Paging page = new Paging(totaloneList, pst.getCurrentPage());
			pst.setStart(page.getStart());
			pst.setEnd(page.getEnd());
			
			List<Pst> listOne = ms.listOne1(pst);
			User_Table user = (User_Table) session.getAttribute("user"); 
	        if (user == null) { 
	        	 return "redirect:/jh/loginForm";
	        }
	        model.addAttribute("totaloneList", totaloneList);
			model.addAttribute("listOne", listOne);
			model.addAttribute("page", page);
			model.addAttribute("admin", admin);
			model.addAttribute("writer", writer);
			
		} {
			
			
		}
		
		return "mh/oneList";
	}
	

	@GetMapping("/oneView")
	public String oneView(Pst pst, Model model, HttpSession session) {
		
		 List<Pst> oneView = ms.oneView(pst);
		 User_Table user = (User_Table) session.getAttribute("user"); 
	        if (user == null) { 
	        	 return "redirect:/jh/loginForm";
	        }
			User_Table user_Table1 = (User_Table) session.getAttribute("user");
			int writer = user_Table1.getUnq_num();
			int admin = user_Table1.getMbr_se();
			model.addAttribute("writer", writer);
			model.addAttribute("oneView",oneView);
			model.addAttribute("admin",admin);
		
		return "mh/oneView";
	}
	
	@GetMapping("/oneDelete")
	public String oneDelete(@RequestParam("pst_num") int pst_num) {
		int result = ms.oneDelete(pst_num);
		return "redirect:oneList";	
	}
	
	@GetMapping("/oneWrite")
	public String onewrite(Model model, HttpSession session) {
		User_Table user = (User_Table) session.getAttribute("user"); 
        if (user == null) { 
        	 return "redirect:/jh/loginForm";
        }
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
		int writer = user_Table1.getUnq_num();
		System.out.println("writer"+writer);
		model.addAttribute("writer", writer);
		return "mh/oneWrite";	
	}
	
	@PostMapping("/oneInsert")
	public String oneInsert(@RequestParam("writer") int writer,Pst pst, Model model)  {
	    pst.setUnq_num(writer);
	    int insertResult = ms.oneInsert(pst); 
	    

	    return "redirect:oneList"; // 업로드 후 목록 페이지로 이동
	}
	
	
	@GetMapping("/oneModify")
	public String oneModify (Pst pst, Model model) {
		 List<Pst> oneView = ms.oneView(pst);
		 
		 model.addAttribute("oneView",oneView);
		return "mh/oneModify";
	}
	
	@PostMapping("/oneModifyDB")
	public String oneModifyDB (Pst pst) {
		int updateCount = ms.updateone(pst);
		System.out.println("updateCount->" +updateCount);
		return "redirect:oneList";
	}
	
	
	@PostMapping("/gongInsert")
    public String gongInsert(@RequestParam("file") List<MultipartFile> files, Pst pst, Model model, 
            @RequestParam("writer") int writer, HttpServletRequest request) {


        List<File> fileList = new ArrayList<>();
        if (files != null) {
            for (MultipartFile file : files) {
                if (!file.isEmpty()) {
                    try {
                        String uuid = UUID.randomUUID().toString();
                        String originalFileName = file.getOriginalFilename();
                        int fileSize = (int) file.getSize();
                        String uniqueFileName = uuid + "_" + originalFileName;
                        Path filePath = Paths.get("src/main/resources/static/", UPLOAD_DIRECTORY, uniqueFileName).toAbsolutePath().normalize();
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
                        System.out.println("fileList controller->" +fileList);



                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            System.out.println("파일이 없습니다.");

        }
        pst.setUnq_num(writer);
        int noticeCreate = ms.noticeCreate(pst, fileList) ;
        return "redirect:/mh/gongList";
    }
	
	@GetMapping("/answrWrite")
	public String answrWrite (Model model, HttpSession session, Pst pst) {
		User_Table user = (User_Table) session.getAttribute("user"); 
        if (user == null) { 
        	 return "redirect:/jh/loginForm";
        }
		User_Table user_Table1 = (User_Table) session.getAttribute("user");
		int writer = user_Table1.getUnq_num();
		 List<Pst> oneView = ms.oneView(pst);
		System.out.println("writer"+writer);
		model.addAttribute("writer", writer);
		model.addAttribute("oneView", oneView);
		return "mh/answrWrite";
	}
	
	@PostMapping("/answrInsert")
	public String answrInsert(Pst pst, Model model, @RequestParam("writer") int writer, @RequestParam("pst_num") int pst_num) {
		pst.setUnq_num(writer);
		pst.setPst_num(pst_num);
		System.out.println(pst);
		int updateCount = ms.updateAnswr(pst);
		return "redirect:oneList";
	}
	
	
    @ResponseBody
    @PostMapping(value = "/deleteUpdFile")
    public ResponseEntity<?> deleteFile(@RequestBody Hs_Assignment assign) {
        System.out.println("HsController deleteFile ajax Start...");
        System.out.println("HsController deleteFile ajax assign-> "+assign);
        try {
            // update form에서 파일 삭제 ajax
            int isDeleted = ms.deleteFile(assign);

            // 삭제 성공 시
            if (isDeleted > 0) {
                System.out.println("HsController deleteFile ajax END...");
                return ResponseEntity.ok(null);  // 성공 메시지와 함께 반환
            } else {
                // 삭제 실패 시
                return ResponseEntity.status(400).body(null);  // 실패 메시지와 함께 반환
            }
        } catch (Exception e) {
            // 예외 발생 시
            return ResponseEntity.status(500).body(null);  // 서버 오류 메시지와 함께 반환
        }
    }
	
}
