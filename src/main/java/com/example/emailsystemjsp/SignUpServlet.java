package com.example.emailsystemjsp;

import User.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SignUpServlet", value = "/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        if (new User(firstName, lastName, email, password).register()) {
            session.setAttribute("statusMessage", "User registration successful");
            session.setAttribute("status", "success");
            response.sendRedirect("Login.jsp");
        }
        else{
            session.setAttribute("statusMessage", "User registration unsuccessful");
            session.setAttribute("status", "failure");
            response.sendRedirect("SignUp.jsp");
        }
    }
}
