<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>


<cms:secureparams />
<mercury:init-messages>

<cms:formatter var="content" val="value">
<mercury:teaser-settings content="${content}">

<c:set var="intro"   value="${value.Intro}" />
<c:set var="title"   value="${value.Title}" />
<c:set var="preface" value="${value.Preface}" />

<mercury:teaser-piece
    cssWrapper="type-imageseries ${setEffect}${' '}${setCssWrapper}"
    intro="${setShowIntro ? intro : null}"
    headline="${title}"
    preface="${preface}"
    date="${value.Date.toInstanceDate}"
    paraText="${value.Text}"
    pieceLayout="${setPieceLayout}"
    sizeDesktop="${setSizeDesktop}"

    teaserType="${displayType}"
    link="${linkToDetail}"
    hsize="${setHsize}"
    dateFormat="${setDateFormat}"
    textLength="${setTextLength}"
    buttonText="${setButtonText}">

    <jsp:attribute name="markupVisual">
        <c:set var="image"   value="${value.Image}" />
        <mercury:image-animated image="${image}" ratio="${setRatio}" test="${not empty image}">
            <span class="centered fa fa-picture-o"></span>
        </mercury:image-animated>
    </jsp:attribute>

</mercury:teaser-piece>

</mercury:teaser-settings>
</cms:formatter>
</mercury:init-messages>