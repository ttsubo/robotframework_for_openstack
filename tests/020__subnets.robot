*** Settings ***
Documentation     Checking Subnets  created in OpenStack
Suite Setup	  Create Session    OSSession     http://${OPENSTACK}:9696    headers=${X-AUTH}    
Suite Teardown    Delete All Sessions
Library           SSHLibrary
Library           Collections
Library           libraries/RequestsLibrary.py
Library           libraries/Common.py
Variables         variables/Variables.py
 
*** Variables ***
${OSREST}        /v2.0/subnets
${data}       {"subnet":{"network_id":"${NETID}","ip_version":4,"cidr":"172.16.64.0/24","allocation_pools":[{"start":"172.16.64.20","end":"172.16.64.120"}]}}
 
*** Test Cases ***
Check OpenStack Subnets
	[Documentation]     Checking OpenStack Neutron for known Subnets
	[Tags]              Subnets Neutron OpenStack
        Log	${X-AUTH}
        ${resp}		get	OSSession	${OSREST}    
	Should be Equal As Strings	${resp.status_code}	200
        ${OSResult}	To Json		${resp.content}
        Set Suite Variable	${OSResult}
        Log	${OSResult}

Create New subnet
	[Documentation]	   Create new subnet in OpenStack
	[Tags]		   Create Subnet OpenStack Neutron
        Log   	${data}
        ${resp}		post	OSSession	${OSREST}       data=${data}  
        Should be Equal As Strings	${resp.status_code}	201
	${result}	To JSON		${resp.content}
	${result}	Get From Dictionary	${result}	subnet	
        ${SUBNETID}	Get From Dictionary	${result}	id
        Log	${result}
	Log	${SUBNETID}
        Set Global Variable	${SUBNETID}
        sleep    2

Check New subnet
	[Documentation]	  Check new subnet created in OpenStack
	[Tags]		Check  subnet OpenStack Neutron
	${resp}		get	OSSession	${OSREST}/${SUBNETID}
        Should be Equal As Strings	${resp.status_code}	200


