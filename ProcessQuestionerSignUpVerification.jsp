<%@page import="dao.Questioner_dao"%>
<%@page import="dto.Questioner_dto"%>
<%
String otp = request.getParameter("otp");
String otpOnMail = (String)session.getAttribute("otpOnMail");

if(otp.equals(otpOnMail)){
    Questioner_dto dtoObj = (Questioner_dto)session.getAttribute("Questioner");
    
    if(Questioner_dao.addQuestioner(dtoObj))
        response.sendRedirect("QuestionerHome.jsp");
}
else{
    session.setAttribute("QuestionerRegisterInvalidOTP", 1);
    response.sendRedirect("QuestionerSignUpVerification.jsp");
}
%>