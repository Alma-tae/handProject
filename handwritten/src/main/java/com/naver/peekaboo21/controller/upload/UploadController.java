package com.naver.peekaboo21.controller.upload;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UploadController {

	@Resource(name="uploadPath") //servlet-context.xml에 정의한 bean
	String uploadPath;
	//get 방식으로 요청한 경우(void도 가능한데 파일명 가독성이 떨어짐)
	@RequestMapping(value="/upload/uploadForm", method=RequestMethod.GET)
	public String uploadForm() {
		return "upload/uploadForm";
	}
	//post 방식으로 요청한 경우
	@RequestMapping(value="/upload/uploadForm", method=RequestMethod.POST)
	public ModelAndView uploadForm(MultipartFile file, ModelAndView mav) throws Exception {
		String savedName=file.getOriginalFilename(); //첨부파일의 이름
		savedName=uploadFile(savedName, file.getBytes()); 
		mav.setViewName("upload/uploadResult"); //출력 페이지의 이름
		mav.addObject("savedName", savedName); //데이터 저장
		return mav;
	}
	
	private String uploadFile(String originalName, byte[] fileData) throws Exception{
		//UUID(Universal Unique Identifier, 범용 고유 식별자)
		UUID uid = UUID.randomUUID(); //중복되지 않는 식별자 발급
		String savedName=uid.toString()+"_"+originalName;
		File target=new File(uploadPath, savedName);
		FileCopyUtils.copy(fileData, target);//파일 복사
		return savedName;		
	}
}
