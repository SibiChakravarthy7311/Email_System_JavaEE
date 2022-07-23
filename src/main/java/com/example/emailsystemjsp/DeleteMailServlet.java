package com.example.emailsystemjsp;

import Mail.MailDeletor.InboxDeletor;
import Mail.MailDeletor.SentMailDeletor;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteMailServlet", value = "/DeleteMailServlet")
public class DeleteMailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int mailId = Integer.parseInt(request.getParameter("mailId"));
        String currentDisplay = (String) session.getAttribute("currentDisplay");
        boolean deleted = false;
        if (currentDisplay.equals("inbox")) {
            if(new InboxDeletor().delete(mailId)){
                deleted = true;
            }
        }
        else if (currentDisplay.equals("sent")) {
            if(new SentMailDeletor().delete(mailId)){
                deleted = true;
            }
        }
        if(deleted) {
            session.setAttribute("status", "success");
            session.setAttribute("statusMessage", "Mail deleted successfully");
        }
        else{
            session.setAttribute("status", "failure");
            session.setAttribute("statusMessage", "Mail was not deleted successfully");
        }
        response.sendRedirect("ZohoMail.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
