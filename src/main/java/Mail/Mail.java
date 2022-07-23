package Mail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Mail {
    String from;
    String to;
    String content;

    public Mail(){}

    public Mail(String from, String to, String content){
        this.from = from;
        this.to = to;
        this.content = content;
    }

    public boolean sendMail(){
        MailVerifier mailVerifier = new MailVerifier();
        if (!mailVerifier.verifyEmail(to)){
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
                    "insert into sentMail(fromMail, toMail, content) values('" + from + "', '" +
                            to + "', '" + content + "')";
            statement.executeUpdate(parser);
            statement.close();
            if(new Mail(from, to, content).receiveInInbox()){
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean receiveInInbox(){
        try {
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/emailsystem", "root",
                    "root");
            Statement statement = connection.createStatement();
            String parser =
                    "insert into inbox(fromMail, toMail, content) values('" + from + "', '" +
                            to + "', '" + content + "')";
            statement.executeUpdate(parser);
            statement.close();
            return true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}