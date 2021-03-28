package com.naver.peekaboo21.service.member;

import javax.servlet.http.HttpSession;

import com.naver.peekaboo21.model.member.dto.MemberDTO;

public interface MemberService {
	public String loginCheck(MemberDTO dto, HttpSession session);
	public void logout(HttpSession session);
	public void insert(MemberDTO dto);
}
