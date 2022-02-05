package userServlets;

import dao.DbConnection;
import dao.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    Connection con;
    String log;
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("string");
        
        DbConnection db=new DbConnection();
        con=db.getConnection();
        
        String user=request.getParameter("username");
        String pass=request.getParameter("password") ;
        
        try {
            //first check whether the login is by admin
            String query = "SELECT username FROM admin WHERE username=? AND password =?";
            PreparedStatement pt = con.prepareStatement(query);
            pt.setString(1,user);
            pt.setString(2,pass);
            ResultSet rs = pt.executeQuery();
            
            //if it's admin, provide permissions
            if(rs.next()){
                //log="1";
                response.sendRedirect("adminPanel.jsp");
                
                HttpSession session = request.getSession();
                session.setAttribute("loggedUser",user);
                session.setAttribute("role","ADMIN" );
            }else{
                //or check whether its a user
                String queryUser = "SELECT email FROM user WHERE username=? AND password=?";
                PreparedStatement ptUser = con.prepareStatement(queryUser);
                ptUser.setString(1,user);
                ptUser.setString(2,pass); 
                ResultSet rsUser = ptUser.executeQuery();

                //if it's user, provide permissions
                if (rsUser.next()) { 
                    //log="1";
                    response.sendRedirect("adPost.jsp");
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("loggedUser",user);
                    session.setAttribute("role","USER");    
                    
                //when user and password doesn't match both table
                } else {
                    //log="0"; 
                    PrintWriter out=response.getWriter();
                    response.sendRedirect("login.jsp?er="+"er");
                    
//                    out.println("<script>window.location='login.html';</script>");
//                    out.println("<script>foot.innerHTML=`<h1>fhdgjfd</h1>`</script>");
                }               
            }   
        } catch (Exception e) {
           e.printStackTrace();
        } 
    }
}
