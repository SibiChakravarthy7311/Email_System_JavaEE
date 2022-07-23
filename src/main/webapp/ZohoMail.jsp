<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: cibip
  Date: 17-09-2021
  Time: 08:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String userName = (String) session.getAttribute("userName");
    String email = (String) session.getAttribute("email");
    String currentDisplay = (String) session.getAttribute("currentDisplay");
    String inbox = "inbox";
    String sent = "sent";
    String inboxUsers = "inboxUsers";
    String inboxSharers = "inboxSharers";
    String status = (String) session.getAttribute("status");
    String statusMessage = (String) session.getAttribute("statusMessage");
    String sharedInbox = (String) session.getAttribute("sharedInbox");
    String sharedInboxUsername = (String) session.getAttribute("sharedInboxUsername");
    String deletionCommand = (String) session.getAttribute("deletionCommand");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <link rel="stylesheet" href="styleZohoMail.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500&display=swap" rel="stylesheet">
    <title>Zoho Mail</title>

</head>
<body>
<div class="header">
    <div class="header_left">
        <img src="ZohoMail.jpg" alt="Zoho Mail Image">
    </div>

    <div class="header_middle">
        <span class="material-icons">search</span>
        <input type="text" placeholder="Search Mail">
        <span class="material-icons">arrow_drop_down</span>
    </div>

    <div class="header_right">
        <span class="user-name">
          <%=userName%>
        </span>
        <a href="LogoutServlet">
            <span class="material-icons">
              logout
            </span>
        </a>
    </div>
</div>

<div class="main_body">

    <div class="sidebar">
        <button class="sidebar_compose" type="submit" onclick="openCompose()">
            <span class="material-icons">
                add
            </span>
            &nbsp;Compose
        </button>

        <a  href="ChangeMailViewServlet?view=<%=inbox%>">
            <div class="sidebarOption sidebarOption_active">
                    <span class="material-icons">
                        inbox
                    </span>
                    <h3 id="inboxHeading">Inbox</h3>
            </div>
        </a>

        <a href="ChangeMailViewServlet?view=<%=sent%>">
            <div class="sidebarOption sidebarOption_active">
                <span class="material-icons">
                    near_me
                </span>
                <h3>Sent</h3>
            </div>
        </a>

        <a href="ChangeMailViewServlet?view=<%=inboxUsers%>">
            <div class="sidebarOption sidebarOption_active">
                <span class="material-icons">
                    person
                </span>
                <h3>Inbox Users</h3>
            </div>
        </a>

        <a href="ChangeMailViewServlet?view=<%=inboxSharers%>">
            <div class="sidebarOption sidebarOption_active">
                <span class="material-icons">
                    volunteer_activism
                </span>
                <h3>Inbox Sharers</h3>
            </div>
        </a>

        <button class="sidebar_share" type="submit" onClick="openShareInbox()">
            <span class="material-icons">
                add
            </span>
            &nbsp;Share Inbox
        </button>
    </div>

    <%
        if (currentDisplay.equals("sent")) {
    %>

            <div class="emailList">

                <div class="main_body_list_header">
                    <h4>Sent Mail</h4>
                </div>

                <div class="email_header">
                    <div class="emailList_sections">
                        <h4 class="section emailList_sections_id">
                            To
                        </h4>

                        <div class="section emailList_sections_from">
                            <h4>Time</h4>
                        </div>

                        <div class="section emailList_sections_content">
                            <h4>Content</h4>
                        </div>
                    </div>
                </div>

                <div class="emailList_list">

    <%
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
                ResultSet resultSet = statement.executeQuery("select * from sentmail where fromMail='" + email + "' order by mailId desc");
                while (resultSet.next()){
                    int mailId = resultSet.getInt("mailId");
                    String toMail = resultSet.getString("toMail");
                    String content = resultSet.getString("content");
                    Timestamp timestamp = resultSet.getTimestamp("time_stamp");
                    String date = timestamp.toString();
    %>

                        <div class="emailRow">
                            <h3 class="emailRow_id">
                                <%=toMail%>
                            </h3>
                            <div class="emailRow_mail">
                                <h3><%=date%></h3>
                            </div>
                            <div class="emailRow_message">
                                <h4><%=content%></h4>
                            </div>
                            <div class="emailRow_delete">
                                <a  href="ConfirmDeletionServlet?deletionCommand=DeleteMailServlet?mailId=<%=mailId%>">
                                    <span class="material-icons">
                                        delete
                                    </span>
                                </a>
                            </div>
                        </div>

    <%
                }
                statement.close();
            }
            catch (SQLException e){
                System.out.println(e.getMessage());
            }
        }
        else if(currentDisplay.equals("inbox")){
    %>

            <div class="emailList">

                <div class="main_body_list_header">
                    <h4>Inbox</h4>
                </div>

                <div class="email_header">
                    <div class="emailList_sections">
                        <h4 class="section emailList_sections_id">
                            From
                        </h4>

                        <div class="section emailList_sections_from">
                            <h4>Time</h4>
                        </div>

                        <div class="section emailList_sections_content">
                            <h4>Content</h4>
                        </div>
                    </div>
                </div>

                <div class="emailList_list">

    <%
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

                ResultSet resultSet = statement.executeQuery("select * from inbox where toMail = '" + email + "' order by mailId desc");
                while (resultSet.next()){
                    int mailId = resultSet.getInt("mailId");
                    String fromMail = resultSet.getString("fromMail");
                    String toMail = resultSet.getString("toMail");
                    Timestamp timestamp = resultSet.getTimestamp("time_stamp");
                    String date = timestamp.toString();
                    String content = resultSet.getString("content");
    %>

                    <div class="emailRow">
                        <h3 class="emailRow_id">
                            <%=fromMail%>
                        </h3>
                        <div class="emailRow_mail">
<%--                                <h3><%=toMail%></h3>--%>
                            <h3><%=date%></h3>
                        </div>
                        <div class="emailRow_message">
                            <h4><%=content%></h4>
                        </div>
                        <div class="emailRow_delete">
                            <a  href="ConfirmDeletionServlet?deletionCommand=DeleteMailServlet?mailId=<%=mailId%>">
                                <span class="material-icons">
                                    delete
                                </span>
                            </a>
                        </div>
                    </div>

    <%
                }
                statement.close();
            }
            catch (SQLException e){
                System.out.println(e.getMessage());
            }
        }
        else if (currentDisplay.equals("inboxUsers")) {
    %>

            <div class="sharedInboxList">
                <div class="sharedInboxList_list">

                    <div class="main_body_list_header">
                        <h4>Inbox Users</h4>
                    </div>

                    <div class="email_header">
                        <div class="emailList_sections">
                            <h4 class="section emailList_sections_id">
                                Id
                            </h4>

                            <div class="section emailList_sections_from">
                                <h4>Shared To</h4>
                            </div>
                        </div>
                    </div>
    <%
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
                ResultSet resultSet = statement.executeQuery("select * from shared_inbox where owner='" + email + "'");
                while (resultSet.next()){
                    int sharingId = resultSet.getInt("sharingId");
                    String receiver = resultSet.getString("receiver");
    %>

                        <div class="sharedInboxRow">
                            <h3 class="sharedInboxRow_id">
                                <%=sharingId%>
                            </h3>
                            <div class="sharedInboxRow_mail">
                                <h3><%=receiver%></h3>
                            </div>
                            <div class="sharedInboxRow_delete">
                                <a  href="ConfirmDeletionServlet?deletionCommand=RevokeInboxSharingServlet?sharingId=<%=sharingId%>">
                                    <span class="material-icons">
                                        delete
                                    </span>
                                </a>
                            </div>
                        </div>

    <%
                }
                statement.close();
            }
            catch (SQLException e){
                System.out.println(e.getMessage());
            }
        }
        else if (currentDisplay.equals("inboxSharers")) {
    %>

            <div class="sharedInboxList">
                <div class="sharedInboxList_list">

                    <div class="main_body_list_header">
                        <h4>Inbox Sharers</h4>
                    </div>

                    <div class="email_header">
                        <div class="emailList_sections">
                            <h4 class="section emailList_sections_id">
                                Id
                            </h4>

                            <div class="section emailList_sections_from">
                                <h4>Inbox Of</h4>
                            </div>
                        </div>
                    </div>
    <%
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
                ResultSet resultSet = statement.executeQuery("select * from shared_inbox where receiver='" + email + "'");
                while (resultSet.next()){
                    int sharingId = resultSet.getInt("sharingId");
                    String owner = resultSet.getString("owner");
    %>
                    <div class="sharedInboxRow">
                        <h3 class="sharedInboxRow_id">
                            <%=sharingId%>
                        </h3>
                        <div class="sharedInboxRow_mail">
                            <a href="SharedInboxViewServlet?owner=<%=owner%>"><h3><%=owner%></h3></a>
                        </div>
                        <div class="sharedInboxRow_delete">
                            <a  href="ConfirmDeletionServlet?deletionCommand=RevokeInboxSharingServlet?sharingId=<%=sharingId%>">
                            <span class="material-icons">
                                delete
                            </span>
                            </a>
                        </div>
                    </div>

    <%
                }
                statement.close();
            }
            catch (SQLException e){
                System.out.println(e.getMessage());
            }
        }
        else if (currentDisplay.equals("sharedInbox")) {
    %>

            <div class="emailList">

                <div class="main_body_list_header">
                    <h4><%=sharedInboxUsername%>'s Inbox</h4>
                </div>

                <div class="email_header">
                    <div class="emailList_sections">
                        <h4 class="section emailList_sections_id">
                            From
                        </h4>

                        <div class="section emailList_sections_from">
                            <h4>Time</h4>
                        </div>

                        <div class="section emailList_sections_content">
                            <h4>Content</h4>
                        </div>
                    </div>
                </div>

                <div class="emailList_list">

    <%
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
                ResultSet resultSet = statement.executeQuery("select * from inbox where toMail = '" + sharedInbox + "' order by mailId desc");
                while (resultSet.next()){
                    int mailId = resultSet.getInt("mailId");
                    String fromMail = resultSet.getString("fromMail");
                    Timestamp timestamp = resultSet.getTimestamp("time_stamp");
                    String date = timestamp.toString();
                    String content = resultSet.getString("content");
    %>

                    <div class="emailRow">
                        <h3 class="emailRow_id">
                            <%=fromMail%>
                        </h3>
                        <div class="emailRow_mail">
                            <%--                                <h3><%=toMail%></h3>--%>
                            <h3><%=date%></h3>
                        </div>
                        <div class="emailRow_message">
                            <h4><%=content%></h4>
                        </div>
                    </div>

    <%
                }
                statement.close();
            }
            catch (SQLException e){
                System.out.println(e.getMessage());
            }
        }
    %>
        </div>
    </div>
</div>

<div class="popup">
    <div class="popup-content">

        <div class="close" onclick="closeCompose()">+</div>

        <div class="create_account">
            <h1>Compose Email</h1>
        </div>

        <div>
            <form class="send" action="ComposeMailServlet" method="post">

                <div class="toMail">
                    <label>To</label>
                    <input type="email" name="to" placeholder="Email" />
                </div>
                <div class="send-message">
                    <label for="">Message</label>
                    <input type="text" name="content" placeholder="Enter message" />
                </div>

                <div class="btn">
                    <button type="submit">
                    <span class="material-icons">
                      near_me
                    </span>
                        Send
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<div class="share-inbox">
    <div class="share-inbox-content">

        <div class="close" onclick="closeShareInbox()">+</div>

        <div class="create_account">
            <h1>Share Inbox</h1>
        </div>

        <div>
            <form class="send" action="ShareInboxServlet" method="post">

                <div class="toMail">
                    <label>Share With</label>
                    <input type="email" name="receiver" id="" placeholder="Email" />
                </div>

                <div class="btn">
                    <button type="submit">
                      <span class="material-icons">
                        person_add
                      </span>
                        &nbsp;Share
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<%
    if (statusMessage != null){
        if (status.equals("success")){
%>
           <div class="successNotification">
                <div class="successNotification-content">

                    <div class="close" onclick=closeSuccessNotification()>+</div>

                    <div class="successNotification-status">
                        <h1>Success</h1>
                    </div>

                    <div class="successMessage">
                        <h3><%=statusMessage%></h3>
                        <div class="btn">
                            <button onClick=closeSuccessNotification()>
                                OK
                            </button>
                        </div>
                    </div>
                </div>
            </div>

<%
        }
        else if (status.equals("failure")){
%>
            <div class="warningNotification">
                <div class="warningNotification-content">

                    <div class="close" onclick=closeWarningNotification()>+</div>

                    <div class="warningNotification-status">
                        <h1>Warning</h1>
                    </div>

                    <div class="warningMessage">
                        <h3><%=statusMessage%></h3>
                        <div class="btn">
                            <button onClick=closeWarningNotification()>
                                OK
                            </button>
                        </div>
                    </div>
                </div>
            </div>
<%
        }
        else if (status.equals("confirmDelete")){
%>
            <div class="warningNotificationDelete">
                <div class="warningNotification-content">

                    <div class="close" onclick=closeWarningNotificationDelete()>+</div>

                    <div class="warningNotification-status">
                        <h1>Warning</h1>
                    </div>

                    <div class="warningMessage">
                        <h3><%=statusMessage%></h3>
                        <div class="btn">
                            <button class="cancel" onClick=closeWarningNotificationDelete()>
                                Cancel
                            </button>
                            <a href=<%=deletionCommand%>>
                                <button class="confirm">
                                    Confirm
                                </button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
<%
        }
        session.setAttribute("statusMessage", null);
    }
%>

<%--    <script src="script.js"></script>--%>
    <script src="script1.js"></script>
</body>
</html>
