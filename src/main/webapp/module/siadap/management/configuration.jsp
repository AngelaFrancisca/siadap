<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<%@ taglib uri="http://fenix-ashes.ist.utl.pt/fenix-renderers" prefix="fr"%>

<%-- The year chooser: --%>
<fr:form action="/siadapManagement.do?method=showConfiguration">
	<fr:edit id="siadapYearWrapper" name="siadapYearWrapper" nested="true">
		<fr:schema bundle="SIADAP" type="module.siadap.domain.wrappers.SiadapYearWrapper">
			<fr:slot name="chosenYearLabel" bundle="SIADAP_RESOURCES" layout="menu-select-postback" key="siadap.start.siadapYearChoice">
					<fr:property name="providerClass" value="module.siadap.presentationTier.renderers.providers.SiadapYearsFromExistingSiadapCfgPlusOne" />
					<fr:property name="nullOptionHidden" value="true"/>
					<%-- 
					<fr:property name="eachSchema" value="module.siadap.presentationTier.renderers.providers.SiadapYearConfigurationsFromExisting.year"/>
					--%>
			</fr:slot>
		</fr:schema>
		<fr:destination name="postBack" path="/siadapManagement.do?method=showConfiguration"/>
	</fr:edit>
</fr:form>  
<%--
<bean:define id="year" name="siadapYearWrapper" property="chosenYear"/>
<bean:define id="label" name="siadapYearWrapper" property="chosenYearLabel"/>
 --%>
<logic:notPresent name="configuration"> 
	<html:link page="/siadapManagement.do?method=createNewSiadapYearConfiguration" >
		<bean:message key="label.create.currentYearConfiguration" bundle="SIADAP_RESOURCES"/>
	</html:link>
</logic:notPresent>


<logic:present name="configuration">
<bean:define id="configurationId" name="configuration" property="externalId"/>

<fr:edit name="configuration"
	action="/siadapManagement.do?method=manageSiadap">
	<fr:schema type="module.siadap.domain.SiadapYearConfiguration"
		bundle="SIADAP_RESOURCES">
		<fr:slot name="biannual"/>
		<fr:slot name="unitRelations" layout="menu-select" key="label.config.unitRelations">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>
		<fr:slot name="harmonizationResponsibleRelation" layout="menu-select" key="label.config.harmonizationResponsibleRelation">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>

		<fr:slot name="workingRelation" layout="menu-select" key="label.config.workingRelation">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>
		
		<fr:slot name="workingRelationWithNoQuota" layout="menu-select" key="label.config.workingRelationWithNoQuota">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>
		
		<fr:slot name="evaluationRelation" layout="menu-select" key="label.config.evaluationRelation">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>
		
		<fr:slot name="siadap2HarmonizationRelation" layout="menu-select" key="label.config.siadap2HarmonizationRelation">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="choiceType"
				value="module.organization.domain.AccountabilityType" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>
		
		<fr:slot name="siadap3HarmonizationRelation" layout="menu-select" key="label.config.siadap3HarmonizationRelation">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="choiceType"
				value="module.organization.domain.AccountabilityType" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>
		
		<fr:slot name="harmonizationUnitRelations" layout="menu-select" key="label.config.harmonizationUnitRelations">
			<fr:property name="providerClass"
				value="module.organization.presentationTier.renderers.providers.AccountabilityTypesProvider" />
			<fr:property name="format" value="<%= "${name.content}" %>" />
			<fr:property name="sortBy" value="name" />
			<fr:property name="saveOptions" value="true" />
		</fr:slot>
		
		
		<fr:slot name="siadapStructureTopUnit" layout="autoComplete" key="label.config.siadapStructureTopUnit">
			<fr:property name="labelField" value="partyName.content" />
			<fr:property name="format" value="<%= "${presentationName}" %>" />
			<fr:property name="minChars" value="3" />
			<fr:property name="args"
				value="provider=module.organization.presentationTier.renderers.providers.UnitAutoCompleteProvider" />
			<fr:property name="size" value="60" />
			<fr:validator
				name="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
				<fr:property name="message" value="label.pleaseSelectOne.unit" />
				<fr:property name="bundle" value="SIADAP_RESOURCES" />
				<fr:property name="key" value="true" />
			</fr:validator>
		</fr:slot>
		
		<fr:slot name="siadapSpecialHarmonizationUnit" layout="autoComplete" key="label.config.siadapSpecialHarmonizationUnit">
			<fr:property name="labelField" value="partyName.content" />
			<fr:property name="format" value="<%= "${presentationName}" %>" />
			<fr:property name="minChars" value="3" />
			<fr:property name="args"
				value="provider=module.organization.presentationTier.renderers.providers.UnitAutoCompleteProvider" />
			<fr:property name="size" value="60" />
			<%--<fr:validator
				name="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
				<fr:property name="message" value="label.pleaseSelectOne.specialHarmonizationUnit" />
				<fr:property name="bundle" value="SIADAP_RESOURCES" />
				<fr:property name="key" value="true" />
			</fr:validator>--%>
		</fr:slot>

		<fr:slot name="quotaExcellencySiadap2WithQuota" key="label.config.quotaExcellencySiadap2WithQuota"/>
		<fr:slot name="quotaRelevantSiadap2WithQuota" key="label.config.quotaRelevantSiadap2WithQuota"/>
		<fr:slot name="quotaRegularSiadap2WithQuota" key="label.config.quotaRegularSiadap2WithQuota"/>
		
		<fr:slot name="quotaExcellencySiadap2WithoutQuota" key="label.config.quotaExcellencySiadap2WithoutQuota"/>
		<fr:slot name="quotaRelevantSiadap2WithoutQuota" key="label.config.quotaRelevantSiadap2WithoutQuota"/>
		<fr:slot name="quotaRegularSiadap2WithoutQuota" key="label.config.quotaRegularSiadap2WithoutQuota"/>
		
		<fr:slot name="quotaExcellencySiadap3WithQuota" key="label.config.quotaExcellencySiadap3WithQuota"/>
		<fr:slot name="quotaRelevantSiadap3WithQuota" key="label.config.quotaRelevantSiadap3WithQuota"/>
		<fr:slot name="quotaRegularSiadap3WithQuota" key="label.config.quotaRegularSiadap3WithQuota"/>
		
		<fr:slot name="quotaExcellencySiadap3WithoutQuota" key="label.config.quotaExcellencySiadap3WithoutQuota"/>
		<fr:slot name="quotaRelevantSiadap3WithoutQuota" key="label.config.quotaRelevantSiadap3WithoutQuota"/>
		<fr:slot name="quotaRegularSiadap3WithoutQuota" key="label.config.quotaRegularSiadap3WithoutQuota"/>
		
		<fr:slot name="reviewCommissionWaitingPeriod" key="label.config.reviewCommissionWaitingPeriod"/>
		
		<fr:slot name="objectiveSpecificationBegin" layout="picker" key="label.config.objectiveSpecificationBegin"/>
		<fr:slot name="objectiveSpecificationEnd" layout="picker" key="label.config.objectiveSpecificationEnd"/>
		<fr:slot name="autoEvaluationBegin" layout="picker"/>
		<fr:slot name="autoEvaluationEnd" layout="picker"/>
		<fr:slot name="evaluationBegin" layout="picker"/>
		<fr:slot name="evaluationEnd" layout="picker"/>
		<fr:slot name="firstLevelHarmonizationBegin" layout="picker"/>
		<fr:slot name="firstLevelHarmonizationEnd" layout="picker"/>
		<fr:slot name="lockHarmonizationOnQuota" key="label.config.lockHarmonizationOnQuota"/>
		<fr:slot name="lockHarmonizationOnQuotaOutsideOfQuotaUniverses" key="label.config.lockHarmonizationOnQuotaOutsideOfQuotaUniverses"/>
		
		
	</fr:schema>

	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2" />
	</fr:layout>
</fr:edit>
<br/>

<strong><bean:message key="label.ccaMembers" bundle="SIADAP_RESOURCES"/>:</strong>
<fr:view name="configuration" property="ccaMembers">
	<fr:schema type="module.organization.domain.Person" bundle="SIADAP_RESOURCES">
		<fr:slot name="user.username"/>
		<fr:slot name="partyName"/>
	</fr:schema>
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
		<fr:property name="link(remove)" value="<%=  "/siadapManagement.do?method=removeCCAMember&configurationId=" + configurationId %>"/>
		<fr:property name="bundle(remove)" value="MYORG_RESOURCES"/>
		<fr:property name="key(remove)" value="link.remove"/>
		<fr:property name="param(remove)" value="externalId/personId"/>
		<fr:property name="order(remove)" value="1"/>
	</fr:layout>	
</fr:view>

<fr:edit id="ccaMember" name="addCCAMember" action="<%=  "/siadapManagement.do?method=addCCAMember&configurationId=" + configurationId %>">
	<fr:schema type="module.organization.domain.Person" bundle="SIADAP_RESOURCES">
		<fr:slot name="user.username"/>
		<fr:slot name="partyName"/>
	</fr:schema>
<fr:schema type="org.fenixedu.bennu.core.util.VariantBean" bundle="SIADAP_RESOURCES">
	<fr:slot name="domainObject" layout="autoComplete" key="label.person" bundle="ORGANIZATION_RESOURCES">
		<fr:property name="labelField" value="name"/>
		<fr:property name="format" value="<%= "${name} (${user.username})" %>"/>
		<fr:property name="minChars" value="3"/>		
		<fr:property name="args" value="provider=module.organization.presentationTier.renderers.providers.PersonAutoCompleteProvider"/>
		<fr:property name="size" value="60"/>
		<fr:validator name="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
			<fr:property name="message" value="label.pleaseSelectOne.person"/>
			<fr:property name="bundle" value="EXPENDITURE_RESOURCES"/>
			<fr:property name="key" value="true"/>
		</fr:validator>
	</fr:slot>
	</fr:schema>	
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
	</fr:layout>
</fr:edit>
<br/>


<strong><bean:message key="label.schedulerExtenderMembers" bundle="SIADAP_RESOURCES"/>:</strong>
<fr:view name="configuration" property="scheduleEditors">
	<fr:schema type="module.organization.domain.Person" bundle="SIADAP_RESOURCES">
		<fr:slot name="user.username"/>
		<fr:slot name="partyName"/>
	</fr:schema>
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
		<fr:property name="link(remove)" value="<%=  "/siadapManagement.do?method=removeSchedulerExtendersMember&configurationId=" + configurationId %>"/>
		<fr:property name="bundle(remove)" value="MYORG_RESOURCES"/>
		<fr:property name="key(remove)" value="link.remove"/>
		<fr:property name="param(remove)" value="externalId/personId"/>
		<fr:property name="order(remove)" value="1"/>
	</fr:layout>	
</fr:view>
<fr:edit id="scheduleExtenderMember" name="addScheduleExtenderMember" action="<%=  "/siadapManagement.do?method=addScheduleExtenderMember&configurationId=" + configurationId %>">
	<fr:schema type="module.organization.domain.Person" bundle="SIADAP_RESOURCES">
		<fr:slot name="user.username"/>
		<fr:slot name="partyName"/>
	</fr:schema>
<fr:schema type="org.fenixedu.bennu.core.util.VariantBean" bundle="SIADAP_RESOURCES">
		<fr:slot name="domainObject" layout="autoComplete" key="label.person" bundle="ORGANIZATION_RESOURCES">
		<fr:property name="labelField" value="name"/>
		<fr:property name="format" value="<%= "${name} (${user.username})" %>"/>
		<fr:property name="minChars" value="3"/>		
		<fr:property name="args" value="provider=module.organization.presentationTier.renderers.providers.PersonAutoCompleteProvider"/>
		<fr:property name="size" value="60"/>
		<fr:validator name="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
			<fr:property name="message" value="label.pleaseSelectOne.person"/>
			<fr:property name="bundle" value="EXPENDITURE_RESOURCES"/>
			<fr:property name="key" value="true"/>
		</fr:validator>
	</fr:slot>
	</fr:schema>	
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
	</fr:layout>
</fr:edit>
<br/>


<strong><bean:message key="label.revertStateMembers" bundle="SIADAP_RESOURCES"/>:</strong>
<fr:view name="configuration" property="revertStateGroupMemberSet">
	<fr:schema type="module.organization.domain.Person" bundle="SIADAP_RESOURCES">
		<fr:slot name="user.username"/>
		<fr:slot name="partyName"/>
	</fr:schema>
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
		<fr:property name="link(remove)" value="<%=  "/siadapManagement.do?method=removeRevertStateMember&configurationId=" + configurationId %>"/>
		<fr:property name="bundle(remove)" value="MYORG_RESOURCES"/>
		<fr:property name="key(remove)" value="link.remove"/>
		<fr:property name="param(remove)" value="externalId/personId"/>
		<fr:property name="order(remove)" value="1"/>
	</fr:layout>	
</fr:view>
<fr:edit id="scheduleExtenderMember" name="addScheduleExtenderMember" action="<%=  "/siadapManagement.do?method=addRevertStateMember&configurationId=" + configurationId %>">
	<fr:schema type="module.organization.domain.Person" bundle="SIADAP_RESOURCES">
		<fr:slot name="user.username"/>
		<fr:slot name="partyName"/>
	</fr:schema>
<fr:schema type="org.fenixedu.bennu.core.util.VariantBean" bundle="SIADAP_RESOURCES">
		<fr:slot name="domainObject" layout="autoComplete" key="label.person" bundle="ORGANIZATION_RESOURCES">
		<fr:property name="labelField" value="name"/>
		<fr:property name="format" value="<%= "${name} (${user.username})" %>"/>
		<fr:property name="minChars" value="3"/>		
		<fr:property name="args" value="provider=module.organization.presentationTier.renderers.providers.PersonAutoCompleteProvider"/>
		<fr:property name="size" value="60"/>
		<fr:validator name="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
			<fr:property name="message" value="label.pleaseSelectOne.person"/>
			<fr:property name="bundle" value="EXPENDITURE_RESOURCES"/>
			<fr:property name="key" value="true"/>
		</fr:validator>
	</fr:slot>
	</fr:schema>	
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
	</fr:layout>
</fr:edit>
<br/>

<strong><bean:message key="label.homologationMembers" bundle="SIADAP_RESOURCES"/>:</strong>
<fr:view name="configuration" property="homologationMembers">
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
		<fr:property name="link(remove)" value="<%=  "/siadapManagement.do?method=removeHomologationMember&configurationId=" + configurationId %>"/>
		<fr:property name="bundle(remove)" value="MYORG_RESOURCES"/>
		<fr:property name="key(remove)" value="link.remove"/>
		<fr:property name="param(remove)" value="externalId/personId"/>
		<fr:property name="order(remove)" value="1"/>
	</fr:layout>	
</fr:view>
<fr:edit id="homologationMember" name="addHomologationMember" action="<%=  "/siadapManagement.do?method=addHomologationMember&configurationId=" + configurationId %>">
<fr:schema type="org.fenixedu.bennu.core.util.VariantBean" bundle="SIADAP_RESOURCES">
		<fr:slot name="domainObject" layout="autoComplete" key="label.person" bundle="ORGANIZATION_RESOURCES">
		<fr:property name="labelField" value="name"/>
		<fr:property name="format" value="<%= "${name} (${user.username})" %>"/>
		<fr:property name="minChars" value="3"/>		
		<fr:property name="args" value="provider=module.organization.presentationTier.renderers.providers.PersonAutoCompleteProvider"/>
		<fr:property name="size" value="60"/>
		<fr:validator name="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
			<fr:property name="message" value="label.pleaseSelectOne.person"/>
			<fr:property name="bundle" value="EXPENDITURE_RESOURCES"/>
			<fr:property name="key" value="true"/>
		</fr:validator>
	</fr:slot>
	</fr:schema>	
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
	</fr:layout>
</fr:edit>
<br/>

<strong><bean:message key="label.siadapStructureManagementMembers" bundle="SIADAP_RESOURCES"/>:</strong>
<fr:view name="configuration" property="structureManagementGroupMembers">
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
		<fr:property name="link(remove)" value="<%=  "/siadapManagement.do?method=removeStructureManagementMember&configurationId=" + configurationId %>"/>
		<fr:property name="bundle(remove)" value="MYORG_RESOURCES"/>
		<fr:property name="key(remove)" value="link.remove"/>
		<fr:property name="param(remove)" value="externalId/personId"/>
		<fr:property name="order(remove)" value="1"/>
	</fr:layout>	
</fr:view>
<fr:edit id="structureManagementMember" name="addStructureManagementGroupMember" action="<%=  "/siadapManagement.do?method=addStructureManagementMember&configurationId=" + configurationId %>">
<fr:schema type="org.fenixedu.bennu.core.util.VariantBean" bundle="SIADAP_RESOURCES">
		<fr:slot name="domainObject" layout="autoComplete" key="label.person" bundle="ORGANIZATION_RESOURCES">
		<fr:property name="labelField" value="name"/>
		<fr:property name="format" value="<%= "${name} (${user.username})" %>"/>
		<fr:property name="minChars" value="3"/>		
		<fr:property name="args" value="provider=module.organization.presentationTier.renderers.providers.PersonAutoCompleteProvider"/>
		<fr:property name="size" value="60"/>
		<fr:validator name="pt.ist.fenixWebFramework.rendererExtensions.validators.RequiredAutoCompleteSelectionValidator">
			<fr:property name="message" value="label.pleaseSelectOne.person"/>
			<fr:property name="bundle" value="EXPENDITURE_RESOURCES"/>
			<fr:property name="key" value="true"/>
		</fr:validator>
	</fr:slot>
	</fr:schema>	
	<fr:layout name="tabular">
		<fr:property name="classes" value="tstyle2"/>
	</fr:layout>
</fr:edit>
<br/>

</logic:present>
<jsp:include page="/module/siadap/tracFeedBackSnip.jsp">	
   <jsp:param name="href" value="https://fenix-ashes.ist.utl.pt/trac/siadap/report/12" />	
</jsp:include>
