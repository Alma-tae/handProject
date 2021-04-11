package com.naver.peekaboo21.controller.upload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ImageUploadController {
	@RequestMapping("imageUpload.do")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8"); // 캐릭터셋 설정
		response.setContentType("text/html;charset=utf-8"); // 컨텐트 타입
		OutputStream out = null;
		PrintWriter printWriter = null;
		String fileName = upload.getOriginalFilename(); // 첨부파일 이름
		byte[] bytes = upload.getBytes(); // 바이트 배열로 변환
		ServletContext application = request.getSession().getServletContext();
		String uploadPath = application.getRealPath("/WEB-INF/views/images/"); // 배포 경로
		out = new FileOutputStream(new File(uploadPath + fileName));
		out.write(bytes); // 배포경로에 파일 저장
		printWriter = response.getWriter(); // 클라이언트에 출력하기 위한 객체
		String fileUrl = request.getContextPath() + "/images/" + fileName;
		//json 형식{"key" : "value"}으로 메시지 출력
		printWriter.println("{\"filename\" : \"" + fileName + "\", \"uploaded\" : 1, \"url\":\"" + fileUrl + "\"}");
		printWriter.flush();
	}
}
