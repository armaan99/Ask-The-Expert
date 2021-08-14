<%@page import="dao.Questioner_dao"%>
<%@page import="dto.Questioner_dto"%>
<%
Questioner_dto dtoObj = new Questioner_dto();
dtoObj.setFirstName(request.getParameter("first_name"));
dtoObj.setLastName(request.getParameter("last_name"));
dtoObj.setEmailID(request.getParameter("mailID"));
dtoObj.setPassword(request.getParameter("password"));
dtoObj.setConfirmPassword(request.getParameter("confirm_password"));

if(!Questioner_dao.checkQuestionerExistance(dtoObj.getEmailID())){
    if(dtoObj.getPassword().equals(dtoObj.getConfirmPassword())){
        String otpOnMail = Questioner_dao.sendVerificationMail(dtoObj.getEmailID());

        session.setAttribute("Questioner", dtoObj);
        session.setAttribute("otpOnMail", otpOnMail);
        response.sendRedirect("QuestionerSignUpVerification.jsp");
    }
    else{
        session.setAttribute("QuestionerPasswordMissmatched", 1);
        response.sendRedirect("QuestionerSignUp.jsp");
    }
}
else{
    session.setAttribute("QuestionerExists", 1);
    response.sendRedirect("QuestionerSignUp.jsp");
}
%>