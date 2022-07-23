package com.example.emailsystemjsp;

import Mail.MailDeletor.InboxDeletor;
import Mail.MailDeletor.SentMailDeletor;
import Mail.MailSharing.InboxSharingRevoker;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RevokeInboxSharingServlet", value = "/RevokeInboxSharingServlet")
public class RevokeInboxSharingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int sharingId = Integer.parseInt(request.getParameter("sharingId"));

        if(new InboxSharingRevoker(sharingId).revokeSharingById()){
            session.setAttribute("status", "success");
            session.setAttribute("statusMessage", "Inbox sharing revoked successfully");
        }
        else{
            session.setAttribute("status", "failure");
            session.setAttribute("statusMessage", "Shared inbox revoking was not revoked successfully");
        }
        response.sendRedirect("ZohoMail.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
