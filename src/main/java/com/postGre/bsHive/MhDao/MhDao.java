package com.postGre.bsHive.MhDao;

import java.util.List;

import com.postGre.bsHive.Adto.Hs_Assignment;
import com.postGre.bsHive.Amodel.File;
import com.postGre.bsHive.Amodel.Pst;

public interface MhDao {

	int totalGongList();

	List<Pst> listGong(Pst pst);

	List<Pst> GongView(Pst pst);

	int GongDelete(int pst_num);

	int gongInsert(Pst pst);

	int updateGong(Pst pst, List<File> fileList);

	int totalYakList();

	List<Pst> listYak(Pst pst);

	List<Pst> yakView(Pst pst);

	int yakInsert(Pst pst);

	int updateYak(Pst pst);

	int yakDelete(int pst_num);

	List<Pst> listFaq(Pst pst);

	int totalFaqList();

	List<Pst> fnqView(Pst pst);

	int faqInsert(Pst pst);

	int faqDelete(int pst_num);

	int updatefaq(Pst pst);

	int totaloneList();

	List<Pst> listOne(Pst pst);

	List<Pst> oneView(Pst pst);

	int oneDelete(int pst_num);

	int oneInsert(Pst pst);

	int updateone(Pst pst);

	int noticeCreate(Pst pst, List<File> fileList);

	List<File> getFilesByGroup(int file_group);

	File getFile(int fileGroup, int fileSeq);

	List<File> filePath(int file_group);

	List<Pst> listOne1(Pst pst);

	int totaloneList1();

	int updateAnswr(Pst pst);

	int deleteFile(Hs_Assignment assign);


}
