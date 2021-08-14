<%@page import="dao.Admin_dao" %>
<%@page import="dto.Admin_dto" %>
<%
String emailID = request.getParameter("mailID");
String password = request.getParameter("password");

Admin_dto dtoObj = Admin_dao.checkAdmin(emailID, password);

if(dtoObj != null){
    session.setAttribute("Admin", dtoObj);
    response.sendRedirect("AdminHome.jsp");
}
else{
    session.setAttribute("AdminLoginFailed", 1);
    response.sendRedirect("AdminLogin.jsp");
}
%>