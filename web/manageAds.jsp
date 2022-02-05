<%response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.DbConnection"%>
<%
    HttpSession se = request.getSession();
    String user = (String) se.getAttribute("loggedUser");
    String role = (String) se.getAttribute("role");
    String query = "";
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
                                    query = "SELECT COUNT(*) FROM user";
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
                                    query = "SELECT COUNT(*) FROM advertisement";
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
                                    query = "SELECT COUNT(*) FROM advertisement WHERE status='1'";
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
                                    query = "SELECT COUNT(*) FROM report";
                                    r = st.executeQuery(query);
                                    r.next();
                                %>
                                <span class="font-bold text-title"><%=r.getInt(1)%></span>
                            </div>
                        </div>
                    </div>

                    <br><br>
                    <!----------------------------------------------------------------------------------------------------------->

                    <center>
                        <h1>Manage Ads</h1>
                        <br>
                        <div class="search" style="display:flex;margin-left:300px ">
                            <form class="form-inline" action="manageAds.jsp" method="post">
                                <div>
                                    <input type="text" placeholder="Search by adID" name="search">
                                    <button type="submit"><i class="fa fa-search"></i></button>
                                </div>
                            </form>
                            <form class="form-inline" action="manageAds.jsp" method="post">
                                <div>
                                    <input  name="all" hidden>
                                    <button style="background:green" type="submit" >View All</button>
                                </div>
                            </form>
                        </div>
                        <br>
                    </center>
                    <div class="container" style="margin-left: 100px">
                        <div class="inner">
                            <div class="row">
                                <div class="col-md-3">

                                    <form action="manageAdsServlet" method="post" class="frm">
                                        <div class="search">
                                            <%
                                                if (request.getParameter("id") != null) {
                                                    String ad_id = request.getParameter("id");
                                                    ResultSet rs = st.executeQuery("SELECT * FROM advertisement WHERE ad_id='" + ad_id + "'");
                                                    while (rs.next()) {
                                            %>
                                            <h3 class="mb-4 text-center"> Activate/Deactivate Ads</h3>
                                            <br>
                                            <label>Ad id
                                            <input required name="ad_id" value='<%=  rs.getString(1)%>'  readonly></label>
                                            <br><br>
                                            <label>Post owner
                                            <input   required name="username" value='<%=  rs.getString("username")%>' readonly></label>
                                        </div>
                                        <div class="form-group">
                                            <br><br>
                                            <label>Check to make active</label>&nbsp;
                                            <input type="checkbox" name="status" <%  if (rs.getBoolean(9) == true) {%> checked="checked"   <%}%>">
                                        </div>
                                        <br>
                                        <button name="btnUpd" id="btnpd" type="submit" >UPDATE</button>
                                         <br><br>
                                        

                                        <%
                                                }//while
                                            }//if
                                        %>


                                    </form>

                                </div>

                                <div class="col-md-2"></div>
                                <div class="col-md-6">
                                    <h3 class="text-center">Advertisements information</h3>
                                    <table class="styled-table">
                                        <thead class="bg-light">
                                            <tr>

                                                <th scope="col" style="min-width: 120px">Ad id</th>
                                                <!--<th scope="col">Enable/Disable</th>-->
                                                <th scope="col" style="min-width: 100px">Post owner</th>
                                                <th scope="col" style="min-width: 100px">Report count</th>
                                                <th scope="col" style="min-width: 100px">Active/Inactive</th>
                                                <th scope="col" style="min-width: 100px">Edit</th>
                                                <th scope="col" style="min-width: 100px">Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <!--Display the advertisements
                                            
                                            details in the table-->
                                            <%
                                                String q = "SELECT * FROM advertisement LEFT JOIN (SELECT ad_id,COUNT(*) FROM report GROUP BY ad_id) AS report ON advertisement.ad_id=report.ad_id";
                                                /////////
                                                if (request.getParameter("search") != null) {
                                                    String search = request.getParameter("search");
                                                    if (request.getParameter("all") == null) {
                                                        q += " WHERE advertisement.ad_id='" + search + "'";
                                                    }
                                                }
                                                //////////////
                                                ResultSet rs = st.executeQuery(q);
                                                while (rs.next()) {
                                            %>
                                            <tr>
                                                <td><%= rs.getString("ad_id")%></td>
                                                <td><%= rs.getString("username")%> </td>
                                                <td><%=rs.getInt(11)%></td> 
                                                <td><% if (rs.getBoolean("status")) {%>
                                                    Active
                                                    <%
                                                    } else {
                                                    %>
                                                    Inactive
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td><a href='manageAds.jsp?id=<%=rs.getString("ad_id")%>'>Edit</a> </td>
                                                <td><a href='manageAdsServlet?id=<%=rs.getString("ad_id")%>'>Delete</a> </td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!--------------------------------------------------------------------->




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