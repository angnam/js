<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
{"sawons": [
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String result = "";
	String buser = request.getParameter("buser");
	String name = request.getParameter("name");
	

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (Exception e) {
		System.out.println("연결 오류:" + e);
		return;
	}

	try {
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
		if (name == null) {
			String sql = "select sawon_no, sawon_name, sawon_jik, count(gogek_no) from buser inner join sawon on buser_no = buser_num left outer join gogek on gogek_damsano = sawon_no where buser_name = ? group by sawon_no, sawon_name, sawon_jik";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buser);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				result += "{";
				result += "\"no\":" + "\"" + rs.getString("sawon_no") + "\",";
				result += "\"name\":" + "\"" + rs.getString("sawon_name") + "\",";
				result += "\"jik\":" + "\"" + rs.getString("sawon_jik") + "\",";
				result += "\"gogek\":" + "\"" + rs.getString("count(gogek_no)") + "\"";

				result += "},";

			}
		}else{
			String sql = "select gogek_name, gogek_tel, to_char(sysdate, 'yyyy') - substr(gogek_jumin, 1, 2)-1900, gogek_jumin from gogek left outer join sawon on sawon_no = gogek_damsano where sawon_name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			while(rs.next()){
				result += "{";
				result += "\"name\":" + "\"" + rs.getString(1) + "\",";
				result += "\"tel\":" + "\"" + rs.getString(2) + "\",";
				result += "\"age\":" + "\"" + rs.getString(3) + "\",";
				result += "\"gen\":" + "\"" + rs.getString(4) + "\"";

				result += "},";
			}
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