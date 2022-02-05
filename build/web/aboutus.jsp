<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>About Us</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/aboutus.css">
        <script src="https://kit.fontawesome.com/dbed6b6114.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <header id="header">
            <jsp:include page="header.jsp"/>
        </header>
        <section>
            <div class = "image">
                <!-- image here -->
            </div>

            <div class = "content">
                <h2>About Us</h2>
                <span><!-- line here --></span>

                <p>Rent portal is a website where you can book and rent properties..The best deals are often done with people who live in your own city or on your own street, So here, it's easy to book and rent out locally. All you have to do is to post your advertisement or surf and choose which suits you..
                It takes less than 2 minutes to post an ad here.
                 You can sign up for a free account and post ads easily every time.For more information contact us.
 </p>

                <ul class = "links">
                  
                 

                    <li><a href = "services.jsp">services</a></li>

                    <div class = "vertical-line"></div>
                    
                    <li><a href = "contact.jsp">contact us</a></li>
                </ul>

                <ul class = "icons">
                    <li>
                        <i class = "fa fa-twitter"></i>
                    </li>
                    <li>
                        <i class = "fa fa-facebook"></i>
                    </li>
                    <li>
                        <i class = "fa fa-github"></i>
                    </li>
                    <li>
                        <i class = "fa fa-pinterest"></i>
                    </li>
                </ul>
            </div>
        </section>
        <footer id="footer">
            <jsp:include page="footer.html" />  
        </footer>
    </body>
</html>