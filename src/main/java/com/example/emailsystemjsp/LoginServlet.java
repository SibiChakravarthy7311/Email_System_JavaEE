package com.example.emailsystemjsp;

import Mail.MailLoginValidator;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName;
        String lastName;
        String userName = "";
        HttpSession session = request.getSession();

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

        MailLoginValidator mailLoginValidator = new MailLoginValidator(email, password);
        if(mailLoginValidator.validateLoginCredentials()) {
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
                String parser = "select * from user where email='" + email + "'";
                ResultSet resultSet = statement.executeQuery(parser);
                resultSet.next();
                firstName = resultSet.getString("first_name");
                lastName = resultSet.getString("last_name");
                userName = firstName + "." + lastName;

                statement.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
            session.setAttribute("userName", userName);
            session.setAttribute("email", email);
            session.setAttribute("currentDisplay", "inbox");
            session.setAttribute("status", "success");
            session.setAttribute("statusMessage", "Logged in as " + userName);

            response.sendRedirect("ZohoMail.jsp");
        }
        else {
            session.setAttribute("status", "failure");
            session.setAttribute("statusMessage", "User Login Unsuccessful");
            response.sendRedirect("Login.jsp");
        }
    }
}
