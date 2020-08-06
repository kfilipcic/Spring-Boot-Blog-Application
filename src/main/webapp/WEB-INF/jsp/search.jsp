<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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

    <script>
        const countries = ["Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Anguilla", "Antigua &amp; Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia &amp; Herzegovina", "Botswana", "Brazil", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central Arfrican Republic", "Chad", "Chile", "China", "Colombia", "Congo", "Cook Islands", "Costa Rica", "Cote D Ivoire", "Croatia", "Cuba", "Curacao", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Polynesia", "French West Indies", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauro", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "Norway", "Oman", "Pakistan", "Palau", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russia", "Rwanda", "Saint Pierre &amp; Miquelon", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "St Kitts &amp; Nevis", "St Lucia", "St Vincent", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor L'Este", "Togo", "Tonga", "Trinidad &amp; Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks &amp; Caicos", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States of America", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Virgin Islands (US)", "Yemen", "Zambia", "Zimbabwe"];
    </script>

    <link id="autocomplete-css" rel="stylesheet" href="assets/css/autocomplete.css">
    <script src="assets/js/autocomplete.js"></script>
    <link id="the-datepicker-css" rel="stylesheet" href="assets/css/the-datepicker.css">
    <script src="assets/js/the-datepicker.js"></script>
    <link id="pagination-css" rel="stylesheet" href="assets/css/pagination.css">

    <script>
        function onChangeAutocomplete(id) {
            var len = document.getElementsByName(id)[0].value.length;
            console.log("length of value: " + len);
            if (len > 2) {
                if (id === 'authorName') {
                    if (typeof names === 'undefined') {
                        var names = new Array();
                        <c:forEach items="${allPosts}" var="onePost">
                        if (names.indexOf("${onePost.author.firstName} ${onePost.author.lastName}") === -1)
                            names.push("${onePost.author.firstName} ${onePost.author.lastName}");
                        </c:forEach>
                    }
                    autocomplete(document.getElementsByName(id)[0], names);
                } else if (id === 'tagName') {
                    if (typeof tags === 'undefined') {
                        var tags = new Array();
                        <c:forEach items="${allPosts}" var="onePost">
                        if (tags.indexOf("${onePost.tag.name}") === -1)
                            tags.push("${onePost.tag.name}");
                        </c:forEach>
                    }
                    autocomplete(document.getElementsByName(id)[0], tags);
                }
            }
        }
    </script>

</head>

<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">CROZ Blog App</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><span class="glyphicon glyphicon-log-in"></span>Logged in as: <h4>${currentUsername}</h4></li>
            <li><span class="glyphicon glyphicon-log-in"></span><a href="/logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="main-wrapper">
    <section class="cta-section theme-bg-light py-5">
        <div class="container text-center">
            <a href="new_post" class="btn btn-primary justify-content-end" style="background-color: #1f427a">Novi
                post</a>
            <form class="signup-form pt-3">
                <h2 class="card-title">Search:</h2>
                <div class="form-group">
                    <form autocomplete="off" action="/search" method="GET" style="display:flex;flex-wrap:wrap;">
                        <div class="container autocomplete">
                            <input name="authorName" onkeydown="onChangeAutocomplete('authorName')"
                                   class="form-control mr-md-1 semail"
                                   placeholder="Author name (min. 3 letters for autocomplete)"
                                   value="${param.authorName}"/>
                        </div>
                        <br><br>
                        <input name="title" class="form-control mr-md-1 semail autocomplete container"
                               placeholder="Title" value="${param.title}"/> <br><br>
                        <input name="dateFrom" type="text" id="my-input" name="dateFrom"
                               class="form-control mr-md-1 semail autocomplete container dateInputs"
                               placeholder="Date from (dd.mm.yyyy)"
                               autocomplete="off"
                               value="${param.dateFrom}"/> <br><br>
                        <input name="dateTo" type="text" id="my-input2" name="dateTo"
                               class="form-control mr-md-1 semail autocomplete container dateInputs"
                               placeholder="Date to (dd.mm.yyyy)"
                               value="${param.dateTo}"/> <br><br>
                        <div class="container autocomplete">
                            <input name="tagName" onkeydown="onChangeAutocomplete('tagName')"
                                   class="form-control mr-md-1 semail autocomplete container"
                                   placeholder="Tag name (min. 3 letters for autocomplete)"
                                   value="${param.tagName}"/>
                        </div>
                        <br><br>
                        <input type="submit" class="btn btn-primary"></input>
                    </form>
                </div>
            </form>
        </div><!--//container-->
        <script>
        </script>
    </section>
    <section class="blog-list px-3 py-5 p-md-5">
        <h2 class="subTitle text-center" style="margin-bottom: 40px">Search results</h2>
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
                                    class="time">${post.author.firstName} ${post.author.lastName}</span>
                                <span class="date">Date created:
                                    <fmt:parseDate pattern="yyyy-MM-dd HH:mm:ss" value="${post.dateCreated}"
                                                   var="parsedDate"/>
                                    <fmt:formatDate value="${parsedDate}" pattern="dd.MM.yyyy"/>
                                </span>
                                <span class="comment"><a
                                        href="${pageContext.request.contextPath}/blog_post_${post.id}#comment-section">${result.rows[0].num} comments</a></span>
                                <c:if test="${not empty post.tag.name}"><span
                                        class="time">Tag: ${post.tag.name}</span></c:if></div>
                            <div class="intro">${post.content}</div>
                            <a class="more-link" href="${pageContext.request.contextPath}/blog_post_${post.id}">Read
                                more &rarr;</a>
                        </div><!--//media-body-->
                    </div><!--//media-->
                </div>
                <!--//item-->
            </c:forEach>
            <div class="pagination item mb-5 text-center" style="text-align: center">
                <c:set var="firstPageNum" value="${0}"></c:set>
                <c:choose>
                    <c:when test="${currentPageNum-1 > firstPageNum}">
                        <a href="search?authorName=${param.authorName}&title=${param.title}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&tagName=${param.tagName}&page=${currentPageNum-2}&itemsNum=${param.itemsNum}">&laquo;</a>
                    </c:when>
                    <c:otherwise>
                        <a href="search?authorName=${param.authorName}&title=${param.title}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&tagName=${param.tagName}&page=${currentPageNum-1}&itemsNum=${param.itemsNum}">&laquo;</a>
                    </c:otherwise>
                </c:choose>
                <c:forEach begin="1" end="${totalPages-1}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == currentPageNum}">
                            <a class="active"
                               href="search?authorName=${param.authorName}&title=${param.title}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&tagName=${param.tagName}&page=${pageNum-1}&itemsNum=${param.itemsNum}">${pageNum}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="search?authorName=${param.authorName}&title=${param.title}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&tagName=${param.tagName}&page=${pageNum-1}&itemsNum=${param.itemsNum}">${pageNum}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:choose>
                    <c:when test="${currentPageNum < totalPages-1}">
                        <a href="search?authorName=${param.authorName}&title=${param.title}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&tagName=${param.tagName}&page=${currentPageNum}&itemsNum=${param.itemsNum}">&raquo;</a>
                    </c:when>
                    <c:otherwise>
                        <a href="search?authorName=${param.authorName}&title=${param.title}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&tagName=${param.tagName}&page=${currentPageNum-1}&itemsNum=${param.itemsNum}">&raquo;</a>
                    </c:otherwise>
                </c:choose>
                <p>Items per page: </p>
                <select name="itemsNum" id="itemsNum" onchange="refreshPage(this)">
                    <option value="5" <c:if test="${param.itemsNum == 5}">selected</c:if>>5</option>
                    <option value="10" <c:if test="${param.itemsNum == 10}">selected</c:if>>10</option>
                    <option value="15" <c:if test="${param.itemsNum == 15}">selected</c:if>>15</option>
                    <option value="20" <c:if test="${param.itemsNum == 20}">selected</c:if>>20</option>
                    <option value="25" <c:if test="${param.itemsNum == 25}">selected</c:if>>25</option>
                </select>
                <script>
                    function refreshPage(itemsNumSelect) {
                        window.location.assign("?authorName=${param.authorName}&title=${param.title}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&tagName=${param.tagName}&page=${currentPageNum-1}&itemsNum=" + itemsNumSelect.value);
                    }
                </script>
            </div>
        </div>
        <h3>${pageContext.request.contextPath}</h3>
        <h3>${requestcope['javax.servlet.forward.query_string']}</h3>
    </section>

    <ul style="display: none" class="settings">
        <li>
            var input = document.getElementById('my-input');
        </li>
        <li class="space">
            var datepicker = <span id="datepicker1">new TheDatepicker.Datepicker(input);</span><input type="button"
                                                                                                      id="datepicker2"
                                                                                                      value="new TheDatepicker.Datepicker(input);"
                                                                                                      class="hidden">
        </li>
        <li>
            // var container = document.getElementById('my-container');
        </li>
        <li>
            // var datepicker = new TheDatepicker.Datepicker(input, container);
        </li>
        <li>
            // var datepicker = new TheDatepicker.Datepicker(null, container);
        </li>
        <li class="space">
            // var datepicker = new TheDatepicker.Datepicker(input, null, new TheDatepicker.Options());
        </li>
        <li>
            <label>datepicker.options.setInitialDate("<input type="text" size="15" id="initialDate">");</label> <span
                class="error" id="initialDateError"></span> // direct html input value has priority over this option
        </li>
        <li>
            <label>datepicker.options.setInitialMonth("<input type="text" size="15" id="initialMonth">");</label> <span
                class="error" id="initialMonthError"></span>
        </li>
        <li>
            <label>datepicker.options.setInitialDatePriority(<input type="checkbox" id="initialDatePriority"
                                                                    checked="checked">);</label>
        </li>
        <li>
            datepicker.<input type="button" id="open" value="open()">;
        </li>
        <li>
            datepicker.<input type="button" id="close" value="close()">;
        </li>
        <li>
            datepicker.<input type="button" id="reset" value="reset()">;
        </li>
        <li>
            datepicker.<input type="button" id="destroy" value="destroy()">;
        </li>
        <li>
            <label>datepicker.selectDate("<input type="text" size="15" id="selectDate">"</label>, <label>/*
            doUpdateMonth: */ <input type="checkbox" id="selectDateDoUpdateMonth" checked="checked"></label>); <span
                class="error" id="selectDateError"></span>
        </li>
        <li>
            <label>datepicker.goToMonth("<input type="text" size="15" id="goToMonth">");</label> <span class="error"
                                                                                                       id="goToMonthError"></span>
        </li>
        <li>
            <label>datepicker.getSelectedDate()<span id="selectedDate"></span>;</label>
        </li>
        <li>
            <label>datepicker.getSelectedDateFormatted() === <span id="selectedDateFormatted"></span>;</label>
        </li>
        <li>
            <label>datepicker.getCurrentMonth()<span id="currentMonth"></span>;</label>
        </li>
        <li>
            <label>datepicker.options.setHideOnBlur(<input type="checkbox" id="hideOnBlur" checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setHideOnSelect(<input type="checkbox" id="hideOnSelect"
                                                             checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setInputFormat("<input type="text" size="15" id="inputFormat"
                                                             value="j.n.Y">");</label> <span class="error"
                                                                                             id="inputFormatError"></span><br>
            // "j" = Day of the month (1 to 31)<br>
            // "d" = Day of the month with leading zero (01 to 31)<br>
            // "D" = Short textual representation of a day of the week (Mo through Su)<br>
            // "l" = Textual representation of a day of the week (Monday through Sunday)<br>
            // "n" = Numeric representation of a month (1 through 12)<br>
            // "m" = Numeric representation of a month with leading zero (01 through 12)<br>
            // "F" = Textual representation of a month (January through December)<br>
            // "M" = Short textual representation of a month (Jan through Dec)<br>
            // "Y" = Full year (1999 or 2003)<br>
            // "y" = Year, 2 digits (99 or 03)
        </li>
        <li>
            <label>datepicker.options.setFirstDayOfWeek(<select id="firstDayOfWeek">
                <option value="1" selected="selected">TheDatepicker.DayOfWeek.Monday</option>
                <option value="2">TheDatepicker.DayOfWeek.Tuesday</option>
                <option value="3">TheDatepicker.DayOfWeek.Wednesday</option>
                <option value="4">TheDatepicker.DayOfWeek.Thursday</option>
                <option value="5">TheDatepicker.DayOfWeek.Friday</option>
                <option value="6">TheDatepicker.DayOfWeek.Saturday</option>
                <option value="0">TheDatepicker.DayOfWeek.Sunday</option>
            </select>);</label>
        </li>
        <li>
            <label>datepicker.options.setMinDate("<input type="text" size="15" id="minDate">");</label> <span
                class="error" id="minDateError"></span>
        </li>
        <li>
            <label>datepicker.options.setMaxDate("<input type="text" size="15" id="maxDate">");</label> <span
                class="error" id="maxDateError"></span>
        </li>
        <li>
            <label>datepicker.options.setDropdownItemsLimit(<input type="text" size="15" id="dropdownItemsLimit"
                                                                   value="200">);</label> <span class="error"
                                                                                                id="dropdownItemsLimitError"></span>
        </li>
        <li>
            <label>datepicker.options.setHideDropdownWithOneItem(<input type="checkbox" id="hideDropdownWithOneItem"
                                                                        checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setDaysOutOfMonthVisible(<input type="checkbox"
                                                                      id="daysOutOfMonthVisible">);</label>
        </li>
        <li>
            <label>datepicker.options.setFixedRowsCount(<input type="checkbox" id="fixedRowsCount">);</label>
        </li>
        <li>
            <label>datepicker.options.setToggleSelection(<input type="checkbox" id="toggleSelection">);</label>
        </li>
        <li>
            <label>datepicker.options.setShowDeselectButton(<input type="checkbox" id="showDeselectButton"
                                                                   checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setAllowEmpty(<input type="checkbox" id="allowEmpty" checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setShowCloseButton(<input type="checkbox" id="showCloseButton" checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setTitle("<input type="text" size="15" id="title">");</label> <span class="error"
                                                                                                          id="titleError"></span>
        </li>
        <li>
            <label>datepicker.options.setShowResetButton(<input type="checkbox" id="showResetButton">);</label>
        </li>
        <li>
            <label>datepicker.options.setMonthAsDropdown(<input type="checkbox" id="monthAsDropdown" checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setYearAsDropdown(<input type="checkbox" id="yearAsDropdown" checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setMonthAndYearSeparated(<input type="checkbox" id="monthAndYearSeparated"
                                                                      checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setMonthShort(<input type="checkbox" id="monthShort">);</label>
        </li>
        <li>
            <label>datepicker.options.setChangeMonthOnSwipe(<input type="checkbox" id="changeMonthOnSwipe"
                                                                   checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setAnimateMonthChange(<input type="checkbox" id="animateMonthChange"
                                                                   checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setPositionFixing(<input type="checkbox" id="positionFixing" checked="checked">);</label>
        </li>
        <li>
            <label>datepicker.options.setDateAvailabilityResolver((date) => {<br>
                &nbsp;<textarea rows="3" cols="70"
                                id="dateAvailabilityResolver">// return date.getDate() !== 5;</textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.setCellContentStructureResolver(() => {<br>
                &nbsp;<textarea rows="3" cols="70" id="cellContentStructureResolverInit">return document.createElement('span');</textarea><br>
                }, (element, day) => {<br>
                &nbsp;<textarea rows="3" cols="70" id="cellContentStructureResolverUpdate">element.innerText = day.dayNumber;</textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.setCellContentResolver((day) => {<br>
                &nbsp;<textarea rows="3" cols="70" id="cellContentResolver">return day.dayNumber;</textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.addCellClassesResolver((day) => {<br>
                &nbsp;<textarea rows="3" cols="70" id="cellClassesResolver">
// if (day.dayNumber === 20) return ['red'];
// if (day.dayNumber === 10) return ['green'];
return [];</textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.addDayModifier((day) => {<br>
                &nbsp;<textarea rows="3" cols="70" id="dayModifier">
// day.isSunday = day.dayOfWeek === TheDatepicker.DayOfWeek.Sunday;</textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.setHeaderStructureResolver(() => {<br>
                &nbsp;<textarea rows="3" cols="70" id="headerStructureResolver">/*
var header = document.createElement('div');
header.innerText = 'Hello world';
return header;
*/</textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.setFooterStructureResolver(() => {<br>
                &nbsp;<textarea rows="3" cols="70" id="footerStructureResolver"></textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onBeforeSelect(function (event, day, previousDay) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onBeforeSelect">// this instanceof TheDatepicker.Datepicker // applies to all on*</textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onSelect(function (event, day, previousDay) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onSelect"></textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onBeforeOpenAndClose(function (event, isOpening) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onBeforeOpenAndClose"></textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onOpenAndClose(function (event, isOpening) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onOpenAndClose"></textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onBeforeMonthChange(function (event, month, previousMonth) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onBeforeMonthChange"></textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onMonthChange(function (event, month, previousMonth) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onMonthChange"></textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onBeforeFocus(function (event, day, previousDay) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onBeforeFocus"></textarea><br>
                });</label>
        </li>
        <li>
            <label>datepicker.options.onFocus(function (event, day, previousDay) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onFocus"></textarea><br>
                });</label>
        </li>
        <li>
            datepicker.options.<input type="button" id="removeCellClassesResolver" value="removeCellClassesResolver()">;
            // optional argument: resolver
        </li>
        <li>
            datepicker.options.<input type="button" id="removeDayModifier" value="removeDayModifier()">; // optional
            argument: modifier
        </li>
        <li>
            datepicker.options.<input type="button" id="offBeforeSelect" value="offBeforeSelect()">; // optional
            argument: listener (applies to all off*)
        </li>
        <li>
            datepicker.options.<input type="button" id="offSelect" value="offSelect()">;
        </li>
        <li>
            datepicker.options.<input type="button" id="offBeforeOpenAndClose" value="offBeforeOpenAndClose()">;
        </li>
        <li>
            datepicker.options.<input type="button" id="offOpenAndClose" value="offOpenAndClose()">;
        </li>
        <li>
            datepicker.options.<input type="button" id="offBeforeMonthChange" value="offBeforeMonthChange()">;
        </li>
        <li>
            datepicker.options.<input type="button" id="offMonthChange" value="offMonthChange()">;
        </li>
        <li>
            datepicker.options.<input type="button" id="offBeforeFocus" value="offBeforeFocus()">;
        </li>
        <li>
            datepicker.options.<input type="button" id="offFocus" value="offFocus()">;
        </li>
        <li>
            <label>datepicker.options.setClassesPrefix("<input type="text" size="15" id="classesPrefix"
                                                               value="the-datepicker__">");</label> <span class="error"
                                                                                                          id="classesPrefixError"></span>
        </li>
        <li>
            <label>datepicker.options.setToday("<input type="text" size="15" id="today">");</label> <span class="error"
                                                                                                          id="todayError"></span>
        </li>
        <li>
            <label>datepicker.options.setGoBackHtml("<input type="text" size="15" id="goBackHtml"
                                                            value="&amp;lt;">");</label> <span class="error"
                                                                                               id="goBackHtmlError"></span>
        </li>
        <li>
            <label>datepicker.options.setGoForwardHtml("<input type="text" size="15" id="goForwardHtml"
                                                               value="&amp;gt;">");</label> <span class="error"
                                                                                                  id="goForwardHtmlError"></span>
        </li>
        <li>
            <label>datepicker.options.setCloseHtml("<input type="text" size="15" id="closeHtml" value="&amp;times;">");</label>
            <span class="error" id="closeHtmlError"></span>
        </li>
        <li>
            <label>datepicker.options.setResetHtml("<input type="text" size="15" id="resetHtml" value="&amp;olarr;">");</label>
            <span class="error" id="resetHtmlError"></span>
        </li>
        <li>
            <label>datepicker.options.setDeselectHtml("<input type="text" size="15" id="deselectHtml"
                                                              value="&amp;times;">");</label> <span class="error"
                                                                                                    id="deselectHtmlError"></span>
        </li>

        <li>
            <label>datepicker.options.translator.setDayOfWeekTranslation(TheDatepicker.DayOfWeek.Monday, "<input
                    type="text" size="15" id="dayOfWeekTranslation1" value="Mo">");</label> <span class="error"
                                                                                                  id="dayOfWeekTranslation1Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekTranslation(TheDatepicker.DayOfWeek.Tuesday, "<input
                    type="text" size="15" id="dayOfWeekTranslation2" value="Tu">");</label> <span class="error"
                                                                                                  id="dayOfWeekTranslation2Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekTranslation(TheDatepicker.DayOfWeek.Wednesday, "<input
                    type="text" size="15" id="dayOfWeekTranslation3" value="We">");</label> <span class="error"
                                                                                                  id="dayOfWeekTranslation3Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekTranslation(TheDatepicker.DayOfWeek.Thursday, "<input
                    type="text" size="15" id="dayOfWeekTranslation4" value="Th">");</label> <span class="error"
                                                                                                  id="dayOfWeekTranslation4Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekTranslation(TheDatepicker.DayOfWeek.Friday, "<input
                    type="text" size="15" id="dayOfWeekTranslation5" value="Fr">");</label> <span class="error"
                                                                                                  id="dayOfWeekTranslation5Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekTranslation(TheDatepicker.DayOfWeek.Saturday, "<input
                    type="text" size="15" id="dayOfWeekTranslation6" value="Sa">");</label> <span class="error"
                                                                                                  id="dayOfWeekTranslation6Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekTranslation(TheDatepicker.DayOfWeek.Sunday, "<input
                    type="text" size="15" id="dayOfWeekTranslation0" value="Su">");</label> <span class="error"
                                                                                                  id="dayOfWeekTranslation0Error"></span>
        </li>

        <li>
            <label>datepicker.options.translator.setDayOfWeekFullTranslation(TheDatepicker.DayOfWeek.Monday, "<input
                    type="text" size="15" id="dayOfWeekFullTranslation1" value="Monday">");</label> <span class="error"
                                                                                                          id="dayOfWeekFullTranslation1Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekFullTranslation(TheDatepicker.DayOfWeek.Tuesday, "<input
                    type="text" size="15" id="dayOfWeekFullTranslation2" value="Tuesday">");</label> <span class="error"
                                                                                                           id="dayOfWeekFullTranslation2Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekFullTranslation(TheDatepicker.DayOfWeek.Wednesday, "<input
                    type="text" size="15" id="dayOfWeekFullTranslation3" value="Wednesday">");</label> <span
                class="error" id="dayOfWeekFullTranslation3Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekFullTranslation(TheDatepicker.DayOfWeek.Thursday, "<input
                    type="text" size="15" id="dayOfWeekFullTranslation4" value="Thursday">");</label> <span
                class="error" id="dayOfWeekFullTranslation4Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekFullTranslation(TheDatepicker.DayOfWeek.Friday, "<input
                    type="text" size="15" id="dayOfWeekFullTranslation5" value="Friday">");</label> <span class="error"
                                                                                                          id="dayOfWeekFullTranslation5Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekFullTranslation(TheDatepicker.DayOfWeek.Saturday, "<input
                    type="text" size="15" id="dayOfWeekFullTranslation6" value="Saturday">");</label> <span
                class="error" id="dayOfWeekFullTranslation6Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setDayOfWeekFullTranslation(TheDatepicker.DayOfWeek.Sunday, "<input
                    type="text" size="15" id="dayOfWeekFullTranslation0" value="Sunday">");</label> <span class="error"
                                                                                                          id="dayOfWeekFullTranslation0Error"></span>
        </li>

        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.January, "<input type="text"
                                                                                                          size="15"
                                                                                                          id="monthTranslation0"
                                                                                                          value="January">");</label>
            <span class="error" id="monthTranslation0Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.February, "<input type="text"
                                                                                                           size="15"
                                                                                                           id="monthTranslation1"
                                                                                                           value="February">");</label>
            <span class="error" id="monthTranslation1Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.March, "<input type="text"
                                                                                                        size="15"
                                                                                                        id="monthTranslation2"
                                                                                                        value="March">");</label>
            <span class="error" id="monthTranslation2Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.April, "<input type="text"
                                                                                                        size="15"
                                                                                                        id="monthTranslation3"
                                                                                                        value="April">");</label>
            <span class="error" id="monthTranslation3Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.May, "<input type="text"
                                                                                                      size="15"
                                                                                                      id="monthTranslation4"
                                                                                                      value="May">");</label>
            <span class="error" id="monthTranslation4Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.June, "<input type="text"
                                                                                                       size="15"
                                                                                                       id="monthTranslation5"
                                                                                                       value="June">");</label>
            <span class="error" id="monthTranslation5Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.July, "<input type="text"
                                                                                                       size="15"
                                                                                                       id="monthTranslation6"
                                                                                                       value="July">");</label>
            <span class="error" id="monthTranslation6Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.August, "<input type="text"
                                                                                                         size="15"
                                                                                                         id="monthTranslation7"
                                                                                                         value="August">");</label>
            <span class="error" id="monthTranslation7Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.September, "<input type="text"
                                                                                                            size="15"
                                                                                                            id="monthTranslation8"
                                                                                                            value="September">");</label>
            <span class="error" id="monthTranslation8Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.October, "<input type="text"
                                                                                                          size="15"
                                                                                                          id="monthTranslation9"
                                                                                                          value="October">");</label>
            <span class="error" id="monthTranslation9Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.November, "<input type="text"
                                                                                                           size="15"
                                                                                                           id="monthTranslation10"
                                                                                                           value="November">");</label>
            <span class="error" id="monthTranslation10Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthTranslation(TheDatepicker.Month.December, "<input type="text"
                                                                                                           size="15"
                                                                                                           id="monthTranslation11"
                                                                                                           value="December">");</label>
            <span class="error" id="monthTranslation11Error"></span>
        </li>

        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.January, "<input
                    type="text" size="15" id="monthShortTranslation0" value="Jan">");</label> <span class="error"
                                                                                                    id="monthShortTranslation0Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.February, "<input
                    type="text" size="15" id="monthShortTranslation1" value="Feb">");</label> <span class="error"
                                                                                                    id="monthShortTranslation1Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.March, "<input type="text"
                                                                                                             size="15"
                                                                                                             id="monthShortTranslation2"
                                                                                                             value="Mar">");</label>
            <span class="error" id="monthShortTranslation2Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.April, "<input type="text"
                                                                                                             size="15"
                                                                                                             id="monthShortTranslation3"
                                                                                                             value="Apr">");</label>
            <span class="error" id="monthShortTranslation3Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.May "<input type="text"
                                                                                                          size="15"
                                                                                                          id="monthShortTranslation4"
                                                                                                          value="May">);</label>
            <span class="error" id="monthShortTranslation4Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.June, "<input type="text"
                                                                                                            size="15"
                                                                                                            id="monthShortTranslation5"
                                                                                                            value="Jun">");</label>
            <span class="error" id="monthShortTranslation5Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.July, "<input type="text"
                                                                                                            size="15"
                                                                                                            id="monthShortTranslation6"
                                                                                                            value="Jul">");</label>
            <span class="error" id="monthShortTranslation6Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.August, "<input
                    type="text" size="15" id="monthShortTranslation7" value="Aug">");</label> <span class="error"
                                                                                                    id="monthShortTranslation7Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.September, "<input
                    type="text" size="15" id="monthShortTranslation8" value="Sep">");</label> <span class="error"
                                                                                                    id="monthShortTranslation8Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.October, "<input
                    type="text" size="15" id="monthShortTranslation9" value="Oct">");</label> <span class="error"
                                                                                                    id="monthShortTranslation9Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.November, "<input
                    type="text" size="15" id="monthShortTranslation10" value="Nov">");</label> <span class="error"
                                                                                                     id="monthShortTranslation10Error"></span>
        </li>
        <li>
            <label>datepicker.options.translator.setMonthShortTranslation(TheDatepicker.Month.December, "<input
                    type="text" size="15" id="monthShortTranslation11" value="Dec">");</label> <span class="error"
                                                                                                     id="monthShortTranslation11Error"></span>
        </li>

        <li>
            <label>datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.GoBack, "<input type="text"
                                                                                                             size="15"
                                                                                                             id="goBackTranslation"
                                                                                                             value="Previous month">");</label>
        </li>
        <li>
            <label>datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.GoForward, "<input
                    type="text" size="15" id="goForwardTranslation" value="Next month">");</label>
        </li>
        <li>
            <label>datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.Close, "<input type="text"
                                                                                                            size="15"
                                                                                                            id="closeTranslation"
                                                                                                            value="Close">");</label>
        </li>
        <li class="space">
            <label>datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.Reset, "<input type="text"
                                                                                                            size="15"
                                                                                                            id="resetTranslation"
                                                                                                            value="Reset">");</label>
        </li>
        <li>
            <label>var datepickerPromise = TheDatepicker.onDatepickerReady(input, function (datepicker) {<br>
                &nbsp;<textarea rows="3" cols="70" id="onDatepickerReady">// this instanceof HTMLElement</textarea><br>
                });</label>
        </li>
        <li class="space">
            <label>(async () => {<br>
                &nbsp;<textarea rows="3" cols="70"
                                id="datepickerPromise">var datepicker = await datepickerPromise;</textarea><br>
                })();</label>
        </li>
        <li>
            datepicker.render();
        </li>
    </ul>

    <footer class="footer text-center py-2 theme-bg-dark">

        <!--/* This template is released under the Creative Commons Attribution 3.0 License. Please keep the attribution link below when using for your own project. Thank you for your support. :) If you'd like to use the template without the attribution, you can buy the commercial license via our website: themes.3rdwavemedia.com */-->
        <small class="copyright">Designed with <i class="fas fa-heart" style="color: #fb866a;"></i> by <a
                href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>

    </footer>

</div><!--//main-wrapper-->

<script type="text/javascript" style="display: none">
    (function () {
        var inputs = document.getElementsByClassName('dateInputs');

        for (let jj = 0; jj < inputs.length; jj++) {

            var datepicker = new TheDatepicker.Datepicker(inputs[jj]);

            var selectedDateOutput = document.getElementById('selectedDate');
            var selectedDateFormattedOutput = document.getElementById('selectedDateFormatted');
            var updateSelectedDate = function () {
                var selectedDate = datepicker.getSelectedDate();
                selectedDateOutput.innerText = selectedDate !== null ? '.toString() === "' + selectedDate.toString() + '"' : ' === null';
                var selectedDateFormatted = datepicker.getSelectedDateFormatted();
                selectedDateFormattedOutput.innerText = selectedDateFormatted !== null ? '"' + selectedDateFormatted + '"' : 'null';
            };
            datepicker.options.onSelect(updateSelectedDate);
            updateSelectedDate();

            var currentMonthOutput = document.getElementById('currentMonth');
            var updateCurrentMonth = function () {
                var currentMonth = datepicker.getCurrentMonth();
                currentMonthOutput.innerText = currentMonth !== null ? '.toString() === "' + currentMonth.toString() + '"' : ' === null';
            };
            datepicker.options.onMonthChange(updateCurrentMonth);
            updateCurrentMonth();

            datepicker.options.setInputFormat("j.n.Y");

            datepicker.render();

            var updateSetting = function (settingInput, callback, doNotCallRender) {
                settingInput.className = '';
                var errorOutput = document.getElementById(settingInput.id + 'Error');
                if (errorOutput !== null) {
                    errorOutput.innerText = '';
                }

                try {
                    callback();
                    if (!doNotCallRender) {
                        datepicker.render();
                    }
                } catch (error) {
                    console.error(error);
                    settingInput.className = 'invalid';
                    if (errorOutput !== null) {
                        errorOutput.innerText = error.toString();
                    }
                }
            };

            var createCallback = function (argumentsString, body) {
                return (new Function('{ return function(' + argumentsString + ') { ' + body + ' } };'))();
            };

            var updateListener = function (eventName, body, argumentsString) {
                var eventNameCapitalized = eventName.charAt(0).toUpperCase() + eventName.slice(1);

                datepicker.options['off' + eventNameCapitalized]();

                if (eventName === 'select') {
                    datepicker.options.onSelect(updateSelectedDate);
                } else if (eventName === 'monthChange') {
                    datepicker.options.onMonthChange(updateCurrentMonth);
                }

                if (body === '') {
                    return;
                }

                datepicker.options['on' + eventNameCapitalized](createCallback(argumentsString, body));
            };

            var removeListener = function (eventName) {
                updateListener(eventName, '');
                var eventNameCapitalized = eventName.charAt(0).toUpperCase() + eventName.slice(1);
                document.getElementById('on' + eventNameCapitalized).value = '';
            };

            var datepicker1Text = document.getElementById('datepicker1');
            var datepicker2Input = document.getElementById('datepicker2');
            datepicker2Input.onclick = function () {
                datepicker = new TheDatepicker.Datepicker(input, null, datepicker.options);
                datepicker1Text.className = '';
                datepicker2Input.className = 'hidden';
                datepicker.render();
            };

            var initialDateInput = document.getElementById('initialDate');
            initialDateInput.onchange = function () {
                updateSetting(initialDateInput, function () {
                    datepicker.options.setInitialDate(initialDateInput.value !== '' ? initialDateInput.value : null);
                });
            };

            var initialMonthInput = document.getElementById('initialMonth');
            initialMonthInput.onchange = function () {
                updateSetting(initialMonthInput, function () {
                    datepicker.options.setInitialMonth(initialMonthInput.value !== '' ? initialMonthInput.value : null);
                });
            };

            var initialDatePriorityInput = document.getElementById('initialDatePriority');
            initialDatePriorityInput.onchange = function () {
                updateSetting(initialDatePriorityInput, function () {
                    datepicker.options.setInitialDatePriority(initialDatePriorityInput.checked);
                });
            };

            var openInput = document.getElementById('open');
            openInput.onclick = function () {
                datepicker.open();
            };

            var closeInput = document.getElementById('close');
            closeInput.onclick = function () {
                datepicker.close();
            };

            var resetInput = document.getElementById('reset');
            resetInput.onclick = function () {
                datepicker.reset();
            };

            var destroyInput = document.getElementById('destroy');
            destroyInput.onclick = function () {
                datepicker.destroy();
                datepicker1Text.className = 'hidden';
                datepicker2Input.className = '';
            };

            var selectDateInput = document.getElementById('selectDate');
            selectDateInput.onchange = function () {
                updateSetting(selectDateInput, function () {
                    datepicker.selectDate(selectDateInput.value, document.getElementById('selectDateDoUpdateMonth').checked);
                    selectDateInput.value = '';
                }, true);
            };

            var goToMonthInput = document.getElementById('goToMonth');
            goToMonthInput.onchange = function () {
                updateSetting(goToMonthInput, function () {
                    datepicker.goToMonth(goToMonthInput.value);
                    goToMonthInput.value = '';
                }, true);
            };

            var hideOnBlurInput = document.getElementById('hideOnBlur');
            hideOnBlurInput.onchange = function () {
                updateSetting(hideOnBlurInput, function () {
                    datepicker.options.setHideOnBlur(hideOnBlurInput.checked);
                });
            };

            var hideOnSelectInput = document.getElementById('hideOnSelect');
            hideOnSelectInput.onchange = function () {
                updateSetting(hideOnSelectInput, function () {
                    datepicker.options.setHideOnSelect(hideOnSelectInput.checked);
                });
            };

            var inputFormatInput = document.getElementById('inputFormat');
            inputFormatInput.onchange = function () {
                updateSetting(inputFormatInput, function () {
                    datepicker.options.setInputFormat(inputFormatInput.value);
                    updateSelectedDate();
                });
            };

            var firstDayOfWeekInput = document.getElementById('firstDayOfWeek');
            firstDayOfWeekInput.onchange = function () {
                updateSetting(firstDayOfWeekInput, function () {
                    datepicker.options.setFirstDayOfWeek(firstDayOfWeekInput.value);
                });
            };

            var minDateInput = document.getElementById('minDate');
            minDateInput.onchange = function () {
                updateSetting(minDateInput, function () {
                    datepicker.options.setMinDate(minDateInput.value !== '' ? minDateInput.value : null);
                });
            };

            var maxDateInput = document.getElementById('maxDate');
            maxDateInput.onchange = function () {
                updateSetting(maxDateInput, function () {
                    datepicker.options.setMaxDate(maxDateInput.value !== '' ? maxDateInput.value : null);
                });
            };

            var dropdownItemsLimitInput = document.getElementById('dropdownItemsLimit');
            dropdownItemsLimitInput.onchange = function () {
                updateSetting(dropdownItemsLimitInput, function () {
                    datepicker.options.setDropdownItemsLimit(dropdownItemsLimitInput.value !== '' ? dropdownItemsLimitInput.value : null);
                });
            };

            var hideDropdownWithOneItemInput = document.getElementById('hideDropdownWithOneItem');
            hideDropdownWithOneItemInput.onchange = function () {
                updateSetting(hideDropdownWithOneItemInput, function () {
                    datepicker.options.setHideDropdownWithOneItem(hideDropdownWithOneItemInput.checked);
                });
            };

            var daysOutOfMonthVisibleInput = document.getElementById('daysOutOfMonthVisible');
            daysOutOfMonthVisibleInput.onchange = function () {
                updateSetting(daysOutOfMonthVisibleInput, function () {
                    datepicker.options.setDaysOutOfMonthVisible(daysOutOfMonthVisibleInput.checked);
                });
            };

            var fixedRowsCountInput = document.getElementById('fixedRowsCount');
            fixedRowsCountInput.onchange = function () {
                updateSetting(fixedRowsCountInput, function () {
                    datepicker.options.setFixedRowsCount(fixedRowsCountInput.checked);
                });
            };

            var toggleSelectionInput = document.getElementById('toggleSelection');
            toggleSelectionInput.onchange = function () {
                updateSetting(toggleSelectionInput, function () {
                    datepicker.options.setToggleSelection(toggleSelectionInput.checked);
                });
            };

            var showDeselectButtonInput = document.getElementById('showDeselectButton');
            showDeselectButtonInput.onchange = function () {
                updateSetting(showDeselectButtonInput, function () {
                    datepicker.options.setShowDeselectButton(showDeselectButtonInput.checked);
                });
            };

            var allowEmptyInput = document.getElementById('allowEmpty');
            allowEmptyInput.onchange = function () {
                updateSetting(allowEmptyInput, function () {
                    datepicker.options.setAllowEmpty(allowEmptyInput.checked);
                });
            };

            var showCloseButtonInput = document.getElementById('showCloseButton');
            showCloseButtonInput.onchange = function () {
                updateSetting(showCloseButtonInput, function () {
                    datepicker.options.setShowCloseButton(showCloseButtonInput.checked);
                });
            };

            var titleInput = document.getElementById('title');
            titleInput.onchange = function () {
                updateSetting(titleInput, function () {
                    datepicker.options.setTitle(titleInput.value);
                });
            };

            var showResetButtonInput = document.getElementById('showResetButton');
            showResetButtonInput.onchange = function () {
                updateSetting(showResetButtonInput, function () {
                    datepicker.options.setShowResetButton(showResetButtonInput.checked);
                });
            };

            var monthAsDropdownInput = document.getElementById('monthAsDropdown');
            monthAsDropdownInput.onchange = function () {
                updateSetting(monthAsDropdownInput, function () {
                    datepicker.options.setMonthAsDropdown(monthAsDropdownInput.checked);
                });
            };

            var yearAsDropdownInput = document.getElementById('yearAsDropdown');
            yearAsDropdownInput.onchange = function () {
                updateSetting(yearAsDropdownInput, function () {
                    datepicker.options.setYearAsDropdown(yearAsDropdownInput.checked);
                });
            };

            var monthAndYearSeparatedInput = document.getElementById('monthAndYearSeparated');
            monthAndYearSeparatedInput.onchange = function () {
                updateSetting(monthAndYearSeparatedInput, function () {
                    datepicker.options.setMonthAndYearSeparated(monthAndYearSeparatedInput.checked);
                });
            };

            var monthShortInput = document.getElementById('monthShort');
            monthShortInput.onchange = function () {
                updateSetting(monthShortInput, function () {
                    datepicker.options.setMonthShort(monthShortInput.checked);
                });
            };

            var changeMonthOnSwipeInput = document.getElementById('changeMonthOnSwipe');
            changeMonthOnSwipeInput.onchange = function () {
                updateSetting(changeMonthOnSwipeInput, function () {
                    datepicker.options.setChangeMonthOnSwipe(changeMonthOnSwipeInput.checked);
                });
            };

            var animateMonthChangeInput = document.getElementById('animateMonthChange');
            animateMonthChangeInput.onchange = function () {
                updateSetting(animateMonthChangeInput, function () {
                    datepicker.options.setAnimateMonthChange(animateMonthChangeInput.checked);
                });
            };

            var positionFixingInput = document.getElementById('positionFixing');
            positionFixingInput.onchange = function () {
                updateSetting(positionFixingInput, function () {
                    datepicker.options.setPositionFixing(positionFixingInput.checked);
                });
            };

            var dateAvailabilityResolverInput = document.getElementById('dateAvailabilityResolver');
            dateAvailabilityResolverInput.onchange = function () {
                if (dateAvailabilityResolverInput.value === '') {
                    datepicker.options.setDateAvailabilityResolver(null);
                } else {
                    datepicker.options.setDateAvailabilityResolver(createCallback('date', dateAvailabilityResolverInput.value));
                }
                datepicker.render();
            };

            var cellContentResolverInput = document.getElementById('cellContentResolver');
            cellContentResolverInput.onchange = function () {
                if (cellContentResolverInput.value === '') {
                    datepicker.options.setCellContentResolver(null);
                } else {
                    datepicker.options.setCellContentResolver(createCallback('day', cellContentResolverInput.value));
                }
                datepicker.render();
            };

            var cellContentStructureResolverInitInput = document.getElementById('cellContentStructureResolverInit');
            var cellContentStructureResolverUpdateInput = document.getElementById('cellContentStructureResolverUpdate');
            var cellContentStructureResolverUpdateListener = function () {
                if (cellContentStructureResolverInitInput.value === '' || cellContentStructureResolverUpdateInput.value === '') {
                    datepicker.options.setCellContentStructureResolver(null);
                } else {
                    datepicker.options.setCellContentStructureResolver(
                        createCallback('', cellContentStructureResolverInitInput.value),
                        createCallback('element, day', cellContentStructureResolverUpdateInput.value)
                    );
                }
                datepicker.render();
            };
            cellContentStructureResolverInitInput.onchange = cellContentStructureResolverUpdateListener;
            cellContentStructureResolverUpdateInput.onchange = cellContentStructureResolverUpdateListener;

            var cellClassesResolverInput = document.getElementById('cellClassesResolver');
            cellClassesResolverInput.onchange = function () {
                datepicker.options.removeCellClassesResolver();
                if (cellClassesResolverInput.value !== '') {
                    datepicker.options.addCellClassesResolver(createCallback('day', cellClassesResolverInput.value));
                }
                datepicker.render();
            };

            var dayModifierInput = document.getElementById('dayModifier');
            dayModifierInput.onchange = function () {
                datepicker.options.removeDayModifier();
                if (dayModifierInput.value !== '') {
                    datepicker.options.addDayModifier(createCallback('day', dayModifierInput.value));
                }
                datepicker.render();
            };

            var headerStructureResolverInput = document.getElementById('headerStructureResolver');
            headerStructureResolverInput.onchange = function () {
                if (headerStructureResolverInput.value === '') {
                    datepicker.options.setHeaderStructureResolver(null);
                } else {
                    datepicker.options.setHeaderStructureResolver(createCallback('', headerStructureResolverInput.value));
                }
            };

            var footerStructureResolverInput = document.getElementById('footerStructureResolver');
            footerStructureResolverInput.onchange = function () {
                if (footerStructureResolverInput.value === '') {
                    datepicker.options.setFooterStructureResolver(null);
                } else {
                    datepicker.options.setFooterStructureResolver(createCallback('', footerStructureResolverInput.value));
                }
            };

            var onBeforeSelectInput = document.getElementById('onBeforeSelect');
            onBeforeSelectInput.onchange = function () {
                updateListener('beforeSelect', onBeforeSelectInput.value, 'event, day, previousDay');
            };

            var onSelectInput = document.getElementById('onSelect');
            onSelectInput.onchange = function () {
                updateListener('select', onSelectInput.value, 'event, day, previousDay');
            };

            var onBeforeOpenAndCloseInput = document.getElementById('onBeforeOpenAndClose');
            onBeforeOpenAndCloseInput.onchange = function () {
                updateListener('beforeOpenAndClose', onBeforeOpenAndCloseInput.value, 'event, isOpening');
            };

            var onOpenAndCloseInput = document.getElementById('onOpenAndClose');
            onOpenAndCloseInput.onchange = function () {
                updateListener('openAndClose', onOpenAndCloseInput.value, 'event, isOpening');
            };

            var onBeforeMonthChangeInput = document.getElementById('onBeforeMonthChange');
            onBeforeMonthChangeInput.onchange = function () {
                updateListener('beforeMonthChange', onBeforeMonthChangeInput.value, 'event, month, previousMonth');
            };

            var onMonthChangeInput = document.getElementById('onMonthChange');
            onMonthChangeInput.onchange = function () {
                updateListener('monthChange', onMonthChangeInput.value, 'event, month, previousMonth');
            };

            var onBeforeFocusInput = document.getElementById('onBeforeFocus');
            onBeforeFocusInput.onchange = function () {
                updateListener('beforeFocus', onBeforeFocusInput.value, 'event, day, previousDay');
            };

            var onFocusInput = document.getElementById('onFocus');
            onFocusInput.onchange = function () {
                updateListener('focus', onFocusInput.value, 'event, day, previousDay');
            };

            var removeCellClassesResolverInput = document.getElementById('removeCellClassesResolver');
            removeCellClassesResolverInput.onclick = function () {
                datepicker.options.removeCellClassesResolver();
                document.getElementById('cellClassesResolver').value = '';
            };

            var removeDayModifierInput = document.getElementById('removeDayModifier');
            removeDayModifierInput.onclick = function () {
                datepicker.options.removeDayModifier();
                document.getElementById('dayModifier').value = '';
            };

            var offBeforeSelectInput = document.getElementById('offBeforeSelect');
            offBeforeSelectInput.onclick = function () {
                removeListener('beforeSelect');
            };

            var offSelectInput = document.getElementById('offSelect');
            offSelectInput.onclick = function () {
                removeListener('select');
            };

            var offBeforeOpenAndCloseInput = document.getElementById('offBeforeOpenAndClose');
            offBeforeOpenAndCloseInput.onclick = function () {
                removeListener('beforeOpenAndClose');
            };

            var offOpenAndCloseInput = document.getElementById('offOpenAndClose');
            offOpenAndCloseInput.onclick = function () {
                removeListener('openAndClose');
            };

            var offBeforeMonthChangeInput = document.getElementById('offBeforeMonthChange');
            offBeforeMonthChangeInput.onclick = function () {
                removeListener('beforeMonthChange');
            };

            var offMonthChangeInput = document.getElementById('offMonthChange');
            offMonthChangeInput.onclick = function () {
                removeListener('monthChange');
            };

            var offBeforeFocusInput = document.getElementById('offBeforeFocus');
            offBeforeFocusInput.onclick = function () {
                removeListener('beforeFocus');
            };

            var offFocusInput = document.getElementById('offFocus');
            offFocusInput.onclick = function () {
                removeListener('focus');
            };

            var classesPrefixInput = document.getElementById('classesPrefix');
            classesPrefixInput.onchange = function () {
                updateSetting(classesPrefixInput, function () {
                    datepicker.options.setClassesPrefix(classesPrefixInput.value);
                });
            };

            var todayInput = document.getElementById('today');
            todayInput.onchange = function () {
                updateSetting(todayInput, function () {
                    datepicker.options.setToday(todayInput.value);
                });
            };

            var goBackHtmlInput = document.getElementById('goBackHtml');
            goBackHtmlInput.onchange = function () {
                updateSetting(goBackHtmlInput, function () {
                    datepicker.options.setGoBackHtml(goBackHtmlInput.value);
                });
            };

            var goForwardHtmlInput = document.getElementById('goForwardHtml');
            goForwardHtmlInput.onchange = function () {
                updateSetting(goForwardHtmlInput, function () {
                    datepicker.options.setGoForwardHtml(goForwardHtmlInput.value);
                });
            };

            var closeHtmlInput = document.getElementById('closeHtml');
            closeHtmlInput.onchange = function () {
                updateSetting(closeHtmlInput, function () {
                    datepicker.options.setCloseHtml(closeHtmlInput.value);
                });
            };

            var resetHtmlInput = document.getElementById('resetHtml');
            resetHtmlInput.onchange = function () {
                updateSetting(resetHtmlInput, function () {
                    datepicker.options.setResetHtml(resetHtmlInput.value);
                });
            };

            var deselectHtmlInput = document.getElementById('deselectHtml');
            deselectHtmlInput.onchange = function () {
                updateSetting(deselectHtmlInput, function () {
                    datepicker.options.setReselectHtml(deselectHtmlInput.value);
                });
            };

            for (var i = 0; i < 7; i++) {
                (function () {
                    var dayOfWeek = i;
                    var dayOfWeekTranslationInput = document.getElementById('dayOfWeekTranslation' + dayOfWeek);
                    dayOfWeekTranslationInput.onchange = function () {
                        updateSetting(dayOfWeekTranslationInput, function () {
                            datepicker.options.translator.setDayOfWeekTranslation(dayOfWeek, dayOfWeekTranslationInput.value);
                        });
                    };
                })();
            }

            for (var i = 0; i < 7; i++) {
                (function () {
                    var dayOfWeek = i;
                    var dayOfWeekFullTranslationInput = document.getElementById('dayOfWeekFullTranslation' + dayOfWeek);
                    dayOfWeekFullTranslationInput.onchange = function () {
                        updateSetting(dayOfWeekFullTranslationInput, function () {
                            datepicker.options.translator.setDayOfWeekFullTranslation(dayOfWeek, dayOfWeekFullTranslationInput.value);
                        });
                    };
                })();
            }

            for (var j = 0; j < 12; j++) {
                (function () {
                    var month = j;
                    var monthTranslationInput = document.getElementById('monthTranslation' + month);
                    monthTranslationInput.onchange = function () {
                        updateSetting(monthTranslationInput, function () {
                            datepicker.options.translator.setMonthTranslation(month, monthTranslationInput.value);
                        });
                    };
                })();
            }

            for (var j = 0; j < 12; j++) {
                (function () {
                    var month = j;
                    var monthShortTranslationInput = document.getElementById('monthShortTranslation' + month);
                    monthShortTranslationInput.onchange = function () {
                        updateSetting(monthShortTranslationInput, function () {
                            datepicker.options.translator.setMonthShortTranslation(month, monthShortTranslationInput.value);
                        });
                    };
                })();
            }

            var goBackTranslationInput = document.getElementById('goBackTranslation');
            goBackTranslationInput.onchange = function () {
                updateSetting(goBackTranslationInput, function () {
                    datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.GoBack, goBackTranslationInput.value);
                });
            };

            var goForwardTranslationInput = document.getElementById('goForwardTranslation');
            goForwardTranslationInput.onchange = function () {
                updateSetting(goForwardTranslationInput, function () {
                    datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.GoForward, goForwardTranslationInput.value);
                });
            };

            var closeTranslationInput = document.getElementById('closeTranslation');
            closeTranslationInput.onchange = function () {
                updateSetting(closeTranslationInput, function () {
                    datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.Close, closeTranslationInput.value);
                });
            };

            var resetTranslationInput = document.getElementById('resetTranslation');
            resetTranslationInput.onchange = function () {
                updateSetting(resetTranslationInput, function () {
                    datepicker.options.translator.setTitleTranslation(TheDatepicker.TitleName.Reset, resetTranslationInput.value);
                });
            };

            var onDatepickerReadyInput = document.getElementById('onDatepickerReady');
            onDatepickerReadyInput.onchange = function () {
                if (onDatepickerReadyInput.value !== '') {
                    TheDatepicker.onDatepickerReady(input, createCallback('datepicker', onDatepickerReadyInput.value));
                }
            };

            var datepickerPromiseInput = document.getElementById('datepickerPromise');
            datepickerPromiseInput.onchange = function () {
                if (datepickerPromiseInput.value !== '') {
                    (new Function('{ return async function(datepickerPromise) { ' + datepickerPromiseInput.value + ' } };'))()(TheDatepicker.onDatepickerReady(input));
                }
            };

        }

    })();
</script>

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

