<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

    String query1 = "select * from student";
    Statement st1 = con.createStatement();
    ResultSet rs1 = st1.executeQuery(query1);
%>


<div class="container">
    <div class="clearfix annie_effect">
        <h2>Mark Attendance</h2>
        <table class="table table-bordered">
            <thead style="color: white;">
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Total Classes</th>
                    <th>Attended Classes</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody style="color: white;">
                <%  while (rs1.next()) {%>
            <form method="post" action="Action?updateattendance=true" name="a<%=rs1.getString("studentid")%>" >



                <%
                    int tc = 0, ca = 0;
                    String query2 = "select * from attendance where studentusername = '" + rs1.getString("username") + "' and subject='" + session.getAttribute("subject") + "'";
                    Statement st2 = con.createStatement();
                    ResultSet rs2 = st2.executeQuery(query2);
                    if (rs2.next()) {
                        tc = rs2.getInt(3);
                        ca = rs2.getInt(4);
                    } else {

                    }
                %>

                <tr>
                <input type="hidden" name="studentid" value="<%=rs1.getString("studentid")%>" />
                <input type="hidden" name="username" value="<%=rs1.getString("username")%>" />
                <td><%=rs1.getString("studentid")%></td>
                <td><%=rs1.getString("username")%></td>
                <td><input type="text" class="form-control" name="totalclasses" value="<%=tc%>"/></td>
                <td><input type="text" class="form-control" name="classesattended"  value="<%=ca%>"/></td>
                <td><input type="submit" value="Update" class="btn btn-primary"/></td>
                </tr>

            </form>
            <%}%>
            </tbody>
        </table>
    </div>
    <br>
    <div class="clearfix annie_effect">
        <h2>Add Subject File</h2>
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
                    <input type="submit" class="btn btn-default" value="Add File">
                </div>
            </div>
        </form>
        <br>

        <%
            String query = "select * from files where subject='" + session.getAttribute("subject") + "'";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);
        %>

        <table class="table table-hover">
            <thead style="color: white;">
                <tr>
                    <th>Subject</th>
                    <th>File Title</th>
                    <th>File Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody style="color: white;">
                <%  while (rs.next()) {%>
                <tr>
                    <td><%=rs.getString("subject")%></td>
                    <td><%=rs.getString("filetitle")%></td>
                    <td><%=rs.getString("filename")%></td>
                    <td>
                        <a class="btn btn-primary" href="files/<%=rs.getString("filename")%>" target="_blank">Open File</a>
                        <a class="btn btn-danger" href="Action?deletefile=true&subject=<%=rs.getString("subject")%>&filetitle=<%=rs.getString("filetitle")%>">Delete File</a></td>
                </tr>
                <%}%>
            </tbody>
        </table>
    </div>
</div>

<br>
<br>
<br>