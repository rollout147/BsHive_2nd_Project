package com.postGre.bsHive.MhDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.postGre.bsHive.Adto.Hs_Assignment;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Pst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MhDaoImp implements MhDao {
	
	@Autowired
	private final SqlSession session;
	
	@Override
	public int totalGongList() {
		int totalGongList = 0;
		try {
			totalGongList = session.selectOne("com.postGre.bsHive.MhDao.totalGongList");
		} catch (Exception e) {
			System.out.println("totalGongList: " +e);
		}
		return totalGongList;
	}

	@Override
	public List<Pst> listGong(Pst pst) {
		List<Pst> listGong = null;
		try {
			listGong = session.selectList("com.postGre.bsHive.MhDao.listGong", pst);
		} catch (Exception e) {
			System.out.println("listGong: " +e);
		}
		
		return listGong;
	}

	@Override
	public List<Pst> GongView(Pst pst) {
		List<Pst> GongView = null;
		try {
			GongView = session.selectList("com.postGre.bsHive.MhDao.GongView", pst);
		} catch (Exception e) {
			System.out.println("GongView" + e.getMessage());
		}
		
		return GongView;
	}

	@Override
	public int GongDelete(int pst_num) {
		int GongDelete = 0;
		try {
			GongDelete = session.update("com.postGre.bsHive.MhDao.GongDelete", pst_num);
		} catch (Exception e) {
		}
		return GongDelete;
	}

	@Override
	public int gongInsert(Pst pst) {
		int gongInsert = 0;
		try {
			gongInsert = session.insert("com.postGre.bsHive.MhDao.gongInsert", pst);
		} catch (Exception e) {
			System.out.println("gongInsert error" + e);
		}
		return gongInsert;
	}

	@Override
	public int updateGong(Pst pst, List<File> fileList) {
		int updateGong = 0;
		try {
			
			
			   System.out.println("hsAss.getFile_group()-> "+pst.getFile_group());
	            // 1. 파일 그룹 ID 확인: 만약 file_group이 null이면 새로 생성
	            if (pst.getFile_group() == 0) {
	                // file_group이 null인 경우 새로운 file_group 생성
	                int fileGroupId = createNewFileGroupId();  // 새 file_group 생성
	                pst.setFile_group(fileGroupId);           // 과제에 file_group 설정
	                System.out.println("HsDaoImpl asmtSbmsnUpdate 새로운 fileGroupId 생성 -> " + fileGroupId);
	            } else {
	                System.out.println("HsDaoImpl asmtSbmsnUpdate 기존 file_group -> " + pst.getFile_group());
	            }
	            updateGong = session.update("com.postGre.bsHive.MhDao.updateGong", pst);
	            // 3. 파일 정보가 있다면 저장
	            if (fileList != null && !fileList.isEmpty()) {
	                for (File fileUpload : fileList) {
	                    // Filegroup 객체를 순회
	                    int fileGroupId = pst.getFile_group();
	                    int fileSeq = createNewFileSeq(pst.getFile_group());
	                    fileUpload.setFile_group(fileGroupId);    //파일 그룹 ID 설정
	                    fileUpload.setFile_no(fileSeq);            //파일 시퀀스 저장

	                    System.out.println("HsDaoImpl asmtSbmsnUpdate fileUpload-> "+fileUpload);

	                    // 4. 첨부파일 TABLE에 저장
	                    int fileResult = session.insert("com.postGre.bsHive.MhDao.FileUpload", fileUpload);
	                    System.out.println("HsDaoImpl asmtSbmsnUpdate fileResult-> "+fileResult);

	                    //파일 업로드 실패 시
	                    if (fileResult <= 0) {
	                        System.out.println("HsDaoImpl asmtSbmsnUpdate 업로드 실패");
	                        
	                    }
	                }
	            }
	            
			
			
			
		} catch (Exception e) {
			System.out.println("updateGong : " + e);
		}
		return updateGong;
	}

	@Override
	public int totalYakList() {
		int totalYakList = 0;
		try {
			totalYakList = session.selectOne("com.postGre.bsHive.MhDao.totalYakList");
		} catch (Exception e) {
		}
		return totalYakList;
	}

	@Override
	public List<Pst> listYak(Pst pst) {
		List<Pst> listYak = null;
		try {
			listYak = session.selectList("com.postGre.bsHive.MhDao.listYak", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return listYak;
	}

	@Override
	public List<Pst> yakView(Pst pst) {
		List<Pst> yakView = null;
		try {
			yakView = session.selectList("com.postGre.bsHive.MhDao.yakView", pst);
		} catch (Exception e) {
		}
		return yakView;
	}

	@Override
	public int yakInsert(Pst pst) {
		int yakInsert =0;
		try {
			yakInsert = session.insert("com.postGre.bsHive.MhDao.yakInsert", pst);
		} catch (Exception e) {
		}
		return yakInsert;
	}

	@Override
	public int updateYak(Pst pst) {
		int updateYak = 0;
		try {
			updateYak = session.update("com.postGre.bsHive.MhDao.updateYak", pst);
		} catch (Exception e) {
		}
		return updateYak;
	}

	@Override
	public int yakDelete(int pst_num) {
		int yakDelete = 0;
		try {
			yakDelete = session.update("com.postGre.bsHive.MhDao.yakDelete", pst_num);
		} catch (Exception e) {
		}
		return yakDelete;
	}

	@Override
	public List<Pst> listFaq(Pst pst) {
		List<Pst> listFaq = null;
		try {
			listFaq = session.selectList("com.postGre.bsHive.MhDao.listFaq", pst);
		} catch (Exception e) {
			System.out.println(e);
		}System.out.println("MhDaoImp pst->" +pst);
		return listFaq;
	}

	@Override
	public int totalFaqList() {
		int totalFaqList = 0;
		try {
			totalFaqList = session.selectOne("com.postGre.bsHive.MhDao.totalFaqList", totalFaqList);
		} catch (Exception e) {
			
		}
		
		return totalFaqList;
	}

	@Override
	public List<Pst> fnqView(Pst pst) {
		List<Pst> fnqView = null;
		System.out.println("dao" +pst.getPst_num());
		try {
			fnqView = session.selectList("com.postGre.bsHive.MhDao.fnqView", pst);
			System.out.println("fnqView dao:" +fnqView);

		} catch (Exception e) {
			System.out.println(e);
		}
		return fnqView;
	}

	@Override
	public int faqInsert(Pst pst) {
		int faqInsert = 0;
		try {
			faqInsert = session.insert("com.postGre.bsHive.MhDao.faqInsert",pst);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return faqInsert;
	}

	@Override
	public int faqDelete(int pst_num) {
		int faqDelete = 0;
		try {
			faqDelete = session.update("com.postGre.bsHive.MhDao.faqDelete", pst_num);
		} catch (Exception e) {
		}
		return faqDelete;
	}

	@Override
	public int updatefaq(Pst pst) {
		int updatefaq = 0;
		try {
			updatefaq = session.update("com.postGre.bsHive.MhDao.updatefaq", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return updatefaq;
	}

	@Override
	public int totaloneList() {
		int totaloneList = 0;
		try {
			totaloneList = session.selectOne("com.postGre.bsHive.MhDao.totaloneList");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totaloneList;
	}

	@Override
	public List<Pst> listOne(Pst pst) {
		List<Pst> listOne = null;
		System.out.println("pst daoimp->" +pst);
		try {
			listOne = session.selectList("com.postGre.bsHive.MhDao.listOne", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return listOne;
	}

	@Override
	public List<Pst> oneView(Pst pst) {
		List<Pst> oneView = null;
		try {
			oneView = session.selectList("com.postGre.bsHive.MhDao.oneView", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return oneView;
	}

	@Override
	public int oneDelete(int pst_num) {
		int oneDelete = 0;
		try {
			oneDelete = session.update("com.postGre.bsHive.MhDao.oneDelete", pst_num);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return oneDelete;
	}

	@Override
	public int oneInsert(Pst pst) {
		int oneInsert =0;
		try {
			oneInsert = session.insert("com.postGre.bsHive.MhDao.oneInsert", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return oneInsert;
	}

	@Override
	public int updateone(Pst pst) {
		int updateone = 0;
		try {
			updateone = session.update("com.postGre.bsHive.MhDao.updateone", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return updateone;
	}

	@Override
    public int noticeCreate(Pst pst, List<File> fileList) {
        System.out.println("공지사항 작성");
        System.out.println("fileList ->" +fileList);

        // 파일 그룹 ID 생성
        int fileGroupId = createNewFileGroupId();
        System.out.println("fileGroupId->" +fileGroupId);
        // 공지사항 먼저 저장

        // 파일 정보가 있다면 저장
        if (fileList != null && !fileList.isEmpty()) {
        	
            for (File fileUpload : fileList) { // Filegroup 객체를 순회
            	int fileSeq = createNewFileSeq(fileGroupId);
                fileUpload.setFile_group(fileGroupId); // 파일 그룹 ID 설정
                fileUpload.setFile_no(fileSeq); // 파일 시퀀스 설정
                System.out.println("filegroup ------ > " + fileUpload);
                int fileResult = session.insert("com.postGre.bsHive.MhDao.FileUpload", fileUpload);
                System.out.println("파일 업로드 임 ㅋ");
             
                if (fileResult <= 0) {
                    // 파일 업로드 실패 처리
                    System.out.println("파일 업로드 실패");
                }
            }
        } 
        
        pst.setFile_group(fileGroupId);
        int result = session.insert("com.postGre.bsHive.MhDao.noticeCreate", pst);


        System.out.println("공지사항 업로드 result ---> " + result);
        return result;

    }

	private int createNewFileGroupId() {
	  int createNewFileGroupId = session.selectOne("com.postGre.bsHive.MhDao.getNextFileGroupId"); // 새로운 파일 그룹 ID 생성
	  System.out.println("createNewFileGroupId ->" +createNewFileGroupId);
	  return createNewFileGroupId;
	
	}

	private int createNewFileSeq(int fileGroupId) {
	    // file_seq는 파일 그룹에 대해 최대값을 가져오는 방법
	    Integer maxFileSeq = session.selectOne("com.postGre.bsHive.MhDao.getMaxFileSeq", fileGroupId);
	    System.out.println("maxFileSeq->" +maxFileSeq);
	    return (maxFileSeq == null) ? 1 : maxFileSeq + 1; // maxFileSeq가 null이면 1을 반환
	}

	@Override
	public List<File> getFilesByGroup(int file_group) {
		List<File> getFilesByGroup = null;
		try {
			getFilesByGroup = session.selectList("com.postGre.bsHive.MhDao.getFilesByGroup", file_group);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return getFilesByGroup;
	}

	@Override
	public File getFile(int fileGroup, int fileSeq) {
	    File getFile = null;
	    try {
	        // 두 개의 파라미터를 Map으로 묶어서 전달
	        Map<String, Integer> params = new HashMap<>();
	        params.put("fileGroup", fileGroup);
	        params.put("fileSeq", fileSeq);

	        // selectOne을 사용하여 단일 결과 가져오기
	        getFile = session.selectOne("com.postGre.bsHive.MhDao.getFile", params);
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 발생 시 로그 출력
	    }
	    return getFile; // 조회 결과 반환
	}

	@Override
	public List<File> filePath(int file_group) {
		List<File> filePath = null;
		try {
			filePath = session.selectList("com.postGre.bsHive.MhDao.filePath", file_group);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return filePath;
	}

	@Override
	public List<Pst> listOne1(Pst pst) {
		List<Pst> listOne1 = null;
		try {
			listOne1 = session.selectList("com.postGre.bsHive.MhDao.listOne1", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return listOne1;
	}

	@Override
	public int totaloneList1() {
		int totaloneList1 = 0;
		try {
			totaloneList1 = session.selectOne("com.postGre.bsHive.MhDao.totaloneList1");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return totaloneList1;
	}

	@Override
	public int updateAnswr(Pst pst) {
		int updateAnswr = 0;
		try {
			updateAnswr = session.update("com.postGre.bsHive.MhDao.updateAnswr", pst);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return updateAnswr;
	}

	@Override
	public int deleteFile(Hs_Assignment assign) {
		int deleteFile = 0;
		try {
			deleteFile = session.delete("com.postGre.bsHive.MhDao.deleteFile", assign);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return deleteFile;
	}



}
