<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/init.jsp" %>

<%
long classPK = (long)request.getAttribute("contact_information.jsp-classPK");
String mvcActionPath = (String)request.getAttribute("contact_information.jsp-mvcActionPath");

ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Phone phone = (Phone)row.getObject();

long phoneId = phone.getPhoneId();
%>

<liferay-ui:icon-menu
	direction="left-side"
	icon="<%= StringPool.BLANK %>"
	markupView="lexicon"
	message="<%= StringPool.BLANK %>"
	showWhenSingleIcon="<%= true %>"
>
	<liferay-ui:icon
		cssClass="modify-phone-number-link"
		data="<%=
			new HashMap<String, Object>() {
				{
					put("title", LanguageUtil.get(request, "edit-phone-number"));
					put("primary-key", String.valueOf(phoneId));
				}
			}
		%>"
		message="edit"
		url="javascript:;"
	/>

	<%
	PortletURL portletURL = renderResponse.createActionURL();

	portletURL.setParameter(ActionRequest.ACTION_NAME, mvcActionPath);
	portletURL.setParameter("classPK", String.valueOf(classPK));
	portletURL.setParameter("listType", ListTypeConstants.PHONE);
	portletURL.setParameter("primaryKey", String.valueOf(phoneId));
	portletURL.setParameter("redirect", currentURL);

	PortletURL makePrimaryURL = PortletURLUtil.clone(portletURL, renderResponse);

	makePrimaryURL.setParameter(Constants.CMD, "makePrimary");
	%>

	<liferay-ui:icon
		message="make-primary"
		url="<%= makePrimaryURL.toString() %>"
	/>

	<%
	PortletURL removePhoneURL = PortletURLUtil.clone(portletURL, renderResponse);

	removePhoneURL.setParameter(Constants.CMD, Constants.DELETE);
	%>

	<liferay-ui:icon
		message="remove"
		url="<%= removePhoneURL.toString() %>"
	/>
</liferay-ui:icon-menu>