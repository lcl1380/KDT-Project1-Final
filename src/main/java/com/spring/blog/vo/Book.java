package com.spring.blog.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Book {
    int book_num;
    String book_name;
    String author;
    Boolean availability;
}
