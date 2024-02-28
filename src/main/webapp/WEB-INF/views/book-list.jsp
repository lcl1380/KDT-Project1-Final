<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 목록</title>
    <style>
        table {
            border-collapse: collapse;
        }
        th, td{ padding: 10px 6px}
    </style>
</head>
<body>

    <div style="overflow:auto;" class="container" align="center">
        <h1>도서 목록 페이지</h1> <br>
            <form action="/library/search" method="POST">
                도서 검색  &nbsp&nbsp&nbsp <input type="text" name="keyword" value=${keyword} >
            </form>

        <br><br>
        <table border="1" width="1000px" heigth="100px" style="table-layout:fixed">
            <tr align="center" >
                <td width="5%"><b>번호</b></td>
                <td width="30%"><b>제목</b></td>
                <td width="20%"><b>저자</b></td>
                <td width="10%"><b>대출 상태</b></td>
                <td width="10%"><b>대출하기</b></td>
            </tr>
            <c:forEach var="book" items="${bookList}" >
                <tr align="center">
                    <td>${book.book_num}</td>
                    <td>${book.book_name}</td>
                    <td>${book.author}</td>

                    <c:choose>
                        <c:when test="${book.availability eq'true'}">
                        <td>대출가능</td>
                            <td> <form action="/library/loan" method="POST">
                                <input type="submit" name="button"  value=대출>
                                <input type="hidden"  name="book_num" value=${book.book_num} >
                            </form></td>
                        </c:when>
                         <c:when test="${book.availability eq'false'}">
                        <td>대출중</td>
                             <td><button width="5" disabled="disabled">대출</button></td>
                        </c:when>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br><br>
</body>
</html>