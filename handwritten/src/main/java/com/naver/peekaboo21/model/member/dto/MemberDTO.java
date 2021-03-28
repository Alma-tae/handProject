package com.naver.peekaboo21.model.member.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	private String email;
	private String name;
	private String pwd;
	private Date join_date;
}
