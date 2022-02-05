package userServlets;

import dao.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/userEditServlet")
public class userEditServlet extends HttpServlet {
Connection con;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("loggedUser");
if(username!=null){
        try {
   DbConnection db = new DbConnection();
            con = db.getConnection();
 
            String oldPass = request.getParameter("oldPass");
            String query = "SELECT BINARY COUNT(*) FROM user WHERE username=? AND password=?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, oldPass);

            ResultSet rsVerifyUser = pst.executeQuery();
            rsVerifyUser.next();

            if (rsVerifyUser.getInt(1) > 0) {
                //String usernameNew = request.getParameter("username");
                String fName = request.getParameter("f_name");
                String lName = request.getParameter("l_name");
                String pNo = request.getParameter("p_no");
                query = "UPDATE user SET f_name=?, l_name=? , phone_no=? WHERE username=?";
                PreparedStatement ps = con.prepareStatement(query);
                //ps.setString(1, usernameNew);
                ps.setString(1, fName);
                ps.setString(2, lName);
                ps.setString(3, pNo);
                ps.setString(4, username);
                ps.executeUpdate();

                session.setAttribute("err", "notExist");
                session.setAttribute("time", LocalTime.now().truncatedTo(ChronoUnit.MINUTES));
                response.sendRedirect("userEdit.jsp");

            }else{
                session.setAttribute("err", "exist");
                session.setAttribute("time", LocalTime.now().truncatedTo(ChronoUnit.MINUTES));
                response.sendRedirect("userEdit.jsp");
            }
        } catch (SQLException e) {
            session.setAttribute("err", "exist");
            session.setAttribute("time", LocalTime.now().truncatedTo(ChronoUnit.MINUTES));
            response.sendRedirect("userEdit.jsp");
        }
            }else{
         response.sendRedirect("error.html");
     }

    }
}
