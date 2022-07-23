package Mail.MailSharing;

import Mail.MailVerifier;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class InboxSharingRevoker {
    int sharingId;

    public InboxSharingRevoker(int sharingId){
        this.sharingId = sharingId;
    }


    public boolean revokeSharingById(){
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
            String parser = "delete from shared_inbox where sharingId=" + sharingId;
            statement.executeUpdate(parser);
            statement.close();
            return true;
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}