<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head title="Create a new post">
    <!-- Theme CSS -->
    <link id="theme-style" rel="stylesheet" href="assets/css/theme-1.css">
</head>
<style>

    @import url(https://fonts.googleapis.com/css?family=Roboto:400,300,600,400italic);
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        -webkit-font-smoothing: antialiased;
        -moz-font-smoothing: antialiased;
        -o-font-smoothing: antialiased;
        font-smoothing: antialiased;
        text-rendering: optimizeLegibility;
    }

    body {
        font-family: "Roboto", Helvetica, Arial, sans-serif;
        font-weight: 100;
        font-size: 12px;
        line-height: 30px;
        color: #777;
        background: #4CAF50;
    }

    .kontenjer {
        max-width: 400px;
        width: 100%;
        margin: 0 auto;
        position: relative;
    }

    #contact input[type="text"],
    #contact input[type="email"],
    #contact input[type="tel"],
    #contact input[type="url"],
    #contact textarea,
    #contact button[type="submit"] {
        font: 400 12px/16px "Roboto", Helvetica, Arial, sans-serif;
    }
    #contact input[type="submit"] {
        font: 400 12px/16px "Roboto", Helvetica, Arial, sans-serif;
    }

    #contact {
        background: #F9F9F9;
        padding: 25px;
        margin: 150px 0;
        box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
    }

    #contact h3 {
        display: block;
        font-size: 30px;
        font-weight: 300;
        margin-bottom: 10px;
    }

    #contact h4 {
        margin: 5px 0 15px;
        display: block;
        font-size: 13px;
        font-weight: 400;
    }

    fieldset {
        border: medium none !important;
        margin: 0 0 10px;
        min-width: 100%;
        padding: 0;
        width: 100%;
    }

    #contact input[type="text"],
    #contact input[type="email"],
    #contact input[type="tel"],
    #contact input[type="url"],
    #contact textarea {
        width: 100%;
        border: 1px solid #ccc;
        background: #FFF;
        margin: 0 0 5px;
        padding: 10px;
    }

    #contact input[type="text"]:hover,
    #contact input[type="email"]:hover,
    #contact input[type="tel"]:hover,
    #contact input[type="url"]:hover,
    #contact textarea:hover {
        -webkit-transition: border-color 0.3s ease-in-out;
        -moz-transition: border-color 0.3s ease-in-out;
        transition: border-color 0.3s ease-in-out;
        border: 1px solid #aaa;
    }

    #contact textarea {
        height: 100px;
        max-width: 100%;
        resize: none;
    }

    #contact button[type="submit"] {
        cursor: pointer;
        width: 100%;
        border: none;
        background: #4CAF50;
        color: #FFF;
        margin: 0 0 5px;
        padding: 10px;
        font-size: 15px;
    }

    #contact input[type="submit"] {
        cursor: pointer;
        width: 100%;
        border: none;
        background: #4CAF50;
        color: #FFF;
        margin: 0 0 5px;
        padding: 10px;
        font-size: 15px;
    }

    #contact button[type="submit"]:hover {
        background: #43A047;
        -webkit-transition: background 0.3s ease-in-out;
        -moz-transition: background 0.3s ease-in-out;
        transition: background-color 0.3s ease-in-out;
    }

    #contact button[type="submit"]:active {
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.5);
    }

    .copyright {
        text-align: center;
    }

    #contact input:focus,
    #contact textarea:focus {
        outline: 0;
        border: 1px solid #aaa;
    }

    ::-webkit-input-placeholder {
        color: #888;
    }

    :-moz-placeholder {
        color: #888;
    }

    ::-moz-placeholder {
        color: #888;
    }

    :-ms-input-placeholder {
        color: #888;
    }

    .error {
        color: red;
    }

</style>
<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid" style="background-color: #F9F9F9">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">CROZ Blog App</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><span class="glyphicon glyphicon-log-in"></span>Logged in as: <h4>${currentUsername}</h4></li>
        </ul>
    </div>
</nav>

<div class="kontenjer">
    <form:form id="contact" action="processForm" method="POST" modelAttribute="post">
        <h3>Create a new post</h3>
        <!--
        <fieldset>
            <form:input path="author.firstName" placeholder="Name"></form:input>
            <form:errors path="author.firstName" cssClass="error"></form:errors>
        </fieldset>
        <fieldset>
            <form:input path="author.lastName" placeholder="Last name"></form:input>
            <form:errors path="author.lastName" cssClass="error"></form:errors>
        </fieldset>
        <fieldset>
            <form:input path="author.email" placeholder="Email (optional)"></form:input>
            <form:errors path="author.email" cssClass="error"></form:errors>
        </fieldset> -->
        <fieldset>
            <form:input path="title" placeholder="Title"></form:input>
            <form:errors path="title" cssClass="error"></form:errors>
        </fieldset>
        <fieldset>
            <form:textarea path="content" placeholder="Write here..."></form:textarea>
            <form:errors path="content" cssClass="error"></form:errors>
        </fieldset>
        <fieldset>
            <form:input path="tag.name" placeholder="Tag"></form:input>
            <form:errors path="tag.name" cssClass="error"></form:errors>
        </fieldset>
        <fieldset>
            <input id="contact-submit" type="submit"/>
        </fieldset>
        <p class="copyright">Designed by <a href="https://colorlib.com" target="_blank" title="Colorlib">Colorlib</a></p>
    </form:form>
</div>
</body>
</html>
