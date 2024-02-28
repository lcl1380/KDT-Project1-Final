<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>대출 도서 관리</title>
    <style>
        table {
            border-collapse: collapse;
        }
        th, td{ padding: 10px 6px}
    </style>
</head>
<body>
    <div style="overflow:auto;" class="container" align="center">
        <h1>대출 관리 페이지</h1>
        <a href="/library/list">| 도서 목록 페이지로 이동 |</a> <br><br><br>
        대출한 도서 목록 <br><br>

        <table border="1" width="1000px" heigth="100px" style="table-layout:fixed">
            <tr align="center" >
                <td width="5%"><b>도서번호</b></td>
                <td width="30%"><b>제목</b></td>
                <td width="20%"><b>저자</b></td>
                <td width="15%"><b>대출 시작일</b></td>
                <td width="15%"><b>반납 예정일</b></td>
                <td width="10%"><b>반납하기</b></td>
            </tr>
            <c:forEach var="loan" items="${loanList}" >
                <tr align="center">
                    <td>${loan.book_num}</td>
                    <td>${loan.book_name}</td>
                    <td>${loan.author}</td>
                    <td>${loan.loan_start_date}</td>
                    <td>${loan.loan_start_date}+7일...</td>

                    <!-- 반납 버튼 ~처리 로직 불러오기-->
                    <td> <form action="" method="GET">
                         <input type="submit"  value=반납>
                        <input type="hidden"  name="book_num" value=${loan.book_num} >
                            </form></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>