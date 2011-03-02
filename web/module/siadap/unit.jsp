<%@page import="module.organization.domain.Accountability"%>
<%@page import="module.siadap.domain.wrappers.PersonSiadapWrapper"%>
<%@page import="module.organization.domain.Unit"%>
<%@page import="module.siadap.domain.Siadap"%>
<%@page import="module.organization.domain.Person"%>
<%@page import="module.siadap.domain.SiadapYearConfiguration"%>
<%@page import="module.siadap.domain.SiadapProcessStateEnum"%>
<%@page import="module.siadap.domain.util.SiadapProcessCounter"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>
<%@ taglib uri="/WEB-INF/chart.tld" prefix="chart" %>

<bean:define id="unit" type="module.organization.domain.Unit" name="chart" property="element"/>

<h2>
	<fr:view name="unit" property="presentationName"/>
</h2>

<%
	final SiadapYearConfiguration configuration = (SiadapYearConfiguration) request.getAttribute("configuration");
%>

<div class="infobox">
	<table align="center" style="width: 100%; text-align: center;">
		<tr>
			<td align="center">
				<chart:orgChart id="party" name="chart" type="module.organization.domain.Party">
					
						<%
							if (party == unit) {
						%>
							<div class="orgTBox orgTBoxLight">
								<strong>
									<bean:write name="party" property="partyName"/>
								</strong>
							</div>
						<%			    
							} else if (party.isUnit()) {
							    final SiadapProcessCounter counter = new SiadapProcessCounter((Unit) party);
							    final String styleSuffix = counter.hasAnyPendingProcesses() ? "border-color: red;" : "";
						%>
							<bean:define id="toolTipTitle" type="java.lang.String"><bean:message key="label.process.state.counts" bundle="SIADAP_RESOURCES"/></bean:define>
							<bean:define id="toolTip" type="java.lang.String">
								<ul>
								<%
									for (int i = 0 ; i < counter.getCounts().length; i++) {
										final int count = counter.getCounts()[i];
										final SiadapProcessStateEnum state = SiadapProcessStateEnum.values()[i];
								%>
										<li>
											<%= state.getLocalizedName() %>: <%= count %>
										</li>
								<%
									}
								%>
								</ul>
							</bean:define>
							<div class="orgTBox orgTBoxLight" style="<%= styleSuffix %> " title="header=[ <%= toolTipTitle %> ] body=[<%= toolTip %>]">
								<html:link page="/siadapProcessCount.do?method=showUnit" paramId="unitId" paramName="party" paramProperty="externalId" styleClass="secondaryLink">
									<bean:write name="party" property="partyName"/>
								</html:link>
							</div>
						<%			    
							}
						%>
				</chart:orgChart>
			</td>
		</tr>
	</table>
</div>

<table class="tstyle3" align="center" style="width: 100%; text-align: center;">
	<tr>
<%
	final SiadapProcessCounter counter = new SiadapProcessCounter(unit);
	for (int i = 0 ; i < counter.getCounts().length; i++) {
	    final SiadapProcessStateEnum state = SiadapProcessStateEnum.values()[i];
%>
		<th>
			<strong>
				<%= state.getLocalizedName() %>
			</strong>
		</th>
<%
	}
%>
	</tr>
	<tr>
<%
	for (int i = 0 ; i < counter.getCounts().length; i++) {
	    final int count = counter.getCounts()[i];
	    final SiadapProcessStateEnum state = SiadapProcessStateEnum.values()[i];
%>
		<td>
			<%
				if (count == 0 || state == SiadapProcessStateEnum.WAITING_SELF_EVALUATION) {
			%>
				<%= count %>
			<%
				} else {
			%>
				<font color="red">
					<%= count %>
				</font>
			<%
				}
			%>
		</td>
<%
	}
%>
	</tr>
</table>

<table align="center" style="width: 100%; text-align: center;">
	<tr>
		<td style="width: 50%; text-align: center; vertical-align: top; padding: 15px;">
			<div class="infobox" style="height: 175px;">
				<h4>
					<bean:message key="label.unit.harmonizer" bundle="SIADAP_RESOURCES"/>
				</h4>
				<logic:present name="unitHarmanizer">
					<bean:define id="urlUnitHarmanizer" type="java.lang.String">https://fenix.ist.utl.pt/publico/retrievePersonalPhoto.do?method=retrieveByUUID&amp;contentContextPath_PATH=/homepage&amp;uuid=<bean:write name="unitHarmanizer" property="user.username"/></bean:define>
					<img src="<%= urlUnitHarmanizer %>">
				</logic:present>
				<p>
					<logic:present name="unitHarmanizer">
						<html:link page="<%= "/siadapPersonnelManagement.do?method=viewPerson&year=" + configuration.getYear() %>"
								paramId="personId" paramName="unitHarmanizer" paramProperty="externalId"
								styleClass="secondaryLink">
							<bean:write name="unitHarmanizer" property="presentationName"/>
						</html:link>
					</logic:present>
					<logic:notPresent name="unitHarmanizer">
						<bean:message key="label.not.defined" bundle="SIADAP_RESOURCES"/>
					</logic:notPresent>
				</p>
			</div>
		</td>
		<td style="width: 50%; text-align: center; vertical-align: top; padding: 15px;">
			<div class="infobox" style="height: 175px;">
				<h4>
					<bean:message key="label.unit.responsible" bundle="SIADAP_RESOURCES"/>
				</h4>
				<logic:present name="unitResponsible">
					<bean:define id="urlUnitResponsible" type="java.lang.String">https://fenix.ist.utl.pt/publico/retrievePersonalPhoto.do?method=retrieveByUUID&amp;contentContextPath_PATH=/homepage&amp;uuid=<bean:write name="unitResponsible" property="user.username"/></bean:define>
					<img src="<%= urlUnitResponsible %>">
				</logic:present>
				<p>
					<logic:present name="unitResponsible">
						<html:link page="<%= "/siadapPersonnelManagement.do?method=viewPerson&year=" + configuration.getYear() %>"
								paramId="personId" paramName="unitResponsible" paramProperty="externalId"
								styleClass="secondaryLink">
							<bean:write name="unitResponsible" property="presentationName"/>
						</html:link>
					</logic:present>
					<logic:notPresent name="unitResponsible">
						<bean:message key="label.not.defined" bundle="SIADAP_RESOURCES"/>
					</logic:notPresent>
				</p>
			</div>
		</td>
	</tr>
</table>


<logic:notEmpty name="workerAccountabilities">
	<br/>
	<br/>
	<h3><bean:message key="label.people.to.be.evaluated" bundle="SIADAP_RESOURCES"/></h3>
	<table class="tstyle3" align="center" style="width: 100%; text-align: center;">
		<tr>
			<th>
			</th>
			<th>
				<bean:message key="label.person" bundle="ORGANIZATION_RESOURCES"/>
			</th>
			<th>
				<bean:message key="label.evaluator" bundle="SIADAP_RESOURCES"/>
			</th>
			<th>
				<bean:message key="label.quotaAware" bundle="SIADAP_RESOURCES"/>
			</th>
			<th>
				<bean:message key="label.state" bundle="SIADAP_RESOURCES"/>
			</th>
			<th>
			</th>
		</tr>
		<logic:iterate id="accountability" name="workerAccountabilities" type="module.organization.domain.Accountability">
			<bean:define id="person" type="module.organization.domain.Person" name="accountability" property="child"/>
			<%
				final PersonSiadapWrapper personSiadapWrapper = new PersonSiadapWrapper(person, configuration.getYear());
			%>
			<tr>
				<td>
					<bean:define id="url" type="java.lang.String">https://fenix.ist.utl.pt/publico/retrievePersonalPhoto.do?method=retrieveByUUID&amp;contentContextPath_PATH=/homepage&amp;uuid=<bean:write name="person" property="user.username"/></bean:define>
					<img src="<%= url %>">
				</td>
				<td>
					<html:link page="<%= "/siadapPersonnelManagement.do?method=viewPerson&year=" + configuration.getYear() %>"
							paramId="personId" paramName="person" paramProperty="externalId"
							styleClass="secondaryLink">
						<bean:write name="person" property="presentationName"/>
					</html:link>
				</td>
				<td>
					<html:link page="<%= "/siadapPersonnelManagement.do?method=viewPerson&year=" + configuration.getYear() 
							+ "&personId=" + personSiadapWrapper.getEvaluator().getPerson().getExternalId() %>"
							styleClass="secondaryLink">
							<%= personSiadapWrapper.getEvaluator().getPerson().getName() %>
					</html:link>
					
				</td>
				<td>
					<%
						if (personSiadapWrapper.isQuotaAware()) {
					%>
						<bean:message bundle="SIADAP_RESOURCES" key="siadap.true.yes"/>
					<% } else { %>
						<bean:message bundle="SIADAP_RESOURCES" key="siadap.false.no"/>
					<% } %>
				</td>
				<td>
					<%
						final SiadapProcessStateEnum state = personSiadapWrapper.getCurrentProcessState();
					%>
					<%
						if (state == SiadapProcessStateEnum.WAITING_SELF_EVALUATION) {
					%>
						<%= state.getLocalizedName() %>
					<%
						} else {
					%>
						<font color="red">
							<%= state.getLocalizedName() %>
						</font>
					<%
						}
					%>
				</td>
				<td>
					<%
						if (personSiadapWrapper.getSiadap() == null) {
					%>
						<html:link page="<%= "/siadapManagement.do?method=createNewSiadapProcess&year="
							+ configuration.getYear()
							+ "&personId="
							+ personSiadapWrapper.getPerson().getExternalId() %>">
							<bean:message key="link.create" bundle="MYORG_RESOURCES"/>
						</html:link>
					<%
						} else {
					%>
						<html:link page="<%= "/workflowProcessManagement.do?method=viewProcess&year="
							+ configuration.getYear()
							+ "&processId="
							+ personSiadapWrapper.getSiadap().getProcess().getExternalId() %>">
							<bean:message key="link.view" bundle="MYORG_RESOURCES"/>
						</html:link>
					<%
						}
					%>
				</td>
			</tr>
		</logic:iterate>
	</table>
</logic:notEmpty>

<br/>
<jsp:include page="processStateLegend.jsp"/>

<script type="text/javascript">
if (typeof document.attachEvent!='undefined') {
	   window.attachEvent('onload',init);
	   document.attachEvent('onmousemove',moveMouse);
	   document.attachEvent('onclick',checkMove); }
	else {
	   window.addEventListener('load',init,false);
	   document.addEventListener('mousemove',moveMouse,false);
	   document.addEventListener('click',checkMove,false);
	}

	var oDv=document.createElement("div");
	var dvHdr=document.createElement("div");
	var dvBdy=document.createElement("div");
	var windowlock,boxMove,fixposx,fixposy,lockX,lockY,fixx,fixy,ox,oy,boxLeft,boxRight,boxTop,boxBottom,evt,mouseX,mouseY,boxOpen,totalScrollTop,totalScrollLeft;
	boxOpen=false;
	ox=10;
	oy=10;
	lockX=0;
	lockY=0;

	function init() {
		oDv.appendChild(dvHdr);
		oDv.appendChild(dvBdy);
		oDv.style.position="absolute";
		oDv.style.visibility='hidden';
		document.body.appendChild(oDv);	
	}

	function defHdrStyle() {
		dvHdr.innerHTML='<img  style="vertical-align:middle"  src="info.gif">&nbsp;&nbsp;'+dvHdr.innerHTML;
		dvHdr.style.fontWeight='bold';
		dvHdr.style.width='150px';
		dvHdr.style.fontFamily='arial';
		dvHdr.style.border='1px solid #A5CFE9';
		dvHdr.style.padding='3';
		dvHdr.style.fontSize='11';
		dvHdr.style.color='#4B7A98';
		dvHdr.style.background='#D5EBF9';
		dvHdr.style.filter='alpha(opacity=85)'; // IE
		dvHdr.style.opacity='0.85'; // FF
	}

	function defBdyStyle() {
		dvBdy.style.borderBottom='1px solid #A5CFE9';
		dvBdy.style.borderLeft='1px solid #A5CFE9';
		dvBdy.style.borderRight='1px solid #A5CFE9';
		dvBdy.style.width='150px';
		dvBdy.style.fontFamily='arial';
		dvBdy.style.fontSize='11';
		dvBdy.style.padding='3';
		dvBdy.style.color='#1B4966';
		dvBdy.style.background='#FFFFFF';
		dvBdy.style.filter='alpha(opacity=85)'; // IE
		dvBdy.style.opacity='0.85'; // FF
	}

	function checkElemBO(txt) {
	if (!txt || typeof(txt) != 'string') return false;
	if ((txt.indexOf('header')>-1)&&(txt.indexOf('body')>-1)&&(txt.indexOf('[')>-1)&&(txt.indexOf('[')>-1)) 
	   return true;
	else
	   return false;
	}

	function scanBO(curNode) {
		  if (checkElemBO(curNode.title)) {
	         curNode.boHDR=getParam('header',curNode.title);
	         curNode.boBDY=getParam('body',curNode.title);
				curNode.boCSSBDY=getParam('cssbody',curNode.title);			
				curNode.boCSSHDR=getParam('cssheader',curNode.title);
				curNode.IEbugfix=(getParam('hideselects',curNode.title)=='on')?true:false;
				curNode.fixX=parseInt(getParam('fixedrelx',curNode.title));
				curNode.fixY=parseInt(getParam('fixedrely',curNode.title));
				curNode.absX=parseInt(getParam('fixedabsx',curNode.title));
				curNode.absY=parseInt(getParam('fixedabsy',curNode.title));
				curNode.offY=(getParam('offsety',curNode.title)!='')?parseInt(getParam('offsety',curNode.title)):10;
				curNode.offX=(getParam('offsetx',curNode.title)!='')?parseInt(getParam('offsetx',curNode.title)):10;
				curNode.fade=(getParam('fade',curNode.title)=='on')?true:false;
				curNode.fadespeed=(getParam('fadespeed',curNode.title)!='')?getParam('fadespeed',curNode.title):0.04;
				curNode.delay=(getParam('delay',curNode.title)!='')?parseInt(getParam('delay',curNode.title)):0;
				if (getParam('requireclick',curNode.title)=='on') {
					curNode.requireclick=true;
					document.all?curNode.attachEvent('onclick',showHideBox):curNode.addEventListener('click',showHideBox,false);
					document.all?curNode.attachEvent('onmouseover',hideBox):curNode.addEventListener('mouseover',hideBox,false);
				}
				else {// Note : if requireclick is on the stop clicks are ignored   			
	   			if (getParam('doubleclickstop',curNode.title)!='off') {
	   				document.all?curNode.attachEvent('ondblclick',pauseBox):curNode.addEventListener('dblclick',pauseBox,false);
	   			}	
	   			if (getParam('singleclickstop',curNode.title)=='on') {
	   				document.all?curNode.attachEvent('onclick',pauseBox):curNode.addEventListener('click',pauseBox,false);
	   			}
	   		}
				curNode.windowLock=getParam('windowlock',curNode.title).toLowerCase()=='off'?false:true;
				curNode.title='';
				curNode.hasbox=1;
		   }
		   else
		      curNode.hasbox=2;   
	}


	function getParam(param,list) {
		var reg = new RegExp('([^a-zA-Z]' + param + '|^' + param + ')\\s*=\\s*\\[\\s*(((\\[\\[)|(\\]\\])|([^\\]\\[]))*)\\s*\\]');
		var res = reg.exec(list);
		var returnvar;
		if(res)
			return res[2].replace('[[','[').replace(']]',']');
		else
			return '';
	}

	function Left(elem){	
		var x=0;
		if (elem.calcLeft)
			return elem.calcLeft;
		var oElem=elem;
		while(elem){
			 if ((elem.currentStyle)&& (!isNaN(parseInt(elem.currentStyle.borderLeftWidth)))&&(x!=0))
			 	x+=parseInt(elem.currentStyle.borderLeftWidth);
			 x+=elem.offsetLeft;
			 elem=elem.offsetParent;
		  } 
		oElem.calcLeft=x;
		return x;
		}

	function Top(elem){
		 var x=0;
		 if (elem.calcTop)
		 	return elem.calcTop;
		 var oElem=elem;
		 while(elem){		
		 	 if ((elem.currentStyle)&& (!isNaN(parseInt(elem.currentStyle.borderTopWidth)))&&(x!=0))
			 	x+=parseInt(elem.currentStyle.borderTopWidth); 
			 x+=elem.offsetTop;
		         elem=elem.offsetParent;
	 	 } 
	 	 oElem.calcTop=x;
	 	 return x;
	 	 
	}

	var ah,ab;
	function applyStyles() {
		if(ab)
			oDv.removeChild(dvBdy);
		if (ah)
			oDv.removeChild(dvHdr);
		dvHdr=document.createElement("div");
		dvBdy=document.createElement("div");
		CBE.boCSSBDY?dvBdy.className=CBE.boCSSBDY:defBdyStyle();
		CBE.boCSSHDR?dvHdr.className=CBE.boCSSHDR:defHdrStyle();
		dvHdr.innerHTML=CBE.boHDR;
		dvBdy.innerHTML=CBE.boBDY;
		ah=false;
		ab=false;
		if (CBE.boHDR!='') {		
			oDv.appendChild(dvHdr);
			ah=true;
		}	
		if (CBE.boBDY!=''){
			oDv.appendChild(dvBdy);
			ab=true;
		}	
	}

	var CSE,iterElem,LSE,CBE,LBE, totalScrollLeft, totalScrollTop, width, height ;
	var ini=false;

	// Customised function for inner window dimension
	function SHW() {
	   if (document.body && (document.body.clientWidth !=0)) {
	      width=document.body.clientWidth;
	      height=document.body.clientHeight;
	   }
	   if (document.documentElement && (document.documentElement.clientWidth!=0) && (document.body.clientWidth + 20 >= document.documentElement.clientWidth)) {
	      width=document.documentElement.clientWidth;   
	      height=document.documentElement.clientHeight;   
	   }   
	   return [width,height];
	}


	var ID=null;
	function moveMouse(e) {
	   //boxMove=true;
		e?evt=e:evt=event;
		
		CSE=evt.target?evt.target:evt.srcElement;
		
		if (!CSE.hasbox) {
		   // Note we need to scan up DOM here, some elements like TR don't get triggered as srcElement
		   iElem=CSE;
		   while ((iElem.parentNode) && (!iElem.hasbox)) {
		      scanBO(iElem);
		      iElem=iElem.parentNode;
		   }	   
		}
		
		if ((CSE!=LSE)&&(!isChild(CSE,dvHdr))&&(!isChild(CSE,dvBdy))){		
		   if (!CSE.boxItem) {
				iterElem=CSE;
				while ((iterElem.hasbox==2)&&(iterElem.parentNode))
						iterElem=iterElem.parentNode; 
				CSE.boxItem=iterElem;
				}
			iterElem=CSE.boxItem;
			if (CSE.boxItem&&(CSE.boxItem.hasbox==1))  {
				LBE=CBE;
				CBE=iterElem;
				if (CBE!=LBE) {
					applyStyles();
					if (!CBE.requireclick)
						if (CBE.fade) {
							if (ID!=null)
								clearTimeout(ID);
							ID=setTimeout("fadeIn("+CBE.fadespeed+")",CBE.delay);
						}
						else {
							if (ID!=null)
								clearTimeout(ID);
							COL=1;
							ID=setTimeout("oDv.style.visibility='visible';ID=null;",CBE.delay);						
						}
					if (CBE.IEbugfix) {hideSelects();} 
					fixposx=!isNaN(CBE.fixX)?Left(CBE)+CBE.fixX:CBE.absX;
					fixposy=!isNaN(CBE.fixY)?Top(CBE)+CBE.fixY:CBE.absY;			
					lockX=0;
					lockY=0;
					boxMove=true;
					ox=CBE.offX?CBE.offX:10;
					oy=CBE.offY?CBE.offY:10;
				}
			}
			else if (!isChild(CSE,dvHdr) && !isChild(CSE,dvBdy) && (boxMove))	{
				// The conditional here fixes flickering between tables cells.
				if ((!isChild(CBE,CSE)) || (CSE.tagName!='TABLE')) {   			
	   			CBE=null;
	   			if (ID!=null)
	  					clearTimeout(ID);
	   			fadeOut();
	   			showSelects();
				}
			}
			LSE=CSE;
		}
		else if (((isChild(CSE,dvHdr) || isChild(CSE,dvBdy))&&(boxMove))) {
			totalScrollLeft=0;
			totalScrollTop=0;
			
			iterElem=CSE;
			while(iterElem) {
				if(!isNaN(parseInt(iterElem.scrollTop)))
					totalScrollTop+=parseInt(iterElem.scrollTop);
				if(!isNaN(parseInt(iterElem.scrollLeft)))
					totalScrollLeft+=parseInt(iterElem.scrollLeft);
				iterElem=iterElem.parentNode;			
			}
			if (CBE!=null) {
				boxLeft=Left(CBE)-totalScrollLeft;
				boxRight=parseInt(Left(CBE)+CBE.offsetWidth)-totalScrollLeft;
				boxTop=Top(CBE)-totalScrollTop;
				boxBottom=parseInt(Top(CBE)+CBE.offsetHeight)-totalScrollTop;
				doCheck();
			}
		}
		
		if (boxMove&&CBE) {
			// This added to alleviate bug in IE6 w.r.t DOCTYPE
			bodyScrollTop=document.documentElement&&document.documentElement.scrollTop?document.documentElement.scrollTop:document.body.scrollTop;
			bodyScrollLet=document.documentElement&&document.documentElement.scrollLeft?document.documentElement.scrollLeft:document.body.scrollLeft;
			mouseX=evt.pageX?evt.pageX-bodyScrollLet:evt.clientX-document.body.clientLeft;
			mouseY=evt.pageY?evt.pageY-bodyScrollTop:evt.clientY-document.body.clientTop;
			if ((CBE)&&(CBE.windowLock)) {
				mouseY < -oy?lockY=-mouseY-oy:lockY=0;
				mouseX < -ox?lockX=-mouseX-ox:lockX=0;
				mouseY > (SHW()[1]-oDv.offsetHeight-oy)?lockY=-mouseY+SHW()[1]-oDv.offsetHeight-oy:lockY=lockY;
				mouseX > (SHW()[0]-dvBdy.offsetWidth-ox)?lockX=-mouseX-ox+SHW()[0]-dvBdy.offsetWidth:lockX=lockX;			
			}
			oDv.style.left=((fixposx)||(fixposx==0))?fixposx:bodyScrollLet+mouseX+ox+lockX+"px";
			oDv.style.top=((fixposy)||(fixposy==0))?fixposy:bodyScrollTop+mouseY+oy+lockY+"px";		
			
		}
	}

	function doCheck() {	
		if (   (mouseX < boxLeft)    ||     (mouseX >boxRight)     || (mouseY < boxTop) || (mouseY > boxBottom)) {
			if (!CBE.requireclick)
				fadeOut();
			if (CBE.IEbugfix) {showSelects();}
			CBE=null;
		}
	}

	function pauseBox(e) {
	   e?evt=e:evt=event;
		boxMove=false;
		evt.cancelBubble=true;
	}

	function showHideBox(e) {
		oDv.style.visibility=(oDv.style.visibility!='visible')?'visible':'hidden';
	}

	function hideBox(e) {
		oDv.style.visibility='hidden';
	}

	var COL=0;
	var stopfade=false;
	function fadeIn(fs) {
			ID=null;
			COL=0;
			oDv.style.visibility='visible';
			fadeIn2(fs);
	}

	function fadeIn2(fs) {
			COL=COL+fs;
			COL=(COL>1)?1:COL;
			oDv.style.filter='alpha(opacity='+parseInt(100*COL)+')';
			oDv.style.opacity=COL;
			if (COL<1)
			 setTimeout("fadeIn2("+fs+")",20);		
	}


	function fadeOut() {
		oDv.style.visibility='hidden';
		
	}

	function isChild(s,d) {
		while(s) {
			if (s==d) 
				return true;
			s=s.parentNode;
		}
		return false;
	}

	var cSrc;
	function checkMove(e) {
		e?evt=e:evt=event;
		cSrc=evt.target?evt.target:evt.srcElement;
		if ((!boxMove)&&(!isChild(cSrc,oDv))) {
			fadeOut();
			if (CBE&&CBE.IEbugfix) {showSelects();}
			boxMove=true;
			CBE=null;
		}
	}

	function showSelects(){
	   var elements = document.getElementsByTagName("select");
	   for (i=0;i< elements.length;i++){
	      elements[i].style.visibility='visible';
	   }
	}

	function hideSelects(){
	   var elements = document.getElementsByTagName("select");
	   for (i=0;i< elements.length;i++){
	   elements[i].style.visibility='hidden';
	   }
	}
</script>