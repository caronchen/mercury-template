<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>

<mercury:template-parts containerName="mercury-page">

<jsp:attribute name="top">

<c:set var="cmsstatus">${cms.isEditMode ? 'opencms-page-editor ' : ''}${cms.isEditMode and cms.modelGroupPage ? 'opencms-group-editor ' : ''}</c:set>
<!DOCTYPE html>
<html lang="${cms.locale}" class="noscript ${cmsstatus}">
<head>

<%-- Special CSS in case JavaScript is disabled --%>
<noscript><style>html.noscript .hide-noscript { display: none; }</style></noscript>

<script>
<%-- Static JavaScript that provides a 'mercury.ready()' method for additional scripts --%>
mercury=function(){var n=function(){var n=[];return{ready:function(t){n.push(t)},load:function(t){n.push(t)},getInitFunctions:function(){return n}}}(),t=function(t){if("function"!=typeof t)return n;n.ready(t)};return t.getInitFunctions=function(){return n.getInitFunctions()},t.load=function(n){this(n)},t.ready=function(n){this(n)},t}();
var __isOnline=${cms.isOnlineProject},
__scriptPath="<cms:link>%(link.weak:/system/modules/alkacon.mercury.theme/js/mercury.js:2cf5d884-fea8-11e8-aee0-0242ac11002b)</cms:link>"
</script>
<%-- Load the main JavaScript in async mode --%>
<c:set var="jsThemeRes" value="${cms.vfs.readResource['%(link.weak:/system/modules/alkacon.mercury.theme/js/mercury.js:2cf5d884-fea8-11e8-aee0-0242ac11002b)']}" />
<script async src="<cms:link>${jsThemeRes.sitePath}?ver=${jsThemeRes.dateLastModified}</cms:link>"></script>

<mercury:meta-info/>

<%-- Add favicon --%>
<c:set var="faviconPath"><cms:property name="mercury.template.favIcon" file="search" default="/favicon.png" /></c:set>
<c:if test="${not cms.vfs.existsResource[faviconPath] and cms.vfs.readResource[faviconPath].isImage}">
    <c:set var="faviconPath">system/modules/alkacon.mercury.theme/img/favicon.png</c:set>
</c:if>
<c:set var="favIconImage" value="${cms.vfs.readResource[faviconPath].toImage.scaleRatio['1-1']}" />
<link rel="apple-touch-icon" sizes="180x180" href="${favIconImage.scaleWidth[180]}">
<link rel="icon" type="image/png" sizes="32x32" href="${favIconImage.scaleWidth[32]}">
<link rel="icon" type="image/png" sizes="16x16" href="${favIconImage.scaleWidth[16]}">

<cms:enable-ade />
<cms:headincludes type="css" />

<c:set var="replaceCss"><cms:property name="mercury.template.replaceCss" file="search" default="none" /></c:set>
<c:choose>
    <c:when test="${not empty replaceCss and replaceCss ne 'none'}">
        <%-- This way an "extraHead" JSP can override the default CSS theme. --%>
        <cms:include file="${replaceCss}" />
    </c:when>
    <c:otherwise>
        <c:set var="cssTheme"><cms:property name="template.theme" file="search" default="/system/modules/alkacon.mercury.theme/css/theme-red.min.css" /></c:set>
        <c:set var="cssCommonRes" value="${cms.vfs.readResource['%(link.weak:/system/modules/alkacon.mercury.theme/css/base.min.css:bf8f6ace-feab-11e8-aee0-0242ac11002b)']}" />
        <c:set var="cssThemeRes" value="${cms.vfs.readResource[cssTheme]}" />
        <link rel="stylesheet" href="<cms:link>${cssCommonRes.sitePath}?ver=${cssCommonRes.dateLastModified}</cms:link>">
        <link rel="stylesheet" href="<cms:link>${cssThemeRes.sitePath}?ver=${cssThemeRes.dateLastModified}</cms:link>">
    </c:otherwise>
</c:choose>

<c:set var="extraHead"><cms:property name="mercury.template.extraHead" file="search" default="none" /></c:set>
<c:if test="${not empty extraHead and extraHead ne 'none'}"><cms:include file="${extraHead}" /></c:if>

</head>
<body>
</jsp:attribute>


<jsp:attribute name="middle">
<cms:container
    name="mercury-page"
    type="area"
    editableby="ROLE.DEVELOPER">

    <cms:param name="cssgrid" value="#" />

    <fmt:setLocale value="${cms.workplaceLocale}" />
    <cms:bundle basename="alkacon.mercury.template.messages">
        <c:set var="message"><fmt:message key="msg.page.layout.topContainer" /></c:set>
    </cms:bundle>

    <mercury:container-box
        label="${message}"
        boxType="container-box"
        type="area"
        role="ROLE.DEVELOPER"
    />
</cms:container>
</jsp:attribute>


<jsp:attribute name="bottom">
<%-- Page information transfers OpenCms state information to JavaScript --%>
<mercury:pageinfo />

<%-- JavaScript blocking files placed at the end of the document so the pages load faster --%>
<cms:headincludes type="javascript" />

<c:set var="extraFoot"><cms:property name="mercury.template.extraFoot" file="search" default="none" /></c:set>
<c:if test="${not empty extraFoot and extraFoot ne 'none'}"><cms:include file="${extraFoot}" /></c:if>

<%-- Privacy policy markup is inserted last --%>
<mercury:privacy-policy-banner />

</body>
</html>
</jsp:attribute>

</mercury:template-parts>





