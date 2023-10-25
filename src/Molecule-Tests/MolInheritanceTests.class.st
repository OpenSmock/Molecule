Class {
	#name : #MolInheritanceTests,
	#superclass : #TestCase,
	#instVars : [
		'motherComponent',
		'childComponent'
	],
	#category : #'Molecule-Tests-Cases'
}

{ #category : #running }
MolInheritanceTests >> setUp [

	| manager |
	MolComponentManager cleanUp.
	manager := MolComponentManager default.

	"Deploy components"
	manager deploymentServices deployComponentImplementation: MolCompleteComponentImpl.
	manager deploymentServices deployComponentImplementation: MolCompleteComponentChildImpl.

	"Instanciate componenets"
	motherComponent := manager homeServices instantiateComponent: MolCompleteComponentImpl.
	childComponent := manager homeServices instantiateComponent: MolCompleteComponentChildImpl named: #compB.

	motherComponent forServices: MolUsedServices useProvider: #compB.

	"Activate components"
	manager homeServices activateComponent: MolCompleteComponentImpl.
	manager homeServices activateComponent: MolCompleteComponentChildImpl named: #compB
]

{ #category : #running }
MolInheritanceTests >> tearDown [ 

	MolComponentManager cleanUp.
]

{ #category : #tests }
MolInheritanceTests >> testDefineComponent [
	"Test the definition of the two components."
	
	MolComponentFactory defineComponent: MolCompleteComponentImpl.
	MolComponentFactory defineComponent: MolCompleteComponentChildImpl.
]

{ #category : #tests }
MolInheritanceTests >> testEvents [
	"Test events behavior"
	
	self assert: motherComponent event equals: #event.
	self deny: (motherComponent class selectors includes: #subEvent).
		
	self assert: childComponent event equals: #event.
	self assert: childComponent subEvent equals: #subEvent.
]

{ #category : #tests }
MolInheritanceTests >> testEventsNotifier [
	"Test call to event notifier"
	
	motherComponent getMolUsedEventsNotifier event.
	
	childComponent getMolUsedEventsNotifier event.
	childComponent getMolUsedChildEventsNotifier subEvent.
]

{ #category : #tests }
MolInheritanceTests >> testEventsSubscriber [
	"Test call to event notifier"
	
	motherComponent getMolUsedEventsSubscriber subscribe: motherComponent.
	motherComponent getMolUsedEventsSubscriber unsubscribe: motherComponent.
	
	childComponent getMolUsedEventsSubscriber subscribe: childComponent.
	childComponent getMolUsedChildEventsSubscriber subscribe: childComponent.
	childComponent getMolUsedEventsSubscriber unsubscribe: childComponent.
	childComponent getMolUsedChildEventsSubscriber unsubscribe: childComponent.
	
]

{ #category : #tests }
MolInheritanceTests >> testParameters [
	"Test parameters behavior"
	
	self assert: motherComponent parameter equals: #parameter.
	self deny: (motherComponent class selectors includes: #subParameter).

	self assert: childComponent parameter equals: #parameter.
	self assert: childComponent subParameter equals: #subParameter.
]

{ #category : #tests }
MolInheritanceTests >> testServices [
	"Test services behavior"
	
	self assert: motherComponent service equals: #service.
	self assert: motherComponent getMolUsedServicesProvider identicalTo: childComponent.
	self assert: motherComponent getMolUsedServicesProvider service equals: #service.
	self deny: (motherComponent class selectors includes: #subService).
	
	self assert: childComponent service equals: #service.
	self assert: childComponent subService equals: #subService.
	"In the case of same used Services Type the used services provider is the last instanciated component : the child"
	self assert: childComponent getMolUsedServicesProvider identicalTo: motherComponent.
	self assert: childComponent getMolUsedServicesProvider service equals: #service.
	self assert: childComponent getMolUsedChildServicesProvider isNotFoundServices.
]

{ #category : #tests }
MolInheritanceTests >> testServicesWithoutChild [
	"Test services behavior"
	
	MolUtils stopComponent: MolCompleteComponentChildImpl named: #compB.
	
	self assert: motherComponent getMolUsedServicesProvider isNotFoundServices.
	
	childComponent := MolUtils startComponent: MolCompleteComponentChildImpl named: #compB.
	"Child component dynamically become the previous provider"
	self assert: motherComponent getMolUsedServicesProvider identicalTo: childComponent.
]
