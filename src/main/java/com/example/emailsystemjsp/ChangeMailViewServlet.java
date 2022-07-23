package com.example.emailsystemjsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ChangeMailViewServlet", value = "/ChangeMailViewServlet")
public class ChangeMailViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String view = request.getParameter("view");

        session.setAttribute("currentDisplay", view);
        response.sendRedirect("ZohoMail.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String view = request.getParameter("view");
        response.sendRedirect("ZohoMail.jsp");
    }
}
