
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Action extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();

        if (request.getParameter("studentlogin") != null) {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

                String query = "select fullname from student where username='" + username + "' and password='" + password + "'";
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(query);

                if (rs.next()) {
                    session.setAttribute("fullname", rs.getString("fullname"));
                    session.setAttribute("username", username);
                    session.setAttribute("user", "student");
                    response.sendRedirect("student.jsp");
                } else {
                    out.println("<script>alert('Error in Signin')</script>");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.include(request, response);
                }
            } catch (Exception ex) {
            }
        }

        if (request.getParameter("facultylogin") != null) {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

                String query = "select fullname, subject from faculty where username='" + username + "' and password='" + password + "'";
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(query);
                System.out.println(query);
                if (rs.next()) {
                    session.setAttribute("fullname", rs.getString("fullname"));
                    session.setAttribute("subject", rs.getString("subject"));
                    session.setAttribute("username", username);
                    session.setAttribute("user", "faculty");
                    response.sendRedirect("faculty.jsp");
                } else {
                    out.println("<script>alert('Error in Signin')</script>");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.include(request, response);
                }
            } catch (Exception ex) {
            }
        }

        if (request.getParameter("registerstudent") != null) {
            try {
                String fullname = request.getParameter("fullname");
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String studentid = request.getParameter("studentid");
                String phonenumber = request.getParameter("phonenumber");
                String dob = request.getParameter("dob");
                String address = request.getParameter("address");
                String fathersname = request.getParameter("fathersname");
                String mothersname = request.getParameter("mothersname");

                System.out.println(phonenumber);
//                try {
//                    Integer.parseInt(phonenumber);
//                } catch (Exception e) {
//                    out.print("<script>alert('Please Check Phone Number')</script>");
//                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
//                    rd.include(request, response);
//                    return;
//                }

                try {
                    Integer.parseInt(studentid);
                } catch (Exception e) {
                    out.print("<script>alert('Please Check Student ID')</script>");
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                    rd.include(request, response);
                    return;
                }

                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

                String query = "insert into student (username, password, studentid, fullname, email, phonenumber, dob, address, fathersname, mothersname) values('"
                        + username + "', '" + password + "', " + studentid + ", '" + fullname + "', '" + email + "', '" + phonenumber + "', '" + dob + "', '" + address + "', '" + fathersname + "', '" + mothersname + "')";

                System.out.println(query);

                Statement st = con.createStatement();
                try {
                    st.executeUpdate(query);
                    out.print("<script>alert('Successfully Registered as Student, Now you can login')</script>");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.include(request, response);
                    return;
                } catch (Exception e) {
                    out.print("<script>alert('Error in Signup')</script>");
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                    rd.include(request, response);
                    return;
                }
            } catch (Exception ex) {
            }
        }

        if (request.getParameter("registerfaculty") != null) {
            if (session.getAttribute("username").equals("admin")) {

                try {
                    String fullname = request.getParameter("fullname");
                    String username = request.getParameter("username");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String facultyid = request.getParameter("facultyid");
                    String phonenumber = request.getParameter("phonenumber");
                    String address = request.getParameter("address");
                    String subject = request.getParameter("subject");

//                    try {
//                        Integer.parseInt(phonenumber);
//                    } catch (Exception e) {
//                        out.print("<script>alert('Please Check Phone Number')</script>");
//                        RequestDispatcher rd = request.getRequestDispatcher("addfaculty.jsp");
//                        rd.include(request, response);
//                        return;
//                    }
                    try {
                        Integer.parseInt(facultyid);
                    } catch (Exception e) {
                        out.print("<script>alert('Please Check Faculty ID')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("addfaculty.jsp");
                        rd.include(request, response);
                        return;
                    }

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

                    String query = "insert into faculty (username, password, facultyid, fullname, email, phonenumber, address, subject) values('"
                            + username + "', '" + password + "', " + facultyid + ", '" + fullname + "', '" + email + "', '" + phonenumber + "', '" + address + "', '" + subject + "')";

                    System.out.println(query);

                    Statement st = con.createStatement();
                    try {
                        st.executeUpdate(query);
                        out.print("<script>alert('Successfully Registered as Faculty, Now the faculty can login')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("addfaculty.jsp");
                        rd.include(request, response);
                        return;
                    } catch (Exception e) {
                        out.print("<script>alert('Error in Signup')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("addfaculty.jsp");
                        rd.include(request, response);
                        return;
                    }
                } catch (Exception ex) {
                }
            }
        }

        if (request.getParameter("addfile") != null) {
            if (session.getAttribute("user").equals("faculty")) {
                try {
                    String filetitle = request.getParameter("filetitle");
                    String filename = request.getParameter("filename");
                    String subject = (String) session.getAttribute("subject");

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

                    String query = "INSERT INTO files (filetitle, filename, subject) VALUES ('" + filetitle + "','" + filename + "','" + subject + "')";
                    System.out.println(query);

                    Statement st = con.createStatement();
                    try {
                        st.executeUpdate(query);
                        out.print("<script>alert('Successfully added a File')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("faculty.jsp");
                        rd.include(request, response);
                    } catch (Exception e) {
                        out.print("<script>alert('Error in Adding a File')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("faculty.jsp");
                        rd.include(request, response);
                    }
                } catch (Exception ex) {
                }
            }
        }

        if (request.getParameter("updateattendance") != null) {
            if (session.getAttribute("user").equals("faculty")) {
                try {
                    String studentid = request.getParameter("studentid");
                    String totalclasses = request.getParameter("totalclasses");
                    String classesattended = request.getParameter("classesattended");
                    String subject = (String) session.getAttribute("subject");
                    String studentusername = request.getParameter("username");

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

                    String query = "INSERT INTO attendance (studentid, subject, totalclasses, classesattended, studentusername) VALUES (" + studentid + ",'" + subject + "'," + totalclasses + "," + classesattended + ",'" + studentusername + "' )";
                    System.out.println(query);

                    Statement st = con.createStatement();
                    try {
                        st.executeUpdate(query);
                        out.print("<script>alert('Successfully Updated')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("faculty.jsp");
                        rd.include(request, response);
                    } catch (Exception e) {
                        query = "update attendance set  totalclasses = " + totalclasses + ",classesattended=" + classesattended + " where studentusername='" + studentusername + "' and subject='" + subject + "'";
                        System.out.println(query);

                        st = con.createStatement();
                        try {
                            st.executeUpdate(query);
                            out.print("<script>alert('Successfully Updated')</script>");
                            RequestDispatcher rd = request.getRequestDispatcher("faculty.jsp");
                            rd.include(request, response);
                        } catch (Exception re) {
                            out.print("<script>alert('Error in Updating')</script>");
                            RequestDispatcher rd = request.getRequestDispatcher("faculty.jsp");
                            rd.include(request, response);
                        }
                    }
                } catch (Exception ex) {
                }
            }
        }

        if (request.getParameter("deletefile") != null) {
            if (session.getAttribute("user").equals("faculty")) {
                try {
                    String filetitle = request.getParameter("filetitle");
                    String subject = (String) session.getAttribute("subject");

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualclass", "root", "root");

                    String query = "delete from files where filetitle='" + filetitle + "' and subject = '" + subject + "'";

                    Statement st = con.createStatement();
                    try {
                        st.executeUpdate(query);
                        out.print("<script>alert('Successfully deleted a File')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("faculty.jsp");
                        rd.include(request, response);
                    } catch (Exception e) {
                        out.print("<script>alert('Error in Deleting File')</script>");
                        RequestDispatcher rd = request.getRequestDispatcher("faculty.jsp");
                        rd.include(request, response);
                    }
                } catch (Exception ex) {
                }
            }
        }

        if (request.getParameter("address") != null) {
        }

        if (request.getParameter("order_history") != null) {
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
