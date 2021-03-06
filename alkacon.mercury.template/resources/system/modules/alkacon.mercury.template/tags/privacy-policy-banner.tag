<%@ tag
    pageEncoding="UTF-8"
    display-name="privacy-policy-banner"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Displays the 'privacy policy' cookie banner." %>


<%@ attribute name="template" type="java.lang.String" required="false"
    description="The template to generate the cookie banner for." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>


<c:if test="${not cms.isEditMode}">

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="alkacon.mercury.template.messages">

<c:set var="policyfile" value="${cms.vfs.readPropertiesSearch[cms.requestContext.uri]['mercury.privacy.policy']}" />

<c:if test="${not empty policyfile}">
<c:set var="policyfileBase64"><mercury:obfuscate text="${policyfile}" type="base64"/></c:set>

<div id="privacy-policy-banner" class="pp-banner" data-banner='{<%--
    --%>"policy":"${policyfileBase64}"<%--
--%>}'></div><%----%>
<mercury:nl />

<noscript><%----%>
    <div id="privacy-policy-banner-noscript" class="pp-banner" ><%----%>
        <div class=banner><%----%>
            <div class="container"><%----%>
                <div class="message"><fmt:message key="msg.page.javaScript.disabled" /></div><%----%>
            </div><%----%>
        </div><%----%>
    </div><%----%>
</noscript><%----%>
<mercury:nl />
</c:if>

</cms:bundle>

</c:if>
