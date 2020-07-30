<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Blog stranica</title>

    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Blog Template">
    <meta name="author" content="Xiaoying Riley at 3rd Wave Media">
    <link rel="shortcut icon" href="favicon.ico">

    <!-- FontAwesome JS-->
    <script defer src="https://use.fontawesome.com/releases/v5.7.1/js/all.js"
            integrity="sha384-eVEQC9zshBn0rFj4+TU78eNA19HMNigMviK/PU/FFjLXqa/GKPgX58rvt5Z8PLs7"
            crossorigin="anonymous"></script>

    <!-- Theme CSS -->
    <link id="theme-style" rel="stylesheet" href="assets/css/theme-1.css">

</head>

<body>

<header class="header text-center">
    <h1 class="blog-name pt-lg-4 mb-0"><a href="index.html">Blog stranica</a></h1>

    <nav class="navbar navbar-expand-lg navbar-dark">

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation"
                aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div id="navigation" class="collapse navbar-collapse flex-column">
            <div class="profile-section pt-3 pt-lg-0">
                <img class="profile-image mb-3 rounded-circle mx-auto" src="assets/images/profile.png" alt="image">

                <div class="bio mb-3">Hi, my name is Anthony Doe. Briefly introduce yourself here. You can also provide
                    a link to the about page.<br><a href="about.html">Find out more about me</a></div><!--//bio-->
                <ul class="social-list list-inline py-3 mx-auto">
                    <li class="list-inline-item"><a href="#"><i class="fab fa-twitter fa-fw"></i></a></li>
                    <li class="list-inline-item"><a href="#"><i class="fab fa-linkedin-in fa-fw"></i></a></li>
                    <li class="list-inline-item"><a href="#"><i class="fab fa-github-alt fa-fw"></i></a></li>
                    <li class="list-inline-item"><a href="#"><i class="fab fa-stack-overflow fa-fw"></i></a></li>
                    <li class="list-inline-item"><a href="#"><i class="fab fa-codepen fa-fw"></i></a></li>
                </ul><!--//social-list-->
                <hr>
            </div><!--//profile-section-->

            <ul class="navbar-nav flex-column text-left">
                <li class="nav-item active">
                    <a class="nav-link" href="index.html"><i class="fas fa-home fa-fw mr-2"></i>Blog Home <span
                            class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="blog_post.jsp"><i class="fas fa-bookmark fa-fw mr-2"></i>Blog Post</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about.html"><i class="fas fa-user fa-fw mr-2"></i>About Me</a>
                </li>
            </ul>

            <div class="my-2 my-md-3">
                <a class="btn btn-primary" href="https://themes.3rdwavemedia.com/" target="_blank">Get in Touch</a>
            </div>
        </div>
    </nav>
</header>

<div class="main-wrapper">
    <section class="cta-section theme-bg-light py-5">
        <div class="container text-center">
            <a href="new_post" class="btn btn-primary justify-content-end" style="background-color: #1f427a">Novi
                post</a>
            <form class="signup-form form-inline justify-content-center pt-3">
                <div class="form-group">
                    <label class="sr-only" for="semail">Your email</label>
                    <input type="email" id="semail" name="semail1" class="form-control mr-md-1 semail"
                           placeholder="Pretraži blog">
                </div>
                <button type="submit" class="btn btn-primary">Traži</button>
            </form>
        </div><!--//container-->
    </section>
    <section class="blog-list px-3 py-5 p-md-5">
        <div class="container">
            <c:forEach var="post" items="${posts}">
                <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                                   url="jdbc:mysql://localhost:3306/blogdb2?useSSL=false"
                                   user="hbstudent" password="hbstudent"/>

                <sql:query dataSource="${snapshot}" var="result">
                    select count(*) num from comment where post_id=${post.id};
                </sql:query>

                <div class="item mb-5">
                    <div class="media rounded border border-dark">
                        <div class="media-body" style="margin: 10px">
                            <h3 class="title mb-1"><a
                                    href="${pageContext.request.contextPath}/blog_post_${post.id}">${post.title}</a>
                            </h3>
                            <div class="meta mb-1">Author: <span
                                    class="time">${post.author.firstName} ${post.author.lastName}</span><span
                                    class="date">Date created: ${post.dateCreated}</span><span
                                    class="comment"><a href="">${result.rows[0].num} comments</a></span>
                                <c:if test="${not empty post.tag.name}"><span class="time">Tag: ${post.tag.name}</span></c:if></div>
                            <div class="intro">${post.content}</div>
                            <a class="more-link" href="${pageContext.request.contextPath}/blog_post_${post.id}">Read
                                more &rarr;</a>
                        </div><!--//media-body-->
                    </div><!--//media-->
                </div>
                <!--//item-->
            </c:forEach>
        </div>
    </section>

    <footer class="footer text-center py-2 theme-bg-dark">

        <!--/* This template is released under the Creative Commons Attribution 3.0 License. Please keep the attribution link below when using for your own project. Thank you for your support. :) If you'd like to use the template without the attribution, you can buy the commercial license via our website: themes.3rdwavemedia.com */-->
        <small class="copyright">Designed with <i class="fas fa-heart" style="color: #fb866a;"></i> by <a
                href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>

    </footer>

</div><!--//main-wrapper-->


<!-- *****CONFIGURE STYLE (REMOVE ON YOUR PRODUCTION SITE)****** -->
<div id="config-panel" class="config-panel d-none d-lg-block">
    <div class="panel-inner">
        <a id="config-trigger" class="config-trigger config-panel-hide text-center" href="#"><i
                class="fas fa-cog fa-spin mx-auto" data-fa-transform="down-6"></i></a>
        <h5 class="panel-title">Choose Colour</h5>
        <ul id="color-options" class="list-inline mb-0">
            <li class="theme-1 active list-inline-item"><a data-style="assets/css/theme-1.css" href="#"></a></li>
            <li class="theme-2  list-inline-item"><a data-style="assets/css/theme-2.css" href="#"></a></li>
            <li class="theme-3  list-inline-item"><a data-style="assets/css/theme-3.css" href="#"></a></li>
            <li class="theme-4  list-inline-item"><a data-style="assets/css/theme-4.css" href="#"></a></li>
            <li class="theme-5  list-inline-item"><a data-style="assets/css/theme-5.css" href="#"></a></li>
            <li class="theme-6  list-inline-item"><a data-style="assets/css/theme-6.css" href="#"></a></li>
            <li class="theme-7  list-inline-item"><a data-style="assets/css/theme-7.css" href="#"></a></li>
            <li class="theme-8  list-inline-item"><a data-style="assets/css/theme-8.css" href="#"></a></li>
        </ul>
        <a id="config-close" class="close" href="#"><i class="fa fa-times-circle"></i></a>
    </div><!--//panel-inner-->
</div><!--//configure-panel-->


<!-- Javascript -->
<script src="assets/plugins/jquery-3.3.1.min.js"></script>
<script src="assets/plugins/popper.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>

<!-- Style Switcher (REMOVE ON YOUR PRODUCTION SITE) -->
<script src="assets/js/demo/style-switcher.js"></script>


</body>
</html>

