package com.spring.blog.service;


import com.spring.blog.mapper.LoanMapper;
import com.spring.blog.vo.LoanBook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoanService {
    LoanMapper loanMapper;

    @Autowired
    public LoanService(LoanMapper loanMapper) {
        this.loanMapper=loanMapper;
    }

    // 대출 도서 목록 가져오기
    public List<LoanBook> getLoanList(String id) {
        return loanMapper.findById(id);
    }

    // 대출 저장 하기 insert
    // 해당 도서 대출 상태 변경 update
    public void saveLoan(String id, int book_num, String book_name, String author) {
        loanMapper.save(id, book_num,book_name,author);
    }
}
