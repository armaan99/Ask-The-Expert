<%@page import="dao.Answers_dao" %>
<%@page import="dto.Answers_dto" %>
<%@page import="dao.Questions_dao" %>
<%@page import="dto.Questions_dto" %>
<%
int quesId = Integer.parseInt(request.getParameter("questionId"));
boolean ansCheck = Answers_dao.deleteAnswerFromQuesId(quesId);

boolean quesCheck = Questions_dao.deleteQuestion(quesId);

if(ansCheck && quesCheck)
    response.sendRedirect("QuestionerActivity.jsp");
else
    response.sendRedirect("QuestionerActivity.jsp");
%>