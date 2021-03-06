<%@ tag
    pageEncoding="UTF-8"
    display-name="nav-items"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Loads navigation items based on a XML content configuration." %>


<%@ attribute name="content" type="org.opencms.jsp.util.CmsJspContentAccessBean" required="true"
    description="The navigation XML content configuration."%>

<%@ attribute name="currentPageUri" type="java.lang.String" required="true"
    description="The requested page URI."%>

<%@ attribute name="currentPageFolder" type="java.lang.String" required="true"
    description="The requested page folder URI."%>

<%@ attribute name="type" type="java.lang.String" required="true"
    description="The type of navigation to create. Valid values are 'forSite', 'forFolder' and 'breadCrumb'."%>

<%@ attribute name="var" type="java.lang.String" required="true"
    description="The variable name to store the result items in."%>


<%@ variable name-given="navStartLevel" declare="true"
    description="The start folder level for the navigation." %>

<%@ variable name-given="navDepth" declare="true"
    description="The depth of the navigation." %>

<%@ variable name-given="navStartFolder" declare="true"
    description="The start folder of the navigation." %>

<%@ variable name-given="nav" declare="true"
    description="The calculated navigation items." %>

<%@ variable name-given="nl" declare="true"
    description="A variable holding a newline / line break to use in JSP for output formatting." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="nl" value="<%= \"\n\" %>" />

<c:set var="navStartLevel" value="${not content.value.Root.value.NavStartLevel.isSet ? 0 :content.value.Root.value.NavStartLevel.toInteger}" />
<c:set var="navDepth" value="${(!content.value.NavDepth.isSet or content.value.NavDepth.toInteger < 0) ? 3 : content.value.NavDepth.toInteger}" />
<c:set var="endLevel" value="${navStartLevel + navDepth - 1}" />

<c:set var="navStartFolder" value="/" />
<c:if test="${content.value.Root.value.NavFolder.isSet}" >
    <c:choose>
    <c:when test="${fn:endsWith(content.value.Root.value.NavFolder.toString.concat('X'), '/X')}">
        <c:set var="navStartFolder" value="${content.value.Root.value.NavFolder.toString}" />
        <c:set var="pathparts" value="${fn:split(navStartFolder, '/')}" />
        <c:set var="navStartLevel">${fn:length(pathparts)}</c:set>
        <c:set var="endLevel" value="${navStartLevel + navDepth - 1}" />
        <c:if test="${type eq 'forSite'}">
            <c:set var="currentPageFolder">/</c:set>
        </c:if>
    </c:when>
    <c:otherwise>
        <c:set var="navStartFolder" value="INVALID" />
    </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${type eq 'breadCrumb'}">
    <c:set var="navStartLevel" value="${navStartLevel + 1}" />
</c:if>

<c:if test="${type eq 'rootBreadCrumb'}">
    <c:set var="navStartLevel" value="${navStartLevel}" />
    <c:set var="type" value="breadCrumb" />
</c:if>

<c:if test="${navStartFolder ne 'INVALID'}">

    <c:choose>
        <c:when test="${type eq 'forSite'}">
            <c:set var="pathparts" value="${fn:split(currentPageFolder, '/')}" />
            <c:forEach var="folderName" items="${pathparts}" varStatus="status">
                <c:if test="${status.count <= navStartLevel}">
                    <c:set var="navStartFolder">${navStartFolder}${folderName}/</c:set>
                </c:if>
            </c:forEach>
        </c:when>
        <c:when test="${type eq 'breadCrumb'}">
            <c:set var="endLevel" value="-1" />
            <c:set var="navStartFolder" value="${currentPageFolder}" />
        </c:when>
    </c:choose>

    <cms:navigation
        type="${type}"
        resource="${navStartFolder}"
        startLevel="${navStartLevel}"
        endLevel="${endLevel}"
        locale="${cms.locale}"
        param="true"
        var="nav" />
</c:if>

<c:choose>

<c:when test="${(navStartFolder ne 'INVALID') and fn:length(nav.items) > 0}">
<%-- Only output the tag body in case we have found some navigation items --%>
<jsp:doBody/>
</c:when>

<c:otherwise>
    <fmt:setLocale value="${cms.workplaceLocale}" />
    <cms:bundle basename="alkacon.mercury.template.messages">
        <%-- Output HTML debug comment --%>
        <!-- <fmt:message key="msg.page.navigation.empty" /> -->
        <c:if test="${not (type eq 'breadCrumb') and cms.isEditMode}">
            <!--
            type="${type}"
            currentPageFolder="${currentPageFolder}"
            currentPageUri="${currentPageUri}"
            navStartFolder="${navStartFolder}"
            navStartLevel="${navStartLevel}"
            endLevel="${endLevel}"
            navDepth="${navDepth}"
            locale="${cms.locale}"
            -->
            <div class="oct-meta">
                <div class="marker">
                    <fmt:message key="msg.page.navigation.empty" />
                </div>
            </div>
        </c:if>
    </cms:bundle>
</c:otherwise>

</c:choose>

