<%@page import="dao.Questioner_dao" %>
<%@page import="dto.Questioner_dto" %>
<%
String emailID = request.getParameter("mailID");
String password = request.getParameter("password");

if(!Questioner_dao.isBlocked(emailID)){
    Questioner_dto dtoObj = Questioner_dao.checkQuestioner(emailID, password);

    if(dtoObj != null){
        session.setAttribute("Questioner", dtoObj);
        response.sendRedirect("QuestionerHome.jsp");
    }
    else{
        session.setAttribute("QuestionerLoginFailed", 1);
        response.sendRedirect("QuestionerLogin.jsp");
    }
}
else{
    session.setAttribute("QuestionerBlocked", 1);
    response.sendRedirect("QuestionerLogin.jsp");
}
%>