<?xml version = "1.0" encoding = "utf8" ?>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/xml; charset=UTF-8"
	pageEncoding="UTF-8"%>
<sangpums> 
<%	
	request.setCharacterEncoding("utf-8");
 	Connection conn = null;
 	PreparedStatement pstmt = null;
 	ResultSet rs = null;
 	
 	String name = request.getParameter("name");
 	System.out.println(name);
 	try{
 		Class.forName("oracle.jdbc.driver.OracleDriver");
 		
 	}catch(Exception e){
 		System.out.println("연결 오류 : " + e);
 		return;
 	}
 	
 	try{
 		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
 		String sql = "";
 		if(name != null){
 			sql +="select * from sangdata where sang like '"+name+"%' order by code";
 		}else{
 			sql += "select * from sangdata order by code";
 		}
 		
 		pstmt = conn.prepareStatement(sql);
 		rs = pstmt.executeQuery();
 		while(rs.next()){
 			String code = rs.getString("code");
 			String sang = rs.getString("sang");
 			int su = rs.getInt("su");
 			int dan = rs.getInt("dan");
 			int total = su*dan;
 		
%>		
			<sangpum>
				<dcode><%= code%></dcode>
				<dsang><%= sang%></dsang>
				<dsu><%= su%></dsu>
				<ddan><%= dan%></ddan>
				<dtotal><%= total%></dtotal>
				
			</sangpum>
<%
 		}
 		
 		rs.close();
 		pstmt.close();
 		conn.close();
 	}catch(Exception e2){
 		System.out.println("에러 : " + e2);
 	}
 	
%> 
</sangpums>

<!-- <"%"내용 "%"> 자바로 표현 . -->













