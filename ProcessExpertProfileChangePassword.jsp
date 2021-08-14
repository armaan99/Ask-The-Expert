<%@page import="dao.Expert_dao"%>
<%@page import="dto.Expert_dto"%>
<%
String expertMailId = ((Expert_dto)session.getAttribute("Expert")).getEmailID();
String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");
String rePassword = request.getParameter("rePassword");

if(newPassword.equals(rePassword)){
    
    if(Expert_dao.changePassword(expertMailId, currentPassword, newPassword)){
        session.setAttribute("ExpertPasswordChangedSuccessfully", 1);
        response.sendRedirect("ExpertLogin.jsp");
    }
    else{
        session.setAttribute("ExpertPasswordChangedSuccessfully", -1);
        response.sendRedirect("ExpertProfile.jsp");
    }
}
else{
    session.setAttribute("ExpertChangePasswordMissmatched", 1);
    response.sendRedirect("ExpertProfile.jsp");
}
%>