<%response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.DbConnection"%>
<%
    HttpSession se = request.getSession();
    String user = (String) se.getAttribute("loggedUser");
    String role = (String) se.getAttribute("role");
    String query="";
    if (role != null && role.equals("ADMIN")) {
        Connection con;
        DbConnection db = new DbConnection();
        con = db.getConnection();
        Statement st = con.createStatement();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="bootstrap icons/bootstrap-icons.css">
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"
    />
    
    <link rel="stylesheet" href="css/admin.css" />
    <link rel="stylesheet" href="css/adminPanel.css" />

    <title>Admin DASHBOARD</title>
  </head>
  <body id="body">
    <div class="container">
      <nav class="navbar">
        <div class="nav_icon" onclick="toggleSidebar()">
          <i class="fa fa-bars" aria-hidden="true"></i>
        </div>
        <div class="navbar__left">
          <a id="us" href="index.jsp">Home</a>
          <a class="active_link" href="adminPanel.jsp">Admin</a>
        </div>
        
      </nav>

      <main>
        <div class="main__container">
          <!-- MAIN TITLE STARTS HERE -->

          <div class="main__title">
            <img src="#" alt="" />
            <div class="main__greeting">
              <h1>Hello <%=user%></h1>
              <p>Welcome to your admin dashboard</p>
            </div>
          </div>

          <!-- MAIN TITLE ENDS HERE -->

          <!-- MAIN CARDS STARTS HERE -->
          <div class="main__cards">
            <div class="card">
              <i
                class="fa fa-user-o fa-2x text-lightblue"
                aria-hidden="true"
              ></i>
              <div class="card_inner">
                <p class="text-primary-p">Number of Registered users</p>
                <%
                query="SELECT COUNT(*) FROM user";
                ResultSet r = st.executeQuery(query);
                r.next();
                %>
                <span class="font-bold text-title"><%=r.getInt(1)%></span>
              </div>
            </div>

            <div class="card">
             <i class="fa fa-bell" aria-hidden="true"></i>
              <div class="card_inner">
                <p class="text-primary-p">Number of advertisements</p>
                <%
                query="SELECT COUNT(*) FROM advertisement";
                r = st.executeQuery(query);
                r.next();
                %>
                <span class="font-bold text-title"><%=r.getInt(1)%></span>
              </div>
            </div>

            <div class="card">
              <i 
                class="fa fa-thumbs-up fa-2x text-green"
                aria-hidden="true"
              ></i>
              <div class="card_inner">
                <p class="text-primary-p">Number of active advertisements</p>
                <%
                query="SELECT COUNT(*) FROM advertisement WHERE status='1'";
                r = st.executeQuery(query);
                r.next();
                %>
                <span class="font-bold text-title"><%=r.getInt(1)%></span>
              </div>
            </div>

            <div class="card">
                <i class="fa fa-flag" aria-hidden="true" ></i>
             
              <div class="card_inner">
                <p class="text-primary-p">Number of reported Ads</p>
                <%
                query="SELECT COUNT(*) FROM report";
                r = st.executeQuery(query);
                r.next();
                %>
                <span class="font-bold text-title"><%=r.getInt(1)%></span>
              </div>
            </div>
          </div>
              
              <br><br><br><br><br>

          <!-- CHARTS STARTS HERE -->
          <div class="charts">
            <div class="charts__left">
              <div class="charts__left__title">
                <div>
                  <h1>Daily Reports</h1>
                  <p>Rent Portal</p>
                </div>
<!--                <i class="fa fa-usd" aria-hidden="true"></i>-->
              </div>
              <div id="apex1"></div>
            </div>

            
          </div>
          <!-- CHARTS ENDS HERE -->
              
        </div>
      </main>
    
      <div id="sidebar">
        <div class="sidebar__title">
          <div class="sidebar__img">
            <img src="logo.png" alt="logo" />
            <h1>Rent Portal</h1>
          </div>
          <i
            onclick="closeSidebar()"
            class="fa fa-times"
            id="sidebarIcon"
            aria-hidden="true"
          ></i>
        </div>

        <div class="sidebar__menu">
          <div class="sidebar__link active_menu_link">
            <i class="fa fa-home"></i>
            <a href="adminPanel.jsp">Dashboard</a>
          </div>
          <h2>Manage</h2>
          <div class="sidebar__link">
            <i class="fa fa-user-secret" aria-hidden="true"></i>
            <a href="#">Admin Management</a>
          </div>
          <div class="sidebar__link">
            <i class="fa fa-building-o"></i>
            <a href="#">Website Management</a>
          </div>
          <div class="sidebar__link">
           <i class="fa fa-users" aria-hidden="true"></i>
            <a href="manageUsers.jsp">User Management</a>
          </div>
          <div class="sidebar__link">
            <i class="fa fa-archive"></i>
            <a href="manageAds.jsp">Advertisement Management</a>
          </div>
          <div class="sidebar__link">
            <i class="fa fa-book" aria-hidden="true"></i>
            <a href="report.jsp">View reports</a>
          </div>
          
          <div class="sidebar__logout">
            <i class="fa fa-power-off"></i>
            <a href="LogoutServlet">Log out</a>
          </div>
        </div>
      </div>
    </div>
    <footer id="footer">
            <jsp:include page="footer.html" />  
        </footer>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script src="js/adminPanel.js"></script>
    
        <%} else {
            String redirectURL = "/RentOnline/errorDis.html";
            response.sendRedirect(redirectURL);
        }%>
  </body>
</html>