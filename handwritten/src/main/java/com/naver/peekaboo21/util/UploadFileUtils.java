package com.naver.peekaboo21.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils { 
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		UUID uid = UUID.randomUUID(); //uuid(중복되지 않도록 만드어줌)
		String savedName = uid.toString() + "_" + originalName;
		String savedPath = calcPath(uploadPath); //파일을 업로드 할 디렉토리 경로
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target); //디렉토리에 파일을 복사
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1); //확장자
		String uploadedFileName = null;
		if (MediaUtils.getMediaType(formatName) != null) { //이미지 파일이면
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName); //썸네일 생성
		} else { //이미지가 아니면 썸네일을 만들지 않음
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		return uploadedFileName;
	}

	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		String iconName = uploadPath + path + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	private static String makeThumbnail(String uploadPath, String path, String fileName) throws Exception {
		//이미지를 읽어서 버퍼에 저장
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + path, fileName));
		//이미지 사이즈
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		//썸네일의 이름
		String thumbnailName = uploadPath + path + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		//썸네일 생성
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance(); //캘린더 인스턴스
		//디렉토리 구분자(separator) : windows \,  linux /
		String yearPath = File.separator + cal.get(Calendar.YEAR); //년 형식
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1); //월 형식
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE)); //일자 형식
		makeDir(uploadPath, yearPath, monthPath, datePath); //디렉토리 생성
		System.out.println(datePath);
		return datePath;
	}

	private static void makeDir(String uploadPath, String... paths) { //가변사이즈 매개변수 처리(...)
		if (new File(paths[paths.length - 1]).exists()) { //이미 디렉토리가 존재하면
			return; //종료
		}
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			if (!dirPath.exists()) { //디렉토리가 존재하지 않으면
				dirPath.mkdir(); //디렉토리 생성
			}
		}
	}
}
