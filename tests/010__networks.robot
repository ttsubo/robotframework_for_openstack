*** Settings ***
Documentation     Checking Network created in OpenStack
Suite Setup	  Create Session    OSSession     http://${OPENSTACK}:9696    headers=${X-AUTH}    
Suite Teardown    Delete All Sessions
Library           SSHLibrary
Library           Collections
Library           libraries/RequestsLibrary.py
Library           libraries/Common.py
Variables         variables/Variables.py
 
*** Variables ***
${OSREST}        /v2.0/networks
${postNet}	{"network":{"name":"test_network","admin_state_up":true}}
 
*** Test Cases ***
Check OpenStack Networks
	[Documentation]     Checking OpenStack Neutron for known networks
	[Tags]              Network Neutron OpenStack
        Log	${X-AUTH}
        ${resp}		get	OSSession	${OSREST}   
	Should be Equal As Strings	${resp.status_code}	200
        ${OSResult}	To Json		${resp.content}
        Set Suite Variable	${OSResult}
        Log	${OSResult}

Create Network 
	[Documentation]	   Create new network in OpenStack
	[Tags]		   Create Network OpenStack Neutron
        Log   	${postNet}
        ${resp}		post	OSSession	${OSREST}  data=${postNet}  
        Should be Equal As Strings	${resp.status_code}	201
	${result}	To JSON		${resp.content}
	${result}	Get From Dictionary	${result}	network	
        ${NETID}	Get From Dictionary	${result}	id
        Log	${result}
	Log	${NETID}
        Set Global Variable	${NETID}
        sleep    2

Check Network
	[Documentation]	  Check Network created in OpenStack
	[Tags]		Check  Network  OpenStack Neutron
	${resp}		get	OSSession	${OSREST}/${NetID}
        Should be Equal As Strings	${resp.status_code}	200


