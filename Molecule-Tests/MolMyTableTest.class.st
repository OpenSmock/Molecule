"
I provide basic tests for services.
Also, I can be used as example to use services. My classes are in package Molecule-Examples.
"
Class {
	#name : #MolMyTableTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests'
}

{ #category : #'setUp-tearDown' }
MolMyTableTest >> setUp [

	MolComponentManager default.
]

{ #category : #'setUp-tearDown' }
MolMyTableTest >> tearDown [

	MolComponentManager cleanUp.
]

{ #category : #tests }
MolMyTableTest >> testTableProvideServices [

	| manager table user |
	MolComponentManager cleanUp.
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyUserComponentImpl.
	
	"Instanciation"
	table := manager homeServices instanciateComponent: MolMyTableComponentImpl.
	user := manager homeServices instanciateComponent: MolMyUserComponentImpl.
	
	"Activation"
	manager homeServices activateComponent: MolMyTableComponentImpl.
	manager homeServices activateComponent: MolMyUserComponentImpl.
	
	"Tests"
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.

	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	manager cleanUp.
]

{ #category : #tests }
MolMyTableTest >> testTableProvideServicesNamed [

	| manager table user |
	MolComponentManager cleanUp.
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyUserComponentImpl.
	
	"Instanciation"
	table := manager homeServices instanciateComponent: MolMyTableComponentImpl named: #myTable.
	user := manager homeServices instanciateComponent: MolMyUserComponentImpl named: #myUser.
	
	"Subscription : it should be done in SCMMyUserComponentImpl > componentInitialize"
	user forServices: MolMyTableServices useProvider: #myTable.
	
	"Activation"
	manager homeServices activateComponent: MolMyTableComponentImpl named: #myTable.
	manager homeServices activateComponent: MolMyUserComponentImpl named: #myUser.
	
	"Tests"
	self assert: user getMolMyTableServicesProvider equals: table.

	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	manager cleanUp.
]

{ #category : #tests }
MolMyTableTest >> testTableProvideServicesNotActivated [

	| manager table user |
	MolComponentManager cleanUp.
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyUserComponentImpl.
	
	"Instanciation"
	table := manager homeServices instanciateComponent: MolMyTableComponentImpl.
	user := manager homeServices instanciateComponent: MolMyUserComponentImpl.
	
	"Tests : service is provided when component is not activated"
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.
	
	manager homeServices activateComponent: MolMyTableComponentImpl.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.
	
	manager homeServices passivateComponent: MolMyTableComponentImpl.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.

	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	manager cleanUp.
]

{ #category : #tests }
MolMyTableTest >> testTableProvideServicesNotActivatedNamed [

	| manager table user |
	MolComponentManager cleanUp.
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyUserComponentImpl.
	
	"Instanciation"
	table := manager homeServices instanciateComponent: MolMyTableComponentImpl named: #myTable.
	user := manager homeServices instanciateComponent: MolMyUserComponentImpl named: #myUser.
	
	"Subscription : it should be done in SCMMyUserComponentImpl > componentInitialize"
	user forServices: MolMyTableServices useProvider: #myTable.
	
	"Tests"
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.
	
	manager homeServices activateComponent: MolMyTableComponentImpl named: #myTable.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.
	
	manager homeServices passivateComponent: MolMyTableComponentImpl named: #myTable.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.

	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	manager cleanUp.
]

{ #category : #tests }
MolMyTableTest >> testTableProvideServicesToSeveralUsers [

	| manager table user1 user2 |
	MolComponentManager cleanUp.
	
	manager := MolComponentManager default.
	
	"Deployment"
	manager deploymentServices deployComponentImplementation: MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation: MolMyUserComponentImpl.
	
	"Instanciation"
	table := manager homeServices instanciateComponent: MolMyTableComponentImpl.
	user1 := manager homeServices instanciateComponent: MolMyUserComponentImpl named: #user1.
	user2 := manager homeServices instanciateComponent: MolMyUserComponentImpl named: #user2.
	
	"Subscriptions"
	user1 forServices: MolMyTableServices useProvider: #default.
	user2 forServices: MolMyTableServices useProvider: #default.
	
	"Activation"
	manager homeServices activateComponent: MolMyTableComponentImpl.
	manager homeServices activateComponent: MolMyUserComponentImpl named: #user1.
	
	"Tests"
	self assert: user1 getMolMyTableServicesProvider equals: table.
	user1 getMolMyTableServicesProvider getContent.
	
	manager homeServices activateComponent: MolMyUserComponentImpl named: #user2.
	self assert: user2 getMolMyTableServicesProvider equals: table.
	self assert: user1 getMolMyTableServicesProvider equals: table.
	user2 getMolMyTableServicesProvider getContent.

	"End of test"
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolMyWarnerComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolMyListenerComponentImpl.
	manager cleanUp.
]
