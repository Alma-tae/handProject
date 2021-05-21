package com.naver.peekaboo21.controller.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.naver.peekaboo21.service.notice.NoticeService;
import com.naver.peekaboo21.util.MediaUtils;
import com.naver.peekaboo21.util.UploadFileUtils;

@Controller
public class AjaxUploadController {
	@Resource(name="uploadPath")
	String uploadPath; //파일 업로드 디렉토리
	
	@RequestMapping(value="/upload/uploadAjax", method=RequestMethod.GET)
	public String uploadAjax() {
		return "/upload/uploadAjax"; //업로드 페이지로 이동
	}
	
	@RequestMapping(value="/upload/uploadAjax", method=RequestMethod.POST,
			produces = "text/plain;charset=utf-8")
	
	@ResponseBody //json
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception{
		//파일 업로드 처리
		System.out.println("originalname:" + file.getOriginalFilename());
		System.out.println("size:"+file.getSize());
		System.out.println("contentType:"+file.getContentType());
		return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
	}
	
	@ResponseBody //json 형식으로 리턴
	@RequestMapping("/upload/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1); //확장자
			MediaType mType = MediaUtils.getMediaType(formatName); //파일의 종류
			HttpHeaders headers = new HttpHeaders(); //header
			in = new FileInputStream(uploadPath + fileName);
			if(mType != null) { //이미지 파일인 경우
				headers.setContentType(mType); //컨텐트 타입 지정
			}else { //이미지 파일이 아니면
				fileName = fileName.substring(fileName.indexOf("_")+1); //uuid를 제외한 파일 이름
				//범용 컨텐트 타입인 octet stream으로 선언
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				//파일 이름을 서유럽 언어 형식으로 바꾸는 것
				fileName = new String(fileName.getBytes("utf-8"),"iso-8859-1");
				//헤더에 파일 정보 추가
				headers.add("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if (in != null)
				in.close();
		}
		System.out.println("displayFile:"+entity);
		return entity;
	}
	@Inject
	NoticeService noticeService;
	
	@ResponseBody
	@RequestMapping(value = "/upload/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		MediaType mType = MediaUtils.getMediaType(formatName);
		if (mType != null) { //이미지 파일이면 썸네일 파일 삭제
			String front = fileName.substring(0, 12);
			String end = fileName.substring(14);
			new File(uploadPath + (front + end).replace('/', File.separatorChar)).delete();
		}
		//파일 삭제
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
		//레코드 삭제
		/* noticeService.deleteFile(fileName); */
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
