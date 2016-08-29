<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
{"sawons": [
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String result = "";

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (Exception e) {
		System.out.println("연결 오류:" + e);
		return;
	}

	try {
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
		pstmt = conn.prepareStatement("select sawon_no, sawon_name, buser_tel from sawon left outer join buser on buser_num = buser_no order by sawon_no");
		rs = pstmt.executeQuery();

		while (rs.next()) {
			result += "{";
			result += "\"no\":" + "\"" + rs.getString("sawon_no") + "\",";
			result += "\"name\":" + "\"" + rs.getString("sawon_name") + "\",";
			result += "\"btel\":" + "\"" + rs.getString("buser_tel") + "\"";

			result += "},";
		}
		if (result.length() > 0) {
			result = result.substring(0, (result.length() - 1));
		}
		result += "]}";

		out.println(result);
		rs.close();
		pstmt.close();
		conn.close();
	} catch (Exception e2) {
		System.out.println("에러:" + e2);
	}
%>