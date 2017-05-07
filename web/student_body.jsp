<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<div class="container">
    <div class="row annie_effect">
        <h2>Attendance Details</h2>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

            String query2 = "select * from faculty";
            Statement st2 = con.createStatement();
            ResultSet rs2 = st2.executeQuery(query2);
        %>
        <table class="table table-bordered">
            <thead style="color: white;">
                <tr>
                    <th>Subject Name</th>
                    <th>Faculty Name</th>
                    <th>Total Classes</th>
                    <th>Attended Classes</th>
                </tr>
            </thead>
            <tbody style="color: white;">
                <%  while (rs2.next()) {%>

                <%
                    String tc = "Unmarked", ca = "Unmarked";
                    String query1 = "select * from attendance where studentusername='" + session.getAttribute("username") + "' and subject='" + rs2.getString("subject") + "'";
                    Statement st1 = con.createStatement();
                    ResultSet rs1 = st1.executeQuery(query1);
                    if (rs1.next()) {
                        tc = rs1.getString("totalclasses");
                        ca = rs1.getString("classesattended");
                    }
                %>
                <tr>
                    <td><%=rs2.getString("subject")%></td>
                    <td><%=rs2.getString("fullname")%></td>
                    <td><%=tc%></td>
                    <td><%=ca%></td>
                </tr>

                </form>
                <%}%>
            </tbody>
        </table>


    </div>

    <%
        String query = "select * from files order by subject";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(query);
    %>


    <br>
    <div class="row annie_effect">
        <h2>Subject Files</h2>
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
                </tr>
                <%}%>
            </tbody>
        </table>
    </div>
</div>
            <br>
            <br>
            <br>