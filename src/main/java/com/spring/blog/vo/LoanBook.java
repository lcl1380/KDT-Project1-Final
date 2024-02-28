package com.spring.blog.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class LoanBook {
    String id;
    Date loan_start_date;
    int book_num;
    String author;
    String book_name;
}
