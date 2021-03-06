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

<mercury:init-messages>

<cms:formatter var="content" val="value">

<c:set var="setting"                value="${cms.element.setting}" />
<c:set var="cssWrapper"             value="${setting.cssWrapper}" />
<c:set var="hsize"                  value="${setting.hsize.toInteger}" />
<c:set var="cssVisibility"          value="${setting.cssVisibility.toString != 'always' ? setting.cssVisibility.toString : ''}" />

<mercury:nl />
<div class="element type-nav-side ${cssWrapper}${' '}${cssVisibility}"><%----%>
<mercury:nl />

    <mercury:heading level="${hsize}" text="${value.Title}" css="head" />

    <mercury:nav-items
        type="forSite"
        content="${content}"
        currentPageFolder="${cms.requestContext.folderUri}"
        currentPageUri="${cms.requestContext.uri}"
        var="nav">

    <c:set var="navLength" value="${fn:length(nav.items) - 1}" />

    <ul class="nav-side"><%----%>
        <mercury:nl />
        <c:forEach var="i" begin="0" end="${navLength}" >

            <c:set var="navElem" value="${nav.items[i]}" />
            <c:set var="nextLevel" value="${i < navLength ? nav.items[i+1].navTreeLevel : navStartLevel}" />
            <c:set var="startSubMenu" value="${nextLevel > navElem.navTreeLevel}" />
            <c:set var="isCurrentPage" value="${fn:startsWith(cms.requestContext.uri, cms.sitePath[navElem.resource.rootPath])}" />
            <c:set var="navLink"><cms:link>${navElem.resourceName}</cms:link></c:set>
            <c:set var="navTarget" value="${fn:trim(navElem.info)eq 'extern' ? ' target=\"_blank\"' : ''}" />

            <c:if test="${startSubMenu}">
                <c:set var="instanceId"><mercury:idgen prefix="" uuid="${cms.element.instanceId}" /></c:set>
                <c:set var="parentLabelId">label${instanceId}_${i}</c:set>
                <c:set var="targetMenuId">nav${instanceId}_${i}</c:set>
            </c:if>

            <c:set var="navText" value="${(empty navElem.navText or fn:startsWith(navElem.navText, '???')) ? navElem.title : navElem.navText}" />

            <c:set var="menuType" value="${startSubMenu ? menuType.concat(' aria-expanded=\"false\"') : menuType}" />

            <c:out value="<li${isCurrentPage ? ' class=\"currentpage\"' : ''}>" escapeXml="false" />

            <c:choose>
                <c:when test="${startSubMenu and navElem.navigationLevel}">
                    <%-- Navigation item with sub-menu but without direct child pages --%>
                    <a href="${navLink}"${navTarget}${' '}<%--
                    --%>id="${parentLabelId}"${' '}<%--
                    --%>${isCurrentPage ? ' aria-expanded=\"true\" class=\"collapse show\" ' : ' aria-expanded=\"false\"'}${' '}<%--
                    --%>data-toggle="collapse" data-target="#${targetMenuId}" <%--
                    --%>aria-controls="${targetMenuId}">${navText}</a><%--
            --%></c:when>

                <c:when test="${startSubMenu}">
                    <%-- Navigation item with sub-menu and direct child pages --%>
                    <a href="${navLink}"${navTarget} class="nav-label" id="${parentLabelId}">${navText}</a><%--
                    --%><a href="${navLink}"${navTarget} data-toggle="collapse" data-target="#${targetMenuId}" <%--
                    --%>${isCurrentPage ? ' aria-expanded=\"true\" class=\"collapse show\" ' : ' aria-expanded=\"false\"'}${' '}<%--
                    --%>aria-controls="${targetMenuId}">&nbsp;</a><%--
            --%></c:when>

                <c:otherwise>
                    <%--Navigation item without sub-menu --%>
                    <a href="${navLink}"${navTarget}>${navText}</a><%--
            --%></c:otherwise>
            </c:choose>

            <c:if test="${startSubMenu}">
               <c:set var="collapseIn" value="${isCurrentPage ? ' show' : ''}" />
               <mercury:nl />
               <c:out value='<ul class="collapse${collapseIn}" id="${targetMenuId}">' escapeXml="false" />
            </c:if>

            <c:if test="${nextLevel < navElem.navTreeLevel}">
                <c:forEach begin="1" end="${navElem.navTreeLevel - nextLevel}" >
                    <c:out value='</li></ul>' escapeXml="false" />
                    <mercury:nl />
                </c:forEach>
            </c:if>

            <c:if test="${not startSubMenu}">
                <c:out value='</li>' escapeXml="false" />
                <mercury:nl />
            </c:if>

        </c:forEach>
    </ul><%----%>
    <mercury:nl />

    </mercury:nav-items>
</div><%----%>
<mercury:nl />

</cms:formatter>
</mercury:init-messages>