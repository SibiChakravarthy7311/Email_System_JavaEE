package com.example.emailsystemjsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "SharedInboxViewServlet", value = "/SharedInboxViewServlet")
public class SharedInboxViewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String owner = request.getParameter("owner");

        try {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            }
            catch(ClassNotFoundException e){
                System.out.println(e.getMessage());
            }
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/emailsystem", "root",
                    "root");
            Statement statement = connection.createStatement();
            String parser = "select * from user where email='" + owner + "'";
            ResultSet resultSet = statement.executeQuery(parser);
            resultSet.next();
            String sharedInboxUsername = resultSet.getString("first_name") + "." + resultSet.getString("last_name");
            session.setAttribute("sharedInboxUsername", sharedInboxUsername);
            statement.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        session.setAttribute("sharedInbox", owner);
        session.setAttribute("currentDisplay", "sharedInbox");
        response.sendRedirect("ZohoMail.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
