
package advertisementServlets;

import dao.DbConnection;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Statement;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.swing.JOptionPane;
import other.CreateID;

/**
 *
 * @author user
 */
@WebServlet("/adPost")
@MultipartConfig(maxFileSize=16177215)
public class AdPostServlet extends HttpServlet {

    Connection con;
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out =response.getWriter();
         HttpSession se = request.getSession();
        String user = (String) se.getAttribute("loggedUser");
        if(user!=null){
        
                String cat = request.getParameter("cat");
        CreateID crID = new CreateID();

        String ad_id = crID.getID(cat.toString());

        String title = request.getParameter("title");
        String loc = request.getParameter("loc");
        String desc = request.getParameter("desc");
        int area = Integer.parseInt(request.getParameter("area"));
        int rent = Integer.parseInt(request.getParameter("rent"));

       

        try {
            DbConnection db = new DbConnection();
            con = db.getConnection();
            String query = "";
            Statement st = con.createStatement();       
            
            String queryCom = "INSERT INTO advertisement VALUES('" + ad_id + "',current_timestamp(),'" + title + "','" + loc + "','" + desc + "'," + area + "," + rent + ",'" + user + "',"+0+")";
            st.executeUpdate(queryCom);
            
            
            if (request.getParameter("room") != null) {
                int room = Integer.parseInt(request.getParameter("room"));
                String furnished = request.getParameter("furnished");
                query = "INSERT INTO house_ad VALUES('" + ad_id + "','" + room + "','" + furnished + "')";
            } else if (request.getParameter("bed") != null) {
                int bed = Integer.parseInt(request.getParameter("bed"));
                String furnished = request.getParameter("furnished");
                query = "INSERT INTO room_ad VALUES('" + ad_id + "','" + bed + "','" + furnished + "')";
            } else {
                String dimension = request.getParameter("dimension");
                query = "INSERT INTO shop_ad VALUES('" + ad_id + "','" + dimension + "')";
            }
            st.executeUpdate(query);
            ///////////////////////////////images//////////////////////////////////////
            String dir=dir="adImages";
        //int flag=0;
        String savepath="/C:/Users/mmush/Documents/NetBeansProjects/RentOnline/web" + File.separator + dir;
        File file=new File(savepath);
        
        if(!file.exists()){
            file.mkdir();
        }
        String filename="";

       List <Part> fileParts = request.getParts().stream().filter(part->"file".equals(part.getName())).collect(Collectors.toList());
       for(Part filepart:fileParts){
           filename=Paths.get(filepart.getSubmittedFileName()).getFileName().toString();
           filepart.write(savepath + File.separator+ad_id+"-"+filename);
           String img_id=ad_id+"-"+filename;
           String img_path=dir+"/"+img_id;
           String queryImg = "INSERT INTO ad_img VALUES('"+img_id+"','"+img_path+"','"+ad_id+"')";
           st.executeUpdate(queryImg);
       }

            //////////////////////////
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            out.print(e);
        }
   }else{
         response.sendRedirect("error.html");
     }
    }
}