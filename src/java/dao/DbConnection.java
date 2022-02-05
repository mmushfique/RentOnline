package dao;
import java.sql.*;
import javax.swing.JOptionPane;
public class DbConnection {
    private static Connection con; 
    public static Connection getConnection(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/projectdb","root","");
        }catch(Exception e){
            e.printStackTrace();
        }
        return con;
    }
}

