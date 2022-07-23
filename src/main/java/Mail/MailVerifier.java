package Mail;

import java.sql.*;

public class MailVerifier {

    public boolean verifyEmail(String email){
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
            if (resultSet.next()){
                statement.close();
                return true;
            }
            statement.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}