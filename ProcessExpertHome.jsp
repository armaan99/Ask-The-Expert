<%@page import="dto.Answers_dto" %>
<%@page import="dao.Answers_dao" %>
<%@page import="dto.Expert_dto" %>
<%
Answers_dto dtoObj = new Answers_dto();
dtoObj.setAnswer(request.getParameter("answer"));
dtoObj.setQuestionID(Integer.parseInt(request.getParameter("questionID")));
dtoObj.setExpertID(((Expert_dto)session.getAttribute("Expert")).getEmailID());
dtoObj.setAgree(0);
dtoObj.setDisagree(0);

if(Answers_dao.addAnswer(dtoObj))
    response.sendRedirect("ExpertHome.jsp"); 
else
    response.sendRedirect("ExpertHome.jsp");
%>