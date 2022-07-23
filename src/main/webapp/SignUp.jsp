<%--
  Created by IntelliJ IDEA.
  User: cibip
  Date: 17-09-2021
  Time: 07:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String status = (String) session.getAttribute("status");
    String statusMessage = (String) session.getAttribute("statusMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Zoho Mail SignUp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="styleSignUp.css" />

    <style>
        .successNotification {
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.2);
            position: absolute;
            top: 0;
            justify-content: center;
            display: flex;
        }

        .successNotification-content {
            transform: translateY(50%);
            height: 12.6%;
            background-color: white;
            margin-bottom: -1.5%;
            position: relative;
            border-radius: 20px;
        }

        .successNotification-status {
            text-align: center;
            margin-top: -5.5%;
        }

        .successNotification-status h1 {
            color: #08680c;
            border-bottom: 2px solid #043907;
        }

        .successMessage {
            border: 1px solid transparent;
            padding: 0.25rem 2rem;
            border-bottom-left-radius: 1rem;
            border-bottom-right-radius: 1rem;
            background-color: #e8fde9;
            margin-top: -7%;
        }

        .successMessage h3 {
            color: #032905;
            margin-top: 3%;
        }

        .successNotification button {
            text-align: center;
        }

        .successNotification button {
            width: 100%;
            font-size: 0.9rem;
            font-weight: bold;
            padding: 0.3rem;
            background-color: #0da713;
            border-radius: 5px;
            color: #fff;
            border: 1px solid #032905;
            cursor: pointer;
            margin-top: -3%;
        }

        .successNotification button:hover,
        .successNotification button:active {
            background-color: #08680c;
        }



        .warningNotification {
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.2);
            position: absolute;
            top: 0;
            justify-content: center;
            display: flex;
        }

        .warningNotification-content {
            transform: translateY(50%);
            height: 12%;
            background-color: white;
            margin-bottom: -1.5%;
            position: relative;
            border-radius: 20px;
        }

        .warningNotification-status {
            text-align: center;
            margin-top: -5.5%;
        }

        .warningNotification-status h1 {
            color: #fecf1f;
            border-bottom: 2px solid #c79e01;
        }

        .warningMessage {
            border: 1px solid transparent;
            padding: 0.25rem 2rem;
            border-bottom-left-radius: 1rem;
            border-bottom-right-radius: 1rem;
            background-color: #fff7d9;
            margin-top: -6%;
        }

        .warningMessage h3 {
            color: #624d00;
            margin-top: 2.7%;
        }

        .warningNotification button {
            text-align: center;
        }

        .warningNotification button {
            width: 100%;
            font-size: 0.9rem;
            font-weight: bold;
            padding: 0.3rem;
            background-color: #fed741;
            border-radius: 5px;
            color: #fff;
            border: 1px solid #b69001;
            cursor: pointer;
            margin-top: -3%;
        }

        .warningNotification button:hover,
        .warningNotification button:active {
            background-color: #e9b901;
        }



        .warningNotification .btn,
        .successNotification .btn {
            display: flex;
            flex: 1;
            justify-content: right;
        }

        .warningNotification .btn button,
        .successNotification .btn button {
            flex: 0.4;
        }

        .warningNotification .close,
        .successNotification .close {
            position: absolute;
            top: 0;
            right: 1%;
            font-size: 4.5vh;
            transform: rotate(45deg);
            font-weight: bold;
            cursor: pointer;
            margin-top: -1%;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="create_account">
        <h1>Create Account</h1>
    </div>

    <div>
        <form class="sign_in" action="SignUpServlet" method="POST">
            <div class="first_name">
                <label>First Name</label>
                <input type="text" name="first_name" placeholder="Enter first name" required/>
            </div>
            <div class="last_name">
                <label>Last Name</label>
                <input type="text" name="last_name" placeholder="Enter Last name" required/>
            </div>
            <div class="email">
                <label>Email</label>
                <input type="email" name="email" placeholder="Email" required/>
            </div>

            <div class="password">
                <label>Password</label>
                <input type="password" name="password" placeholder="Password" required/>
            </div>

            <div class="btn">
                <button type="submit">Create Account</button>
            </div>
        </form>
        <p>Already have an account? <a href="Login.jsp"><b>Log In</b></a></p>
    </div>

</div>

<%
    if (statusMessage != null){
        if (status.equals("success")){
%>
            <div class="successNotification">
                <div class="successNotification-content">

                    <div class="close" onclick=closeSuccessNotification()>+</div>

                    <div class="successNotification-status">
                        <h1>Success</h1>
                    </div>

                    <div class="successMessage">
                        <h3><%=statusMessage%></h3>
                        <div class="btn">
                            <button onClick=closeSuccessNotification()>
                                OK
                            </button>
                        </div>
                    </div>
                </div>
            </div>
<%
        }
        else if (status.equals("failure")){
%>
            <div class="warningNotification">
                <div class="warningNotification-content">

                    <div class="close" onclick=closeWarningNotification()>+</div>

                    <div class="warningNotification-status">
                        <h1>Warning</h1>
                    </div>

                    <div class="warningMessage">
                        <h3><%=statusMessage%></h3>
                        <div class="btn">
                            <button onClick=closeWarningNotification()>
                                OK
                            </button>
                        </div>
                    </div>
                </div>
            </div>
<%
        }
        session.setAttribute("statusMessage", null);
    }
%>

<script src="script.js"></script>
</body>
</html>
