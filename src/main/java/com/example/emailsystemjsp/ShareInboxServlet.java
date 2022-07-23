package com.example.emailsystemjsp;

import Mail.MailSharing.InboxSharer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ShareInboxServlet", value = "/ShareInboxServlet")
public class ShareInboxServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String owner = (String) session.getAttribute("email");
        String receiver = request.getParameter("receiver");

        if(new InboxSharer(owner, receiver).shareInbox()){
            session.setAttribute("status", "success");
            session.setAttribute("statusMessage", "Inbox was shared successfully");
        }
        else{
            session.setAttribute("status", "failure");
            session.setAttribute("statusMessage", "Inbox sharing was not successful");
        }
        response.sendRedirect("ZohoMail.jsp");
    }
}
