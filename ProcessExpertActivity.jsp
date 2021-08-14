<%@page import="dto.Answers_dto" %>
<%@page import="dao.Answers_dao" %>
<%
int answerID = Integer.parseInt(request.getParameter("answerId"));

if(Answers_dao.deleteAnswer(answerID))
    response.sendRedirect("ExpertActivity.jsp");
else
    response.sendRedirect("ExpertActivity.jsp");
%>