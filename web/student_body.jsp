<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<div class="container">
    <div class="row">
        <div class="panel panel-default">
            <div class="panel-heading">Attendance Details</div>
            <div class="panel-body">Details---------</div>
        </div>
    </div>

    <br>


    <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

        String query = "select * from files order by subject";
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
                <td><%=rs.getString("subject")%></td>
                <td><%=rs.getString("filetitle")%></td>
                <td><%=rs.getString("filename")%></td>
                <td>
                    <a class="btn btn-primary" href="files/<%=rs.getString("filename")%>" target="_blank">Open File</a>
            </tr>
            <%}%>
        </tbody>
    </table>
</div>
