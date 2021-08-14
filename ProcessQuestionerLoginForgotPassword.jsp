<%@page import="dao.Questioner_dao" %>
<%
if(Questioner_dao.forgotPassword(request.getParameter("mailID"))){
    session.setAttribute("QuestionerTemporaryPasswordSentOnMail", 1);
    response.sendRedirect("QuestionerLogin.jsp");
}
else{
    session.setAttribute("QuestionerInvalidMailID", 1);
    response.sendRedirect("QuestionerLogin.jsp");
}
%>