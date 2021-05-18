package com.naver.peekaboo21.model.review.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentsDTO {
	private int cno;
	private int rno;
	private String commenttext;
	private String commenter;
	private String name;
	private Date regdate;
	private Date updatedate;
	private String writer;
}
