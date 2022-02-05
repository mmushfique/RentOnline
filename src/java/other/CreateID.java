package other;




import dao.DbConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.swing.JOptionPane;

public class CreateID {
    Connection con;
       
    public CreateID(){
       DbConnection db=new DbConnection();
       con=db.getConnection();
       
    }
    
    public String getID(String cat){
        String id=null;
       //if( new String(cat).equals("Room")){
        if(cat.equals("Room")){
                try{
                    String query="SELECT MAX(ad_id) FROM room_ad";
                    PreparedStatement ps=con.prepareStatement(query);
                    ResultSet rs = ps.executeQuery();
                    rs.next();
                    id=rs.getString("MAX(ad_id)");

                    if(id!=null){
                        int increase=Integer.parseInt(id.substring(2));
                        increase+=1;
                        id="R-" +String.format("%08d",increase);
                    }
                    else{
                        id="R-00000001";
                    }
                }
                catch(Exception e){
                    JOptionPane.showMessageDialog(null,e);
                }
        }else if(cat.equals("House")){
                try{
                   String query="SELECT MAX(ad_id) FROM house_ad";
                   PreparedStatement ps=con.prepareStatement(query);
                   ResultSet rs = ps.executeQuery();
                   rs.next();
                   id=rs.getString("MAX(ad_id)");

                   if(id!=null){
                       int increase=Integer.parseInt(id.substring(2));
                       increase+=1;
                       id="H-" +String.format("%08d",increase);
                   }
                   else{
                       id="H-00000001";
                   }
                }
                catch(Exception e){
                   JOptionPane.showMessageDialog(null,e);
                }
           
        }else{        

                try{
                   String query="SELECT MAX(ad_id) FROM shop_ad";
                   PreparedStatement ps=con.prepareStatement(query);
                   ResultSet rs = ps.executeQuery();
                   rs.next();
                   id=rs.getString("MAX(ad_id)");

                   if(id!=null){
                       int increase=Integer.parseInt(id.substring(2));
                       increase+=1;
                       id="S-" +String.format("%08d",increase);
                   }
                   else{
                       id="S-00000001";
                   }
                }
                catch(Exception e){
                   JOptionPane.showMessageDialog(null,e);
                }
            
            }
        return id;
    }
    
}
