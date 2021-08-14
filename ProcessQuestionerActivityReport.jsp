<%@page import="dao.Expert_dao" %>
<%@page import="dto.Expert_dto" %>
<%
String expertMailID = request.getParameter("expertId");

if(Expert_dao.incrementReport(expertMailID))
    response.sendRedirect("QuestionerActivity.jsp");
else
    response.sendRedirect("QuestionerActivity.jsp");
%>