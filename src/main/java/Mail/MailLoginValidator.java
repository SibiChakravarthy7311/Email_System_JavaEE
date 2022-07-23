package Mail;

import java.sql.*;

public class MailLoginValidator {

    String email;
    String password;

    public MailLoginValidator(String email, String password){
        this.email = email;
        this.password = password;
    }

    public boolean validateLoginCredentials(){
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
            if (!resultSet.next()){
                statement.close();
                return false;
            }

            if (resultSet.getString("email").equals(email) && resultSet.getString("password").equals(password)){
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