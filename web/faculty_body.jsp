<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<div class="container">
    <div class="row">
        <h2>Add Subject File</h2>
    </div>
    <hr>
    <form class="form-horizontal" action="Action?addfile=true" method="post">
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-4">File Title:</label>
            <div class="col-md-6 col-sm-6">
                <input type="text" class="form-control" name="filetitle" placeholder="Enter File Title" required>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-4">File Name:</label>
            <div class="col-md-6 col-sm-6">
                <input type="text" class="form-control" name="filename" placeholder="Enter File Name" required>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-4"></label>
            <div class="col-md-6 col-sm-6">
                <input type="submit" class="btn" value="Add File">
            </div>
        </div>
    </form>
    <br>

    <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

        String query = "select * from files where subject='" + session.getAttribute("subject") + "'";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(query);
    %>

    <table class="table table-hover">
        <thead>
            <tr>
                <th>Subject</th>
                <th>File Title</th>
                <th>File Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%  while (rs.next()) {%>
            <tr>
                <td><%=rs.getString("subject") %></td>
                <td><%=rs.getString("filetitle") %></td>
                <td><%=rs.getString("filename") %></td>
                <td>
                    <a class="btn btn-primary" href="files/<%=rs.getString("filename") %>" target="_blank">Open File</a>
                    <a class="btn btn-danger" href="Action?deletefile=true&subject=<%=rs.getString("subject") %>&filetitle=<%=rs.getString("filetitle") %>">Delete File</a></td>
            </tr>
            <%}%>
        </tbody>
    </table>

</div>