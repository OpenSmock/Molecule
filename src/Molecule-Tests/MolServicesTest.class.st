"
I provide basic tests for services.
Also, I can be used as example to use services. My classes are in package Molecule-Examples.
"
Class {
	#name : #MolServicesTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #'setUp-tearDown' }
MolServicesTest >> setUp [

	MolComponentManager cleanUp.
]

{ #category : #'setUp-tearDown' }
MolServicesTest >> tearDown [

	MolComponentManager cleanUp.
]

{ #category : #tests }
MolServicesTest >> testTableProvideServices [

	| manager table user |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolMyUserComponentImpl.

	"Instanciation"
	table := manager homeServices instantiateComponent:
		         MolMyTableComponentImpl.
	user := manager homeServices instantiateComponent:
		        MolMyUserComponentImpl.

	"Activation"
	manager homeServices activateComponent: MolMyTableComponentImpl.
	manager homeServices activateComponent: MolMyUserComponentImpl.

	"Tests"
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent
]

{ #category : #tests }
MolServicesTest >> testTableProvideServicesNamed [

	| manager table user |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolMyUserComponentImpl.

	"Instanciation"
	table := manager homeServices
		         instantiateComponent: MolMyTableComponentImpl
		         named: #myTable.
	user := manager homeServices
		        instantiateComponent: MolMyUserComponentImpl
		        named: #myUser.

	"Subscription : it should be done in SCMMyUserComponentImpl > componentInitialize"
	user forServices: MolMyTableServices useProvider: #myTable.

	"Activation"
	manager homeServices
		activateComponent: MolMyTableComponentImpl
		named: #myTable.
	manager homeServices
		activateComponent: MolMyUserComponentImpl
		named: #myUser.

	"Tests"
	self assert: user getMolMyTableServicesProvider equals: table
]

{ #category : #tests }
MolServicesTest >> testTableProvideServicesNotActivated [

	| manager table user |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolMyUserComponentImpl.

	"Instanciation"
	table := manager homeServices instantiateComponent:
		         MolMyTableComponentImpl.
	user := manager homeServices instantiateComponent:
		        MolMyUserComponentImpl.

	"Tests : service is provided when component is not activated"
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.

	manager homeServices activateComponent: MolMyTableComponentImpl.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.

	manager homeServices passivateComponent: MolMyTableComponentImpl.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent
]

{ #category : #tests }
MolServicesTest >> testTableProvideServicesNotActivatedNamed [

	| manager table user |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolMyUserComponentImpl.

	"Instanciation"
	table := manager homeServices
		         instantiateComponent: MolMyTableComponentImpl
		         named: #myTable.
	user := manager homeServices
		        instantiateComponent: MolMyUserComponentImpl
		        named: #myUser.

	"Subscription : it should be done in SCMMyUserComponentImpl > componentInitialize"
	user forServices: MolMyTableServices useProvider: #myTable.

	"Tests"
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.

	manager homeServices
		activateComponent: MolMyTableComponentImpl
		named: #myTable.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent.

	manager homeServices
		passivateComponent: MolMyTableComponentImpl
		named: #myTable.
	self assert: user getMolMyTableServicesProvider equals: table.
	user getMolMyTableServicesProvider getContent
]

{ #category : #tests }
MolServicesTest >> testTableProvideServicesToSeveralUsers [

	| manager table user1 user2 |
	manager := MolComponentManager default.

	"Deployment"
	manager deploymentServices deployComponentImplementation:
		MolMyTableComponentImpl.
	manager deploymentServices deployComponentImplementation:
		MolMyUserComponentImpl.

	"Instanciation"
	table := manager homeServices instantiateComponent:
		         MolMyTableComponentImpl.
	user1 := manager homeServices
		         instantiateComponent: MolMyUserComponentImpl
		         named: #user1.
	user2 := manager homeServices
		         instantiateComponent: MolMyUserComponentImpl
		         named: #user2.

	"Auto subscriptions, because of using default component name"

	"Activation"
	manager homeServices activateComponent: MolMyTableComponentImpl.
	manager homeServices
		activateComponent: MolMyUserComponentImpl
		named: #user1.

	"Tests"
	self assert: user1 getMolMyTableServicesProvider equals: table.
	user1 getMolMyTableServicesProvider getContent.

	manager homeServices
		activateComponent: MolMyUserComponentImpl
		named: #user2.
	self assert: user2 getMolMyTableServicesProvider equals: table.
	self assert: user1 getMolMyTableServicesProvider equals: table.
	user2 getMolMyTableServicesProvider getContent
]
