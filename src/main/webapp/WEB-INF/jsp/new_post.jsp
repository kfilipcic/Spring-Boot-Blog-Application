<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head title="Create a new post">
    <style>
        .error {color: red;}
    </style>
</head>
<body>
    <form:form action="processForm" method="POST" modelAttribute="post">
        Name:      <form:input path="author.firstName"></form:input>
        <form:errors path="author.firstName" cssClass="error"></form:errors> <br><br>
        Last name: <form:input path="author.lastName"></form:input>
        <form:errors path="author.lastName" cssClass="error"></form:errors> <br><br>
        e-Mail:    <form:input path="author.email"></form:input>
        <form:errors path="author.email" cssClass="error"></form:errors> <br><br>
        Title:     <form:input path="title"></form:input>
        <form:errors path="title" cssClass="error"></form:errors> <br><br>
                   <form:textarea path="content"></form:textarea>
        <form:errors path="content" cssClass="error"></form:errors> <br><br>
        Tag:       <form:input path="tag.name"></form:input>
        <form:errors path="tag.name" cssClass="error"></form:errors> <br><br>
        <input type="submit"/> <br><br>
    </form:form>
</body>
</html>