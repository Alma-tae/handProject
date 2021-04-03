package com.naver.peekaboo21.model.admin;

import com.naver.peekaboo21.model.member.dto.MemberDTO;

public interface AdminDAO {
	public String loginCheck(MemberDTO dto);
}
