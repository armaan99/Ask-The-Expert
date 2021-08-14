<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="dao.Questions_dao" %>
<%@page import="dto.Questions_dto" %>
<%@page import="dto.Answers_dto" %>
<%@page import="dao.Answers_dao" %>
<%@page import="dto.Expert_dto" %>

<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <style>
            *{
                box-sizing: border-box;
            }
            body{
                overflow-y: scroll;
                background-image: url('Images\\background.jpg');
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                position: relative;
                background-attachment: fixed;
            }
            .header{
                height: 10%;
                position: fixed;
                z-index: 1;
            }
            .main{
                height: 85%;
            }
            .left{
                float: left;
                height: 100%;
                margin-top: -4%;
                padding: 2%;
                width: 65%;
            }
            .center{
                float: left;
                width: 0%;
                height: 100%;
                padding: 1%;
                top: 2%;
                left: 30%;
                transform: translate(200%,-40%);
            }
            .myTitle{
                color: #ffffff;
                font-size: 60px;
                text-align: center;
                font-weight: bold;
                font-style: italic;
                font-family: monospace;
            }
            .right{
                float: left;
                padding: 1%;
                height: 100%;
                width: 30%;
                top: 2%;
                left: 70%;
                transform: translate(320%,20%);
            }
            .navigator{
                text-align: right;
                text-decoration: none;
                margin: 0% 4% 5% 0%;
            }
            .dropdown{
                position: relative;
                display: inline-block;
                margin: 2% 5% 3% 0%;
            }
            .dropdownList{
                background-color: #B22222;
                border: none;
                font-weight: bold;
                color: #ffffff;
                font-size: 20px;
                padding: 10px;
                opacity: 0.8;
            }
            .dropdownList:hover{
                opacity: 1;
            }
            .dropdownContent a:hover{
                background-color: #f1f1f1;
                color: #000000;
                font-weight: bold;
            }
            .dropdownContent{
                position: absolute;
                display: none;
                background-color: #ffffff;
                opacity: 1;
                text-align: left;
                z-index: 1;
                width: 100%;
            }
            .dropdownContent a{
                color: #000000;
                padding: 5px 15px;
                display: block;
                text-decoration: none;
                opacity: 1;
            }
            .dropdown:hover .dropdownContent{
                display: block;
            }
            .box{
                border: 1px outset #000000;
                width: 48%;
                height: 80%;
                margin-top: 8%;
                margin-left: 26%;
                margin-right: 26%;
                margin-bottom: 10.5%;
                box-sizing: border-box;
                background-color: #000000;
                opacity: 0.7;
                font-size: 16px;
                resize: none;
                overflow: hidden;
            }
            .question{
                width: 90%;
                height: 360px;
                padding: 2% 3%;
                margin: 3.5% 5%;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 6px;
                background-color: #A1A0A0;
                font-size: 16px;
                resize: none;
                overflow-y: scroll;
            }
            .answerBtn{
                height: 42px;
                width: 80px;
                font-size: 16px;
                color: #ffffff;
                font-weight: bold;
                border: none;
                background-color: #8B0000;
                transform: translate(60%, -20%);
            }
            .answerBtn:hover{
                background-color: #FF0000;
                color: white;
            }
            .answer{
                width: 90%;
                height: 120px;
                padding: 3% 3%;
                margin: 3% 5%;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 6px;
                background-color: #f8f8f8;
                font-size: 16px;
                resize: none;
                overflow-y: scroll;
            }
            .noQuestion{
                color: #ffffff;
                font-size: 48px;
                text-align: center;
                font-family: cursive;
                margin : 20% 0%;
            }
            .postBtn{
                height: 42px;
                width: 80px;
                font-size: 16px;
                color: #ffffff;
                font-weight: bold;
                border: none;
                background-color: #8B0000;
                transform: translate(730%, -30%);
            }
            .postBtn:hover{
                background-color: #FF0000;
                color: white;
            }
            .hiddenInputs{
                display: none;
            }
            .footer{
                height: 5%;
                background-color: #000000;
                color: #ffffff;
                text-align: center;
                padding-bottom: 3%;
                opacity: 0.3;
                width: 100%;
                position: fixed;
                left: 50%;
                top: 94%;
                transform: translate(-50%, 0%);
            }
            .copyright{
                margin-bottom: 50px;
            }
        </style>
        <script type="text/javascript">
            $(document).ready(function(){
            var main = $(".main");
            
            <%
                int totalNumberOfQuestion=0;
                int numberOfAnsweredQuestions = 0;
                
                String category = ((Expert_dto)(session.getAttribute("Expert"))).getCategory();

                ArrayList<Questions_dto> quesDetails = Questions_dao.getAllQuestionsOfCategory(category);

                Iterator quesitr = quesDetails.iterator();
                
                if(!quesDetails.isEmpty()){
                    while(quesitr.hasNext()){
                        totalNumberOfQuestion++;
                        Questions_dto obj = (Questions_dto)quesitr.next();

                        String expertMailId = ((Expert_dto)session.getAttribute("Expert")).getEmailID();
                        int quesId = obj.getQuestionID();

                        int checkQues = Answers_dao.checkForAnsweredQuestions(expertMailId, quesId);

                        if(obj.getQuestionID() != checkQues){
                        %>
                            $(main).append('<div class="box" id="box'+ <%out.print(obj.getQuestionID());%> +'"></div>');
                            $("#box"+ <%out.print(obj.getQuestionID());%>).append('<div class="question" id="question'+ <%out.print(obj.getQuestionID());%> +'"><%  out.print(obj.getQuestion()); %></div>');
                            $("#box"+ <%out.print(obj.getQuestionID());%>).append('<button class="answerBtn" id="'+ <%out.print(obj.getQuestionID());%> +'">Answer</button>');
                        <%
                        }else{
                            numberOfAnsweredQuestions++;
                        }
                    }
                    if((numberOfAnsweredQuestions == totalNumberOfQuestion) && (numberOfAnsweredQuestions!=0)){
                        %>
                        $(main).append('<div class="box"%></div>');
                        $(".box").append('<p class="noQuestion">You have Answered all Questions...</p>');
                        <%
                    }
                }
                %>
                $(main).append('<br>');
                
                $(document).on("click",".answerBtn",function(){
                    $(this).remove();
                    $("#question"+this.id).css("height","240px");
                    $("#box"+this.id).append('<form action="ProcessExpertHome.jsp" method="POST" ><div>'+
                        '<textarea class="answer" id="answer'+this.id+'" name="answer" required></textarea>'+
                        '<input class="hiddenInputs" name="questionID" value="'+this.id+'"/>'+
                        '<input class="hiddenInputs" name="expertID" value="<%out.print(session.getAttribute("expertMailID"));%>"/>'+
                        '<button class="postBtn" id="'+this.id+'" type="submit">Post</button>'+
                        '</div></form>');
                });
            });
        </script>
    </head>
    <body>
        <%
        session.setAttribute("ExpertBlocked", 0);
        session.setAttribute("ExpertLoginFailed", 0);
        session.setAttribute("ExpertInvalidMailID", 0);
        session.setAttribute("ExpertTemporaryPasswordSentOnMail",0);
        session.setAttribute("ExpertAccountDeletedSuccessfully", 0);
        session.setAttribute("ExpertPasswordChangedSuccessfully", 0);
        session.setAttribute("ExpertChangePasswordMissmatched", 0);
        %>
        <div class="header">
            <div class="left">
                <a href="Home.jsp" class="logo" ><img src="Images\\logo.png" width="220" height="220"/></a>
            </div>
            <div class="center">
                <p class="myTitle">ASKtheEXPERT</p>
            </div>
            <div class="right">
                <div class="navigator">
                    <div class="dropdown">
			<button class="dropdownList"><i class="fa fa-user-circle-o" aria-hidden="true" style="color: #ffffff; margin-right: 10px; font-size: 20px;"></i>
                            <%
                            out.print(((Expert_dto)session.getAttribute("Expert")).getFirstName());
                            %>
                        </button>
                        <div class="dropdownContent">
                            <a href="ExpertHome.jsp">Home</a>
                            <a href="ExpertActivity.jsp">Activity</a>
                            <a href="ExpertProfile.jsp">Profile</a>
                            <a href="ExpertLogin.jsp">Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">
        </div>
        <div class="footer">
            <p class="copyright">Copyright 2020 © Theme Created By Aashi Gupta, Harshita Lashkari, Armaan Agrawal All Rights Reserved</p>
        </div>
    </body>
</html>