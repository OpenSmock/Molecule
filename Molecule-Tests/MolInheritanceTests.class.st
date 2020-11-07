Class {
	#name : #MolInheritanceTests,
	#superclass : #TestCase,
	#instVars : [
		'superComponent',
		'subComponent'
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
	superComponent := manager homeServices instanciateComponent: MolCompleteComponentImpl.
	subComponent := manager homeServices instanciateComponent: MolCompleteComponentChildImpl.
	
]

{ #category : #running }
MolInheritanceTests >> tearDown [ 
	| manager |
	manager := MolComponentManager default.
	manager homeServices passivateAllComponents.
	manager homeServices removeAllComponents.
	manager deploymentServices undeployComponentImplementation: MolCompleteComponentImpl.
	manager deploymentServices undeployComponentImplementation: MolCompleteComponentChildImpl.
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
	self assert: superComponent event equals: #event.
	self assert: subComponent event equals: #event.
	self assert: subComponent subEvent equals: #subEvent.
	self deny: (superComponent class selectors includes: #subEvent).
]

{ #category : #tests }
MolInheritanceTests >> testEventsNotifier [
	"Test call to event notifier"
	subComponent getMolUsedEventsNotifier event
]

{ #category : #tests }
MolInheritanceTests >> testParameters [
	"Test parameters behavior"
	self assert: superComponent parameter equals: #parameter.
	self assert: subComponent parameter equals: #parameter.
	self assert: subComponent subParameter equals: #subParameter.
	self deny: (superComponent class selectors includes: #subParameter).
]

{ #category : #tests }
MolInheritanceTests >> testServices [
	"Test services behavior"
	self assert: superComponent service equals: #service.
	self assert: subComponent service equals: #service.
	self assert: subComponent subService equals: #subService.
	self deny: (superComponent class selectors includes: #subService).
]
