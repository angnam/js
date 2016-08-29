<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String name = request.getParameter("name");
String korean = request.getParameter("korean");
String english = request.getParameter("english");

int kor = Integer.parseInt(korean);
int eng = Integer.parseInt(english);
System.out.println("학생명 : " + name + "\n국어점수: " + kor + "\n영어점수 : " + eng + "\n총점 : " + (kor + eng) + "\n평균: " +((kor + eng)/2));

%>