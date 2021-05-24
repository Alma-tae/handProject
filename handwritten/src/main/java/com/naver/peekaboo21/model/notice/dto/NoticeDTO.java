package com.naver.peekaboo21.model.notice.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeDTO {
	private int nno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private int viewcnt;
	private String name;
	private int cnt;
	private String show;
	private String[] files;

}
