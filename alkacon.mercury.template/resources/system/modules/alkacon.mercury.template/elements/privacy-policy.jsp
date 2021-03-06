<%@page
    buffer="none"
    session="false"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>

<cms:secureparams />

<!DOCTYPE html>
<html>
<body>

<c:set var="policyfile"><mercury:obfuscate text="${param.policy}" type="base64dec" /></c:set>
<c:choose>
    <c:when test="${not empty policyfile and cms.vfs.existsResource[policyfile]}">
        <mercury:display
            file="${policyfile}"
            formatter="%(link.weak:/system/modules/alkacon.mercury.template/formatters/privacy-policy/banner.xml:e9bb4c50-cfe2-456e-8c4e-72c9b2263577)"
        />
    </c:when>
    <c:otherwise>
        <!-- policy: [${policyfile}] -->
    </c:otherwise>
</c:choose>

</body>
</html>

