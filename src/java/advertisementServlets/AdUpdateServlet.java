/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package advertisementServlets;

import dao.DbConnection;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author user
 */
@WebServlet("/AdUpdateServlet")
public class AdUpdateServlet extends HttpServlet {
     Connection con;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession se = request.getSession();
         String user= (String)se.getAttribute("loggedUser");
 if(user!=null){
        String loc = request.getParameter("loc");
        String title = request.getParameter("title");
        int rent = Integer.parseInt(request.getParameter("rent"));
        int area = Integer.parseInt(request.getParameter("area"));
        String desc = request.getParameter("desc");
        String type = "";
PrintWriter out = response.getWriter();
           
        String id = request.getParameter("id");
        try {
            DbConnection db = new DbConnection();
            con = db.getConnection();
            Statement ps=con.createStatement();
             String query = "";

            query="SELECT * from advertisement WHERE ad_id='"+id+"' AND username='"+user+"'";
            ResultSet rs=ps.executeQuery(query);
            if(rs.next()){
            
            if (request.getParameter("room")!=null) {
                int room =Integer.parseInt(request.getParameter("room"));
                String furnished = request.getParameter("furnished");
                query = "UPDATE advertisement,house_ad SET title='"+title+"', location='"+loc+"', description='"+desc+"', property_area='"+area+"', rent='"+rent+"', furnished_status='"+furnished+"', rooms='"+room+"' WHERE advertisement.ad_id='"+id+"' AND house_ad.ad_id='"+id+"'";
            } else if (request.getParameter("bed")!=null) {
                int bed = Integer.parseInt(request.getParameter("bed"));
                String furnished = request.getParameter("furnished");
                query = "UPDATE advertisement,room_ad SET title='"+title+"', location='"+loc+"', description='"+desc+"', property_area='"+area+"', rent='"+rent+"', furnished_status='"+furnished+"', beds='"+bed+"' WHERE advertisement.ad_id='"+id+"' AND room_ad.ad_id='"+id+"'";
                ps = con.prepareStatement(query);
            } else {
                String dimension = request.getParameter("dimension");
                query = "UPDATE advertisement,shop_ad SET title='"+title+"', location='"+loc+"', description='"+desc+"', property_area='"+area+"', rent='"+rent+"',dimension='"+dimension+"' WHERE advertisement.ad_id='"+id+"' AND shop_ad.ad_id='"+id+"'";
                ps = con.prepareStatement(query);
            }
            ps.executeUpdate(query);
///////////////////////////////images//////////////////////////////////////
//            String dir=dir="adImages";
//        //int flag=0;
//        String savepath="/C:/Users/mmush/Documents/NetBeansProjects/RentOnline/web" + File.separator + dir;
//        File file=new File(savepath);
//        
//        if(!file.exists()){
//            file.mkdir();
//        }
//        String filename="";
//
//       List <Part> fileParts = request.getParts().stream().filter(part->"file".equals(part.getName())).collect(Collectors.toList());
//       for(Part filepart:fileParts){
//           filename=Paths.get(filepart.getSubmittedFileName()).getFileName().toString();
//           filepart.write(savepath + File.separator+id+"-"+filename);
//           String img_id=id+"-"+filename;
//           String img_path=dir+"/"+img_id;
//           String queryImg ="UPDATE ad_img SET img_id='"+img_id+"',img_path='"+img_path+"' WHERE ad_id='"+id+"'";
//           Statement st = con.createStatement();  
//           st.executeUpdate(queryImg);
//       }

            //////////////////////////
            response.sendRedirect("adEdit.jsp");
        }
        } catch (Exception e) {
            
            out.print(e);
        }
        
         }else{
         response.sendRedirect("error.html");
     }
        
    }
}
