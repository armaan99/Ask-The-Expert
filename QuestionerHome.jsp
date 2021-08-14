<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Questioner_dto" %>

<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <style type="text/css">
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
                background-color: #000000;
                opacity: 0.7;
                width: 48%;
                height: 65%;
                position: absolute;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -45%);
            }
            .subHeading{
                background-color: 8B0000;
                font-weight: bold;
                width: 35%;
                height: 25px;
                text-align: center;
                transform: translate(20%, 30%);
            }
            .subHead{
                font-size: 20px;
                color: white;
                text-align: center;
                vertical-align: middle;
            }
            .category{
                width: 35%;
                height: 24px;
                transform: translate(165%, -70%);
            }
            textarea {
                width: 90%;
                height: 280px;
                padding: 3% 3%;
                margin: 2% 5%;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 6px;
                background-color: #f8f8f8;
                font-size: 16px;
                resize: none;
            }
            .tags{
                width: 55%;
                transform: translate(15%, -80%);
            }
            .tagsLine{
                font-size: 16px;
                color: #ffffff;
            }
            .inputTags{
                width: 60%;
                transform: translate(10%, -100%);
            }
            .tagsInput{
                width: 18%;
            }
            .postBtn{
                height: 42px;
                width: 80px;
                font-size: 16px;
                color: #ffffff;
                font-weight: bold;
                border: none;
                background-color: #8B0000;
                transform: translate(750%, -150%);
            }
            .postBtn:hover{
                background-color: #FF0000;
                color: white;
            }
            .popup{
                position: fixed;
                z-index: 1;
                left: 30%;
                top: 45%;
                width: 40%;
                overflow: auto;
                background-color: transparent;
            }
            .popupText{
                color: #000000;
                font-size: 50px;
                text-align: center;
                margin: 2%;
                font-family: fantasy;
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
        
                var body = $("body");
                <%
                if((int)session.getAttribute("QuestionUploadedSuccessfully") == 1){
                    %>
                    $(body).append('<div class="popup"><p class="popupText">Question posted successfully<p></div>');
                    var error = $(".popupText");
                    $(window).click(function(){
                        $(error).css("display","none");
                    });
                    <%
                }
            %>
            });
        </script>
    </head>
    <body>
        <%
        session.setAttribute("QuestionerBlocked", 0);
        session.setAttribute("QuestionerLoginFailed", 0);
        session.setAttribute("QuestionerChangePasswordMissmatched", 0);
        session.setAttribute("QuestionerPasswordChangedSuccessfully", 0);
        session.setAttribute("QuestionerPasswordChangedSuccessfully", 0);
        session.setAttribute("QuestionerAccountDeletedSuccessfully", 0);
        session.setAttribute("QuestionerTemporaryPasswordSentOnMail", 0);
        session.setAttribute("QuestionerInvalidMailID", 0);
        session.setAttribute("QuestionUploadedSuccessfully", 0);
        %>
        <div class="header">
            <div class="left">
		<a href="Home.jsp" class="logo" ><img src='Images\logo.png' width="220" height="220"/></a>
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
            <div class="box">
                <form action="ProcessQuestionerHome.jsp" method="POST">
                    <div class="subHeading"><p class="subHead">Type your Query here...</p></div>
                    <div>
                        <input type="text" name="category" class="category" placeholder="Select Question Category" list="Category" required>
                        <datalist id="Category">
                            <option value="Computer Science and Technology" />
                            <option value="Health and Medication" />
                            <option value="Sports and Entertainment" />
                            <option value="Arts and Literature" />
                            <option value="Business and Development" />
                        </datalist>
                    </div>
                    <div>
                        <textarea name="question"></textarea>
                    </div>
                    <div class="tags"><p class="tagsLine">Add up to 5 tags to describe what your question is about</p></div>
                    <div class="inputTags">
                        <input class="tagsInput" type="text" name="tag1" placeholder="#1" required>
                        <input class="tagsInput" type="text" name="tag2" placeholder="#2" required>
                        <input class="tagsInput" type="text" name="tag3" placeholder="#3" required>
                        <input class="tagsInput" type="text" name="tag4" placeholder="#4" required>
                        <input class="tagsInput" type="text" name="tag5" placeholder="#5" required>
                    </div>
                    <button class="postBtn" type="submit">Post</button>
                </form>
            </div>
        </div>
        <div class="footer">
            <p class="copyright">Copyright 2020 © Theme Created By Aashi Gupta, Harshita Lashkari, Armaan Agrawal All Rights Reserved</p>
        </div>
    </body>
</html>