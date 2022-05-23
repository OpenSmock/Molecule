"
I provide basic tests for parameters.
Also, I can be used as example to use parameters. My classes are in package Molecule-Examples.
"
Class {
	#name : #MolParametersTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #'setUp-tearDown' }
MolParametersTest >> setUp [

	MolComponentManager cleanUp.
]

{ #category : #'setUp-tearDown' }
MolParametersTest >> tearDown [

	MolComponentManager cleanUp.
]

{ #category : #tests }
MolParametersTest >> testClientSetParameters [
	| manager socket client |
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMySocketComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyClientComponentImpl.
	
	"Instanciation"
	socket := manager homeServices instanciateComponent: MolMySocketComponentImpl.
	client := manager homeServices instanciateComponent: MolMyClientComponentImpl.
	
	"Activation"
	manager homeServices activateComponent: MolMySocketComponentImpl.
	manager homeServices activateComponent: MolMyClientComponentImpl.
	
	"Tests"
	self assert: client getMolMySocketParametersProvider equals: socket.
	client setIp: '127.0.0.1'.
	client setPort: 1234.
	client setProtocol: #tcp.
	client connect.
	client send: 'ping'.
	
]

{ #category : #tests }
MolParametersTest >> testClientSetParametersFromSeveralClient [
	| manager socket client1 client2 |

	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMySocketComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyClientComponentImpl.
	
	"Instanciation"
	socket := manager homeServices instanciateComponent: MolMySocketComponentImpl named: #socket.
	client1 := manager homeServices instanciateComponent: MolMyClientComponentImpl named: #client1.
	client2 := manager homeServices instanciateComponent: MolMyClientComponentImpl named: #client2.
	
	"Subscription : it should be done in SCMMyClientComponentImpl > componentInitialize"
	client1 forParameters: MolMySocketParameters useProvider: #socket.
	client2 forParameters: MolMySocketParameters useProvider: #socket.
	client1 forServices: MolMySocketServices useProvider: #socket.
	client2 forServices: MolMySocketServices useProvider: #socket.
	
	"Activation"
	manager homeServices activateComponent: MolMySocketComponentImpl named: #socket.
	manager homeServices activateComponent: MolMyClientComponentImpl named: #client1.
	manager homeServices activateComponent: MolMyClientComponentImpl named: #client2.
	
	"Tests"
	self assert: client1 getMolMySocketParametersProvider equals: socket.
	self assert: client2 getMolMySocketParametersProvider equals: socket.
	client1 setIp: '127.0.0.1'.
	client2 setPort: 1234.
	client1 setProtocol: #udp.
	client1 connect.
	client1 disconnect.
	client2 setIp: '10.0.0.2'.
	client2 connect.	
]

{ #category : #tests }
MolParametersTest >> testClientSetParametersNamed [
	| manager socket client |
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMySocketComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyClientComponentImpl.
	
	"Instanciation"
	socket := manager homeServices instanciateComponent: MolMySocketComponentImpl named: #socket.
	client := manager homeServices instanciateComponent: MolMyClientComponentImpl named: #client.
	
	"Subscription : it should be done in SCMMyClientComponentImpl > componentInitialize"
	client forParameters: MolMySocketParameters useProvider: #socket.
	client forServices: MolMySocketServices useProvider: #socket.
	
	"Activation"
	manager homeServices activateComponent: MolMySocketComponentImpl named: #socket.
	manager homeServices activateComponent: MolMyClientComponentImpl named: #client.
	
	"Tests"
	self assert: client getMolMySocketParametersProvider equals: socket.
	client setIp: '127.0.0.1'.
	client setPort: 1234.
	client setProtocol: #tcp.
	client connect.
	client send: 'ping'.	
]
