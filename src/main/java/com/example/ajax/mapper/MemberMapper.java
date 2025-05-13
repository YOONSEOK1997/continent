package com.example.ajax.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.ajax.dto.Member; 
@Mapper
public interface MemberMapper {
	//ID 중복검사
	String selectMemberId(String id);
	//회원가입
	int insertMember(Member member);
}
