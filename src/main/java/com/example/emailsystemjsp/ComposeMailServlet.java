package com.example.emailsystemjsp;

import Mail.Mail;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ComposeMailServlet", value = "/ComposeMailServlet")
public class ComposeMailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String from = (String) session.getAttribute("email");
        String to = request.getParameter("to");
        String content = request.getParameter("content");

        if(new Mail(from, to, content).sendMail()){
            session.setAttribute("status", "success");
            session.setAttribute("statusMessage", "Mail sent successfully");
        }
        else{
            session.setAttribute("status", "failure");
            session.setAttribute("statusMessage", "Mail was not sent successfully");
        }
        response.sendRedirect("ZohoMail.jsp");
    }
}
