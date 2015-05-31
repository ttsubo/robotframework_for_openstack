What's Robot Framework for openstack
==========
Sample Test Case for OpenStack w/ Robot Framework

Installation
==========
You need to store local.conf as bellow

	[[local|localrc]]
	ADMIN_PASSWORD=secrete
	DATABASE_PASSWORD=$ADMIN_PASSWORD
	RABBIT_PASSWORD=$ADMIN_PASSWORD
	SERVICE_PASSWORD=$ADMIN_PASSWORD
	SERVICE_TOKEN=a682f596-76f3-11e3-b3b2-e716f9080d50

	disable_service n-net
	enable_service q-svc
	enable_service q-agt
	enable_service q-dhcp
	enable_service q-l3	

Quick Start
===========
You can start sample TestCases as bellow

	$ pybot --variable OPENSTACK:127.0.0.1 tests
