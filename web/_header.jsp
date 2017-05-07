<style>
    .annie_effect{
        background: rgba(0,0,0,0.4);
        padding: 17px;
        margin-top: 40px;
        border-radius: 2px;
        color: white;
        border:1px white solid;
        box-shadow: 0 0 15px black;
        transition: box-shadow 1s ease;
    }
    
    body{
        background-attachment: fixed;
        background-image: url(files/background.jpg);
        
    }
    
</style>

<nav class="navbar navbar-default " style="    background-color: rgba(255,255,255,0.6);
    border: 1px white solid;
    box-shadow: 0 0 15px black;
    border-radius: 0px;">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand">Virtual Classroom</a>
        </div>

        <div class="navbar-default">
            <ul class="nav navbar-nav">
                <li class="active"><a href="index.jsp">Home</a></li>
            </ul>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Happy Search... :)">
                </div>
                <button type="button" class="btn btn-default">Search</button>
            </form>
            <ul class="nav navbar-nav navbar-right">
                <%
                    if (session.getAttribute("fullname") == null) {
                %>
                <li><a href="signup.jsp">Student Register</a></li>
                <li><a href="login.jsp">Login</a></li>
                    <%
                    } else if (session.getAttribute("username").equals("admin")) {
                    %> 
                <li><a href="faculty.jsp">Welcome <%=session.getAttribute("fullname")%></a></li>
                <li><a href="addfaculty.jsp">Add Faculty</a></li>
                <li><a href="logout.jsp">Logout</a></li>
                    <%
                    } else if (session.getAttribute("user").equals("faculty")) {
                    %>
                <li><a href="faculty.jsp">Welcome <%=session.getAttribute("fullname")%></a></li>
                <li><a href="logout.jsp">Logout</a></li>
                    <%
                    } else if (session.getAttribute("user").equals("student")) {
                    %>
                <li><a href="student.jsp">Welcome <%=session.getAttribute("fullname")%></a></li>
                <li><a href="logout.jsp">Logout</a></li>
                    <%
                        }
                    %>
            </ul>
        </div>
    </div>
</nav>
