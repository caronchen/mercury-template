<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>

<cms:secureparams />
<mercury:init-messages>

<cms:formatter var="content" val="value">

<c:set var="setting"                value="${cms.element.setting}" />
<c:set var="cssWrapper"             value="${setting.cssWrapper}" />
<c:set var="keyPieceLayout"         value="${setting.keyPieceLayout.toInteger}" />
<c:set var="pieceLayout"            value="${setting.pieceLayout.toInteger}" />
<c:set var="visualEffect"           value="${setting.effect.toString}" />
<c:set var="hsize"                  value="${setting.hsize.toInteger}" />
<c:set var="imageRatio"             value="${setting.imageRatio}" />
<c:set var="showImageCopyright"     value="${setting.showImageCopyright.toBoolean}" />
<c:set var="showImageSubtitle"      value="${setting.showImageSubtitle.toBoolean}" />
<c:set var="showImageZoom"          value="${setting.showImageZoom.toBoolean}" />
<c:set var="showLocation"           value="${setting.showLocation.toBoolean}" />

<c:set var="dateFormat"             value="${setting.dateFormat.toString}" />
<c:set var="datePrefix"             value="${fn:substringBefore(dateFormat, '|')}" />
<c:set var="dateFormat"             value="${empty datePrefix ? dateFormat : fn:substringAfter(dateFormat, '|')}" />

<c:set var="firstParagraph"         value="${value.Introduction}" />
<c:set var="paragraphsContent"      value="${content.valueList.Text}" />

<mercury:location-data data="${value.AddressChoice}" test="${showLocation}">

<c:set var="date">
    <mercury:instancedate date="${value.Date.toInstanceDate}" format="${dateFormat}" />
</c:set>

<c:set var="intro"                  value="${value.Intro}" />
<c:set var="title"                  value="${value.Title}" />
<c:set var="preface"                value="${firstParagraph.value.Caption}" />
<c:set var="image"                  value="${firstParagraph.value.Image}" />
<c:set var="link"                   value="${firstParagraph.value.Link}" />
<c:set var="locationNote"           value="${value.LocationNote}" />
<c:set var="type"                   value="${value.Type}" />

<c:set var="showLocation"           value="${showLocation and (not empty locData or locationNote.isSet)}" />
<c:set var="showDate"               value="${not empty date}" />
<c:set var="showType"               value="${type.isSet}" />
<c:set var="ade"                    value="${true}" />
<c:set var="showOverlay"            value="${keyPieceLayout == 50}" />
<c:set var="keyPieceLayout"         value="${showOverlay ? 0 : keyPieceLayout}" />

<mercury:nl />
<div class="detail-page type-job ${cssWrapper}"><%----%>
<mercury:nl />

<mercury:piece
    cssWrapper="detail-visual"
    pieceLayout="${keyPieceLayout}"
    sizeDesktop="${6}"
    sizeMobile="${12}">

    <jsp:attribute name="heading">
        <c:if test="${not showOverlay}">
            <mercury:intro-headline intro="${intro}" headline="${title}" level="${hsize}" ade="${ade}"/>
            <mercury:heading text="${preface}" level="${7}" css="sub-header" ade="${ade}" test="${keyPieceLayout == 0}" />
        </c:if>
    </jsp:attribute>

    <jsp:attribute name="visual">
        <mercury:key-visual-piece
            image="${image}"
            showOverlay="${showOverlay}"
            effect="${visualEffect}"
            imageRatio="${imageRatio}"
            showImageSubtitle="${showImageSubtitle}"
            showImageZoom="${showImageZoom}"
            showImageCopyright="${showImageCopyright}"
            ade="${ade}">
            <jsp:attribute name="markupHeading">
                <mercury:intro-headline intro="${intro}" headline="${title}" level="${hsize}"/>
            </jsp:attribute>
        </mercury:key-visual-piece>
    </jsp:attribute>

    <jsp:attribute name="text">
        <mercury:heading text="${preface}" level="${7}" css="sub-header" ade="${ade}" test="${showOverlay or (keyPieceLayout != 0)}" />

        <c:if test="${showLocation}">
            <c:set var="location">
                <div>
                <c:if test="${not empty locData.name}">
                    <div class="locname">${locData.name}</div>
                </c:if>
                <div class="address">
                    <div class="street"> ${locData.streetAddress}</div>
                    <c:if test="${not empty locData.extendedAddress}">
                        <div class="extended"> ${locData.extendedAddress}</div>
                    </c:if>
                    <div class="city">
                        <span class="code"> ${locData.postalCode}</span>
                        <span class="locality"> ${locData.locality}</span>
                    </div>
                    <div class="region">
                        <c:if test="${not empty locData.region}">
                            <span class="region"> ${locData.region}</span>
                        </c:if>
                        <c:if test="${not empty locData.country}">
                            <span class="country"> ${locData.country}</span>
                        </c:if>
                    </div>
                </div>
                <c:if test="${locationNote.isSet}">
                    <div class="adressInfo" ${ade ? loocationNote.rdfaAttr : ''}>${locationNote}</div>
                </c:if>
                </div>
            </c:set>
        </c:if>

        <c:if test="${showDate or showLocation or showType}">
            <div class="visual-info ${not showLocation ? 'right' : ''}"><%----%>
                <div class="infogroup">
                    <c:if test="${showDate}"><div class="info date"><div>${datePrefix}${date}</div></div></c:if>
                    <c:if test="${showType}"><div class="info type"><div>${type}</div></div></c:if>
                </div>
                <c:if test="${showLocation}"><div class="info location">${location}</div></c:if>
            </div><%----%>
        </c:if>

        <c:if test="${firstParagraph.value.Text.isSet}">
            <div class="visual-text" ${firstParagraph.value.Text.rdfaAttr}><%----%>
                ${firstParagraph.value.Text}
            </div><%----%>
        </c:if>

        <c:if test="${link.isSet}">
            <div class="visual-link"><%----%>
                <mercury:link link="${link}" css="btn btn-sm"/>
            </div><%----%>
        </c:if>

    </jsp:attribute>
</mercury:piece>

<c:if test="${not empty paragraphsContent}">

    <div class="detail-content"><%----%>
        <c:forEach var="paragraph" items="${paragraphsContent}" varStatus="status">
            <mercury:section-piece
                pieceLayout="${pieceLayout}"
                heading="${paragraph.value.Caption}"
                image="${paragraph.value.Image}"
                text="${paragraph.value.Text}"
                link="${paragraph.value.Link}"
                showImageZoom="${showImageZoom}"
                showImageSubtitle="${showImageSubtitle}"
                showImageCopyright="${showImageCopyright}"
                hsize="${hsize + 1}"
                ade="${ade}"
                emptyWarning="${true}"
            />
        </c:forEach>
    </div><%----%>
    <mercury:nl />

</c:if>

<mercury:container-attachment content="${content}" name="attachments" />
<mercury:data-job content="${content}" />

</div><%----%>
<mercury:nl />

</mercury:location-data>
</cms:formatter>

</mercury:init-messages>
