package com.spring.blog.mapper;

import com.spring.blog.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {
    List<UserVO> getUserList(); // User 테이블 가져오기
    void insertUser(UserVO userVo); // 회원 가입
    UserVO getUserById(String id); //유저 정보 가져오기
    void updateUser(UserVO userVo); // 회원 정보 수정
    void deleteUser(String id); // 회원 탈퇴
}