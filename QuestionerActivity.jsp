<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="dao.Questions_dao"%>
<%@page import="dto.Questions_dto"%>
<%@page import="dao.Answers_dao"%>
<%@page import="dto.Answers_dto"%>
<%@page import="dto.Questioner_dto"%>

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
                overflow-y: scroll;
            }
            .box2{
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
                height: 230px;
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
            .answer{
                width: 90%;
                height: 120px;
                padding: 3% 3%;
                margin: 1% 5% 0% 5%;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 6px;
                background-color: #f8f8f8;
                font-size: 16px;
                resize: none;
                overflow-y: scroll;
            }
            .agree{
                background-color: #2FC52A;
                color: #ffffff;
                width: 7%;
                height: 5.5%;
                margin: 2% 1% 0% 7%;
                border-radius: 7px;
                cursor: pointer;
            }
            .disagree{
                background-color: #FF0000;
                color: #ffffff;
                width: 7%;
                height: 5.5%;
                margin: 2% 0% 0% 0%;
                border-radius: 7px;
                cursor: pointer;
            }
            .report{
                background-color: #000000;
                color: #ffffff;
                width: 9%;
                text-align: center;
                height: 5.5%;
                margin: -5% 0% 0% 84%;
                cursor: pointer;
            }
            .delete{
                background-color: #FF0000;
                color: #ffffff;
                width: 9%;
                text-align: center;
                height: 5.5%;
                margin: -2% 0% 0% 84%;
                cursor: pointer;
            }
            .votes{
                color: #ffffff;
                font-weight: bold;
                font-family: initial;
                font-size: 15px;
                margin: -3% 0% 0% 25%;
            }
            .noQuestion{
                color: #ffffff;
                font-size: 48px;
                text-align: center;
                font-family: cursive;
                margin : 22% 0%;
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
                    String questionerId = ((Questioner_dto)session.getAttribute("Questioner")).getEmailID();
                    
                    ArrayList<Questions_dto> quesList = new ArrayList<>();
                    
                    quesList = Questions_dao.getAllQuestionsOfQuestioner(questionerId);
                    
                    Iterator quesItr = quesList.iterator();
                    
                    if( ! quesList.isEmpty() )
                    {
                        while(quesItr.hasNext()){
                            Questions_dto quesObj = (Questions_dto)quesItr.next();
                            %>
                                $(main).append('<div class="box" id="box'+<% out.print(quesObj.getQuestionID()); %>+'"></div>');
                                $("#box"+<% out.print(quesObj.getQuestionID()); %>).append('<div class="question" id="question'+<% out.print(quesObj.getQuestionID()); %>+'"><% out.print(quesObj.getQuestion()); %></div>'+
                                '<form action="ProcessQuestionerActivityDelete.jsp" method="POST"><input class="hiddenInputs" name="questionId" value="<% out.print(quesObj.getQuestionID()); %>" />'+
                                '<button type="submit" class="delete" id="delete'+ <% out.print(quesObj.getQuestionID()); %> +'">Delete</button></form>');
                            <%

                            ArrayList<Answers_dto> ansList = Answers_dao.getAllAnswersOfQuestion(quesObj.getQuestionID());

                            Iterator ansItr = ansList.iterator();

                            while(ansItr.hasNext()){
                                Answers_dto ansObj = (Answers_dto)ansItr.next();

                                float agree = (float)ansObj.getAgree();
                                float disagree = (float)ansObj.getDisagree();
                                int totalVotes = (int)(agree + disagree);
                                int percentageAgree = -1;
                                String votes = null;

                                if(totalVotes != 0){
                                    percentageAgree = (int)((agree / totalVotes) * 100);
                                }
                                else{
                                    votes = "No votes yet";
                                }%>
                                $("#box"+<% out.print(quesObj.getQuestionID()); %>).append();
                                <% if(totalVotes != 0){ %>
                                    $("#box"+<% out.print(quesObj.getQuestionID()); %>).append('<form action="ProcessQuestionerActivityAgree.jsp" method="POST"><textarea class="answer" readonly><% out.print(ansObj.getAnswer()); %></textarea>'+
                                    '<input class="hiddenInputs" name="answerId" value="<% out.print(ansObj.getAnswerID()); %>" />'+
                                    '<input class="hiddenInputs" name="expertId" value="<% out.print(ansObj.getExpertID()); %>" />'+
                                    '<button class="agree" id="agree'+<% out.print(ansObj.getAnswerID()); %>+' type="submit"><i class="fa fa-thumbs-up"></i></button>'+
                                    '<button class="disagree" id="disagree'+<% out.print(ansObj.getAnswerID()); %>+'" type="submit" formaction="ProcessQuestionerActivityDisagree.jsp"><i class="fa fa-thumbs-down"></i></button>'+
                                    '<div class="votes"><% out.print(percentageAgree); %>% Agreed of <% out.print(totalVotes); %></div>'+
                                    '<button class="report" id="report'+<% out.print(ansObj.getAnswerID()); %>+'" type="submit" formaction="ProcessQuestionerActivityReport.jsp">Report</button></form><br><br><br>');
                                <%
                                }else{
                                %>
                                    $("#box"+<% out.print(quesObj.getQuestionID()); %>).append('<form action="ProcessQuestionerActivityAgree.jsp" method="POST"><textarea class="answer" readonly><% out.print(ansObj.getAnswer()); %></textarea>'+
                                    '<input class="hiddenInputs" name="answerId" value="<% out.print(ansObj.getAnswerID()); %>" />'+
                                    '<input class="hiddenInputs" name="expertId" value="<% out.print(ansObj.getExpertID()); %>" />'+
                                    '<button class="agree" id="agree'+<% out.print(ansObj.getAnswerID()); %>+' type="submit"><i class="fa fa-thumbs-up"></i></button>'+
                                    '<button class="disagree" id="disagree'+<% out.print(ansObj.getAnswerID()); %>+'" type="submit" formaction="ProcessQuestionerActivityDisagree.jsp"><i class="fa fa-thumbs-down"></i></button>'+
                                    '<div class="votes"><% out.print(votes); %></div>'+
                                    '<button class="report" id="report'+<% out.print(ansObj.getAnswerID()); %>+'" type="submit" formaction="ProcessQuestionerActivityReport.jsp">Report</button><form><br><br><br>');
                                <%
                                }
                            }
                        }
                    }else{
                        %>
                        $(main).append('<div class="box2"%></div>');
                        $(".box2").append('<p class="noQuestion">You have not Posted any Questions yet...</p>');
                        <%
                    }
                %>
                $(main).append('<br>');
            });
        </script>
    </head>
    <body>
        <%
        session.setAttribute("QuestionerBlocked", 0);
        session.setAttribute("QuestionerLoginFailed", 0);
        session.setAttribute("QuestionUploadedSuccessfully", 0);
        session.setAttribute("QuestionerChangePasswordMissmatched", 0);
        session.setAttribute("QuestionerPasswordChangedSuccessfully", 0);
        session.setAttribute("QuestionerAccountDeletedSuccessfully", 0);
        session.setAttribute("QuestionerTemporaryPasswordSentOnMail", 0);
        session.setAttribute("QuestionerInvalidMailID", 0);
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
                            out.print(((Questioner_dto)session.getAttribute("Questioner")).getFirstName());
                            %>
                        </button>
                        <div class="dropdownContent">
                            <a href="QuestionerHome.jsp">Home</a>
                            <a href="QuestionerActivity.jsp">Activity</a>
                            <a href="QuestionerProfile.jsp">Profile</a>
                            <a href="QuestionerLogin.jsp">Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">
        </div>
        <div class="footer">
            <p class="copyright">Copyright 2020 ?? Theme Created By Aashi Gupta, Harshita Lashkari, Armaan Agrawal All Rights Reserved</p>
        </div>
    </body>
</html>