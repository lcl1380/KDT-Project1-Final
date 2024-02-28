package com.spring.blog.mapper;

import com.spring.blog.vo.Book;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {
    // 모든 도서 목록 가져옴
    public List<Book> findAll();

    // 검색 키워드를 포함하는 제목/ 저자 명을 가진 도서 데이터 가져옴
    public List<Book> findByNameContaining(String keyword);

    // 도서 번호에 해당하는 도서 데이터 가져옴
    public Book findByNum(int book_num);

    // 도서 대출 상태 변경
    void update(boolean availability, int book_num);
}