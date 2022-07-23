package Mail.MailSharing;

import Mail.MailVerifier;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class InboxSharer {
    String owner;
    String receiver;

    public InboxSharer(String owner, String receiver) {
        this.owner = owner;
        this.receiver = receiver;
    }

    public boolean shareInbox() {
        MailVerifier mailVerifier = new MailVerifier();
        if (!mailVerifier.verifyEmail(receiver)){
            return false;
        }
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
            String parser =
                    "insert into shared_inbox(owner, receiver) values('" + owner + "', '" +
                            receiver + "')";
            statement.executeUpdate(parser);
            statement.close();
            return true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}