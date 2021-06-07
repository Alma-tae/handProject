package com.naver.peekaboo21.model.member.dao;

import com.naver.peekaboo21.model.member.dto.MemberDTO;

public interface MemberDAO {
	public String loginCheck(MemberDTO dto);

	public void insert(MemberDTO dto);
	
	public int emailCheck(MemberDTO dto);
}
