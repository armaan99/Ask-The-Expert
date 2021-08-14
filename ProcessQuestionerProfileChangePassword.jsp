<%@page import="dao.Questioner_dao"%>
<%@page import="dto.Questioner_dto"%>
<%
String questionerMailId = ((Questioner_dto)session.getAttribute("Questioner")).getEmailID();
String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");
String rePassword = request.getParameter("rePassword");

if(newPassword.equals(rePassword)){
    
    if(Questioner_dao.changePassword(questionerMailId, currentPassword, newPassword)){
        session.setAttribute("QuestionerPasswordChangedSuccessfully", 1);
        response.sendRedirect("QuestionerLogin.jsp");
    }
    else{
        session.setAttribute("QuestionerPasswordChangedSuccessfully", -1);
        response.sendRedirect("QuestionerProfile.jsp");
    }
}
else{
    session.setAttribute("QuestionerChangePasswordMissmatched", 1);
    response.sendRedirect("QuestionerProfile.jsp");
}
%>