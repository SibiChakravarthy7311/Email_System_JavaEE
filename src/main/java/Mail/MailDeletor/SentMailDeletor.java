package Mail.MailDeletor;

import java.sql.*;

public class SentMailDeletor implements MailDeletor {
    @Override
    public boolean delete(int mailId) {
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
            String parser = "delete from sentmail where mailId=" + mailId;
            statement.executeUpdate(parser);
            statement.close();
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }

        if(new InboxDeletor().delete(mailId)){
            return true;
        }
        return false;
    }

}