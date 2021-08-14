<%@page import="dao.Answers_dao" %>
<%@page import="dto.Answers_dto" %>
<%
int answerId = Integer.parseInt(request.getParameter("answerId"));

if(Answers_dao.incrementDisagree(answerId))
    response.sendRedirect("QuestionerActivity.jsp");
else
    response.sendRedirect("QuestionerActivity.jsp");
%>