<%@ page import="net.croz.blog.blogweb.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<div class="main-wrapper">
    <section class="cta-section theme-bg-light py-5">
        <div class="container text-center">
            <a href="new_post" class="btn btn-primary justify-content-end">New post</a>
            <a href="search" class="btn btn-primary">Search the site</a>
        </div><!--//container-->
    </section>
    <h2 class="title text-center" style="margin-top: 50px" >Posts</h2>
    <section class="blog-list px-3 py-5 p-md-5">
        <div class="container">
            <%
                // List posts in reverse order (newest first)
                Collections.reverse((List<?>) request.getAttribute("posts"));
            %>
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
                                    class="time">${post.author.firstName} ${post.author.lastName}</span>
                                <span class="date">Date created:
                                    <fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${post.dateCreated}" var="parsedDate" />
                                    <fmt:formatDate value="${parsedDate}" pattern="dd.MM.yyyy" />
                                </span>
                                <span class="comment"><a href="${pageContext.request.contextPath}/blog_post_${post.id}#comment-section">${result.rows[0].num} comments</a></span>
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

