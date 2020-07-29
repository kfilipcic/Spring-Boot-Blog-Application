<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head title = Blog page>
    <style>
    </style></head>
<body>
<c:forEach var="post" items="${posts}">
    <h1>${post.title}</h1> <br><br>
    <p>${post.content}</p> <br><br>
    <h3>${post.author.firstName} ${post.author.lastName}</h3>
    <c:if test="${not empty post.author.email}">
        <h3> ${post.author.email}</h3>
   </c:if>
    <c:if test="${not empty post.tag.name}">
        <h3> ${post.tag.name}</h3>
    </c:if>
</c:forEach>
</body>
</html>