package com.example.emailsystemjsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ConfirmDeletionServlet", value = "/ConfirmDeletionServlet")
public class ConfirmDeletionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String deletionCommand = request.getParameter("deletionCommand");
        String currentDisplay = (String) session.getAttribute("currentDisplay");

        session.setAttribute("status", "confirmDelete");
        switch(currentDisplay){
            case "inbox":
                session.setAttribute("statusMessage", "Confirm deletion of the mail from your inbox?");
                break;

            case "sent":
                session.setAttribute("statusMessage", "Confirm deletion of the sent mail?");
                break;

            case "inboxUsers":
                session.setAttribute("statusMessage", "Confirm revoking the user's access to your inbox?");
                break;

            case "inboxSharers":
                session.setAttribute("statusMessage", "Confirm revoking access to the user's inbox?");
                break;

            default:
                session.setAttribute("statusMessage", "Confirm deletion?");
                break;
        }
        session.setAttribute("deletionCommand", deletionCommand);
        response.sendRedirect("ZohoMail.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
