<%response.setHeader("Cache-Control", "private, no-store, no-cache, must-revalidate");%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <title></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.1/font/bootstrap-icons.css">
               <link rel="stylesheet" href="css/common.css" />

    </head>


    <body>
        <header id="header">
            <jsp:include page="header.jsp" />  
        </header>
        <style>
            body{
    background :linear-gradient(351deg,#4158d0,#d62148);
}
            #btnChangePass {

                display: block;
            }

            h3 {
                width: 100%;
            }

            form>*:not(div) {
                margin: 10px;
            }

            .bi-x-lg {
                font-size: 30px;
                text-align: right;
                padding: 0 8px;
                border-radius: 50%;
                color: #fff;
                background-color: #0d6efd;
                width: fit-content;
                transition: all 0.2s linear;
                margin-left: auto;
                float: right;
            }

            .bi-x-lg:focus,
            .bi-x-lg:hover {
                background-color: #0b5ed7;
            }

            .popup {
                width: calc(100% - 80px);
                height: calc(100% - 80px);
                position: absolute;
                left: 50%;
                transform: translate(-50%, -50%);
                transition: all 0.5s linear;
                background-color: rgba(33, 37, 41, 0.7);
                z-index: 2;
            }

            body>div{
                  margin-top: 100px;
            }
            body{
    
                min-height: 100vh;
            }

            .popupActive {
                display:block;
                top: 50%;
                opacity: 1;
            }

            .popupInactive {
                display:none;
                opacity: 0;
                top: -200%;
            }

            .frmPassChange {
                height: 0;
                overflow: hidden;
                transition: height 0.2s ease;
            }

            #check:checked+.frmPassChange {
                height: 300px;
                padding: 20px;
            }

            @media screen and (min-width: 992px) {
                #check:checked+.frmPassChange {
                    height: 200px;
                }
            }
            .bi-x{
                width:fit-content;
                padding:0 5px;
            }
            .position-fixed{
                bottom:10px;
                right:10px;
                cursor:default;
                transition:transform 0.2s ease-in-out;
            }
            .position-fixed:focus,
            .position-fixed:hover{
                transform:scale(1.03);
            }
            .setError{
                color: #D8000C;
                background-color: #FFD2D2;
                padding: 0 5px;
            }
            .setNoError{
                color: #4F8A10;
                background-color: #DFF2BF;
                padding: 0 5px;
            }
        </style>
        <%
HttpSession sess = request.getSession();
String username = (String) sess.getAttribute("loggedUser");
String role = (String) sess.getAttribute("role");

if (role!=null && role.equals("USER")) {

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/projectdb", "root", "");

                String query = "SELECT * FROM user WHERE username=?";

                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, username);

                ResultSet rsUser = pst.executeQuery();

                while (rsUser.next()) {


        %>

        <div class="rounded bg-dark text-white  col-9 p-5 position-relative mx-auto">
            <form class="d-flex flex-wrap justify-content-around" id="frmChange" action="userEditServlet" method="post">
                <h3 class="text-center">Change Your Account Information</h3>
                <label for="username" class="col-12 col-lg-5">Username
                    <small class="float-end"></small>
                    <input style="text-transform: capitalize" class="form-control form-control-sm" type="text" id="username" name="username" value="<%= rsUser.getString("username")%>" readonly>
                </label>
                <label for="f_name" class="col-12 col-lg-5">First Name
                    <small class="float-end"></small>
                    <input class="form-control form-control-sm" type="text" id="f_name" name="f_name" value="<%= rsUser.getString("f_name")%>" >
                </label>
                <label for="l_name" class="col-12 col-lg-5">Last Name
                    <small class="float-end"></small>
                    <input class="form-control form-control-sm" type="text" id="l_name" name="l_name" value="<%= rsUser.getString("l_name")%>" >
                </label>
                <label for="p_no" class="col-12 col-lg-5">Phone Number
                    <small class="float-end"></small>
                    <input class="form-control form-control-sm" type="number" id="p_no" name="p_no" value="<%= rsUser.getString("phone_no")%>" >
                </label>
                <input type="button" value="Apply" name="triggerPass" class="btn btn-primary col-4 mx-auto">
                <div class="w-100 text-end">
                    Change Password
                    <label for="check" class="bi bi-chevron-down">
                    </label>
                </div>
            </form>
            <input type="checkbox" id="check" hidden>
            <form method="post" id="frmPassChange" class="frmPassChange rounded bg-light text-dark d-flex flex-wrap justify-content-around" action="changePassServlet">
                <label for="newPass" class="col-12 col-lg-5" >

                    <input class="form-control form-control-sm" type="password" id="newPass" name="newPass" placeholder="New Password">
                    <small class="float-end"></small>
                </label>
                <label for="rePass" class="col-12 col-lg-5 align-self-start">

                    <input class="form-control form-control-sm" type="password" id="Repass" name="rePass"  placeholder="Re-Enter Password">
                    <small class="float-end"></small>
                </label>
                <label class="w-100 d-flex justify-content-around">
                    <input name='btnChangePass' type="button" value="Change Password" class="btn btn-primary" id="btnChangePass" />
                </label>
            </form>
            <div class="popup popupInactive d-flex justify-content-around align-items-center">
                <div class=" d-flex flex-column gap-3 bg-light text-dark p-3 rounded">
                    <span class="bi bi-x-lg"></span>
                    <h3 class="text-center">Enter Password To Verify</h3>
                    <label for="pass">Password
                        <small class="float-end"></small>
                        <input class="form-control form-control-sm" type="password" id="pass" name="oldPass">
                    </label> 
                    <input type="submit" class="btn btn-primary" value="Save Changes" name="saveProfile">
                </div>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {

            }
        %>
        <div class="box">
            <%
                if (sess.getAttribute("err") != null) {
                    LocalTime time = (LocalTime) sess.getAttribute("time");
                    String stTime = time.toString();
                    String err = (String) sess.getAttribute("err");
                    if (err.equals("exist")) {
            %>
            <script>

                document.getElementsByClassName('box')[0].innerHTML = (`
                        <div class = 'rounded border bg-warning d-flex flex-column p-2 position-fixed errBox w-25' style = "min-width:200px">
                        <span onclick = 'hide(event);' class = 'btn btn-dark bi bi-x ms-auto border rounded-circle' > </span>
                        <div class = 'text-center' > Update Failed </div>
                        <small class = 'text-black-50 text-end' ><%=stTime%> </small>
                        </div>`);
            </script>

            <% } else {%>
            <script>

                        document.getElementsByClassName('box')[0].innerHTML = (`
                        <div class = 'rounded border bg-info d-flex flex-column p-2 position-fixed errBox w-25' style = "min-width:200px">
                        <span onclick = 'hide(event);' class = 'btn btn-dark bi bi-x ms-auto border rounded-circle' > </span>
                        <div class = 'text-center' > Update Successfull </div>
                        <small class = 'text-black-50 text-end' ><%=stTime%> </small>
                        </div>`);
            </script>

            <%  }
                    sess.removeAttribute("err");
                    sess.removeAttribute("time");
                }
            %>

        </div>


        <script>
                    let popup = elt =>
                    {
                    let save = document.getElementsByName('saveProfile')[0];
                            let oldPass = document.getElementsByName('oldPass')[0];
                            toggleOldPass();
                            let form = elt.parentElement;
                            console.log(form.nodeName);
                            if (form.nodeName === "LABEL")
                    {
                    form = form.parentElement;
                    }
                    save.setAttribute("form", form.id);
                            oldPass.setAttribute("form", form.id);
                            };
                    let toggleOldPass = () =>
                    {
                    let popup = document.querySelector('.popup');
                            popup.classList.toggle("popupActive");
                            popup.classList.toggle("popupInactive");
                            }

            document.getElementsByClassName('bi-x-lg')[0].addEventListener('click', toggleOldPass);
                    let hide = (event) =>
                    {
                    event.target.parentElement.remove();
                            };
//validation
                    let valid = (inputCount, frm, button) =>
                    {
                    let res = 0;
                            let allInputLabels = Array.from(document.getElementById(frm).getElementsByTagName('label'));
                            allInputLabels.pop();
                            allInputLabels.forEach(function (inputLabel)
                            {
                            if (inputLabel.getElementsByTagName('input')[0].value.trim() !== "")
                            {
                            res++;
                                    msgPrinter("Looks Good", 1, inputLabel.getElementsByTagName('small')[0]);
                            }
                            else
                            {
                            res--;
                                    msgPrinter("Field Is Required", 0, inputLabel.getElementsByTagName('small')[0]);
                            }
                            });
                            if (res === inputCount){
                    popup(document.getElementsByName(button)[0]);
                    }
                    }

//Message Printer
            let msgPrinter = (msg, type, elt)=>
                    {
                    if (type === 0)
                    {
                    elt.classList.add("setError");
                            elt.classList.remove("setNoError");
                            elt.innerText = msg;
                    }
                    else
                    {
                    elt.innerText = msg;
                            elt.classList.remove("setError");
                            elt.classList.add("setNoError");
                    }
                    };
                    document.getElementsByName('triggerPass')[0].addEventListener('click', () => valid(4, "frmChange", "triggerPass"));
                    document.getElementById('btnChangePass').addEventListener('click', function()
                    {
                    let newPass = document.getElementsByName("newPass")[0];
                            let rePass = document.getElementsByName("rePass")[0];
                            newPass.parentElement.getElementsByTagName("small")[0].innerText = "";
                            rePass.parentElement.getElementsByTagName("small")[0].innerText = "";
                            if (newPass.value.length < 8){
                    msgPrinter("Password Must Be Atleast 8 Characters", 0, newPass.parentElement.getElementsByTagName("small")[0]);
                    } else{
                    if (newPass.value !== rePass.value)
                            msgPrinter("Password Do not match", 0, rePass.parentElement.getElementsByTagName("small")[0]);
                            else
                            valid(2, "frmPassChange", "btnChangePass");
                    }

                    });
                    document.getElementsByName("saveProfile")[0].addEventListener('click', event => {
            let oldPass = document.getElementsByName("oldPass")[0];
                    if (oldPass.value === ""){
            event.preventDefault();
                    msgPrinter("Field is required", 0, oldPass.parentElement.getElementsByTagName("small")[0]);
            }
            });
        </script>

        <%
            }
                else {  
                     String redirectURL = "/RentOnline/errorDis.html";
                response.sendRedirect(redirectURL);
            }
        %>
        <script src="js/common.js"></script>
         <footer id="footer">
            <jsp:include page="footer.html" />  
        </footer>
    </body>

</html>
