<%@page import="dao.Questioner_dao"%>
<%@page import="dto.Questioner_dto"%>

<%
String questionerMailId = ((Questioner_dto)session.getAttribute("Questioner")).getEmailID();
String password = request.getParameter("password");

if(Questioner_dao.deleteAccount(questionerMailId, password)){
    session.setAttribute("QuestionerAccountDeletedSuccessfully", 1);
    response.sendRedirect("Home.jsp");
}
else{
    session.setAttribute("QuestionerAccountDeletedSuccessfully", -1);
    response.sendRedirect("QuestionerProfile.jsp");
}
%>