package com.spring.blog.service;

import com.spring.blog.mapper.UserMapper;
import com.spring.blog.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public List<UserVO> getUserList() {
        return userMapper.getUserList();
    }

    public UserVO getUserById(String id) {
        return userMapper.getUserById(id);
    }



    public void signup(UserVO userVo) { // 회원 가입

            userVo.setPassword(passwordEncoder.encode(userVo.getPassword()));
            userMapper.insertUser(userVo);

    }

    public void edit(UserVO userVo) { // 회원 정보 수정
        // password는 암호화해서 DB에 저장
        userVo.setPassword(passwordEncoder.encode(userVo.getPassword()));
        userMapper.updateUser(userVo);
    }

    public void withdraw(String id) { // 회원 탈퇴
        userMapper.deleteUser(id);
    }

    public PasswordEncoder passwordEncoder() {
        return this.passwordEncoder;
    }
}