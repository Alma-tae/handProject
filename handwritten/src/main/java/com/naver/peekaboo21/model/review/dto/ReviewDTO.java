package com.naver.peekaboo21.model.review.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {
	private int rno;
	private String title;
	private String content;
	private String email;
	private Date regdate;
	private int viewcnt;
	private String name;
	private int cnt;
	private String show;
	private String[] files;
	private String writer;
	private String image_url;
	private MultipartFile file;
}
