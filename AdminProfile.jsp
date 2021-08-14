<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Admin_dto"%>

<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <style type="text/css">
            *{
                box-sizing: border-box;
            }
            body{
                overflow: hidden;
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
                transform: translate(700%,-40%);
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
            .userIcon{
                color: #ffffff;
                font-size:600%;
                left: 50%;
                top: 50%;
                transform: translate(42%, 80%);
            }
            .name{
                color: #ffffff;
                font-size:30px;
                transform: translate(-1%, 180%);
                width: inherit;
                text-align: center;
                font-weight: bold;
            }
            .email{
                color: #ffffff;
                font-size:20px;
                width: inherit;
                text-align: center;
                transform: translate(-1%, 160%);
                font-style: italic;
            }
            .changePassword{
                font-size : 20px;
                color: #ffffff;
                background-color: #2F4F4F; 
                padding: 3px;
                transform: translate(150%, 120%);
            }
            .changePassword2{
                font-size : 20px;
                color: #ffffff;
                background-color: #2F4F4F; 
                padding: 3px;
                transform: translate(150%, 60%);
            }
            .labels{
                color: #ffffff;
                margin: 6% 0% 2% 20%;
                font-size: 20px; 
            }
            .inputs{
                width: 60%;
                height: 30px;
                margin-left: 20%;
                font-size: 15px;
            }
            .popup{
                position: fixed;
                z-index: 1;
                left: 39%;
                top: 78%;
                width: 20%;
                overflow: auto;
                background-color: transparent;
            }
            .popupText{
                color: #ffffff;
                font-size: 22px;
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
                var box = $(".box");
                
                $(box).append('<div class="mainContent"><div class="userIcon"><i class="fa fa-user-circle-o"></i></div>'+
                    '<p class="name"><% out.print(((Admin_dto)session.getAttribute("Admin")).getFirstName() + " " + ((Admin_dto)session.getAttribute("Admin")).getLastName()); %></p>'+
                    '<p class="email"><% out.print(((Admin_dto)session.getAttribute("Admin")).getEmailID()); %> </p><br>'+
                    '<button class="changePassword" id="changePassword">Change Password</button>');
            
                $(document).on("click","#changePassword",function(){
                    $(".mainContent").hide();
                    $(box).append('<form action="ProcessAdminProfileChangePassword.jsp" method="POST">'+
                        '<p class="labels">Current Password</p>'+
                        '<input type="password" class="inputs" name="currentPassword" required/>'+
                        '<p class="labels">New Password</p>'+
                        '<input type="password" class="inputs" name="newPassword" required/>'+
                        '<p class="labels">Confirm Password</p>'+
                        '<input type="password" class="inputs" name="rePassword" required/><br><br>'+
                        '<button type="submit" class="changePassword2">Change Password</button></form>');
                });
            
                <%
                if((int)session.getAttribute("AdminChangePasswordMissmatched") == 1){
                    %>
                    $(body).append('<div class="popup"><p class="popupText">Password do not match<p></div>');
                    $(".mainContent").hide();
                    $(box).append('<form action="ProcessAdminProfileChangePassword.jsp" method="POST">'+
                        '<p class="labels">Current Password</p>'+
                        '<input type="password" class="inputs" name="currentPassword" required/>'+
                        '<p class="labels">New Password</p>'+
                        '<input type="password" class="inputs" name="newPassword" required/>'+
                        '<p class="labels">Confirm Password</p>'+
                        '<input type="password" class="inputs" name="rePassword" required/><br><br>'+
                        '<button type="submit" class="changePassword2">Change Password</button></form>');
                    var error = $(".popupText");
                    $(window).click(function(){
                        $(error).css("display","none");
                    });
                    <%
                }else if((int)session.getAttribute("AdminPasswordChangedSuccessfully") == -1){
                    %>
                    $(body).append('<div class="popup"><p class="popupText">Invalid Current Password<p></div>');
                    $(".mainContent").hide();
                    $(box).append('<form action="ProcessAdminProfileChangePassword.jsp" method="POST">'+
                        '<p class="labels">Current Password</p>'+
                        '<input type="password" class="inputs" name="currentPassword" required/>'+
                        '<p class="labels">New Password</p>'+
                        '<input type="password" class="inputs" name="newPassword" required/>'+
                        '<p class="labels">Confirm Password</p>'+
                        '<input type="password" class="inputs" name="rePassword" required/><br><br>'+
                        '<button type="submit" class="changePassword2">Change Password</button></form>');
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
        session.setAttribute("AdminLoginFailed", 0);
        session.setAttribute("AdminTemporaryPasswordSentOnMail", 0);
        session.setAttribute("AdminInvalidMailID", 0);
        session.setAttribute("AdminPasswordChangedSuccessfully", 0);
        session.setAttribute("AdminChangePasswordMissmatched", 0);
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
                        out.print(((Admin_dto)session.getAttribute("Admin")).getFirstName());
                        %>
                        </button>
                        <div class="dropdownContent">
                            <a href="AdminHome.jsp">Home</a>
                            <a href="AdminProfile.jsp">Profile</a>
                            <a href="AdminLogin.jsp">Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">
            <div class="box">
            </div>
        </div>
        <div class="footer">
            <p class="copyright">Copyright 2020 © Theme Created By Aashi Gupta, Harshita Lashkari, Armaan Agrawal All Rights Reserved</p>
        </div>
    </body>
</html>