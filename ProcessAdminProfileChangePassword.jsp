<%@page import="dao.Admin_dao"%>
<%@page import="dto.Admin_dto"%>
<%
String adminMailId = ((Admin_dto)session.getAttribute("Admin")).getEmailID();
String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");
String rePassword = request.getParameter("rePassword");

if(newPassword.equals(rePassword)){
    
    if(Admin_dao.changePassword(adminMailId, currentPassword, newPassword)){
        session.setAttribute("AdminPasswordChangedSuccessfully", 1);
        response.sendRedirect("AdminLogin.jsp");
    }
    else{
        session.setAttribute("AdminPasswordChangedSuccessfully", -1);
        response.sendRedirect("AdminProfile.jsp");
    }
}
else{
    session.setAttribute("AdminChangePasswordMissmatched", 1);
    response.sendRedirect("AdminProfile.jsp");
}
%>