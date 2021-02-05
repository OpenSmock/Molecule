"
A MolEventSubscriberTest is a test class for testing the behavior of MolEventSubscriber
"
Class {
	#name : #MolEventSubscriberTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #running }
MolEventSubscriberTest >> setUp [

	super setUp.
	MolComponentManager cleanUp.
]

{ #category : #running }
MolEventSubscriberTest >> tearDown [

	MolComponentManager cleanUp.
	super tearDown.
]

{ #category : #test }
MolEventSubscriberTest >> testAddOriginator [
	| subscribers componentEvents eventSubscriber component |
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	subscribers := OrderedCollection new.
	component := MolCompleteComponentImpl new.
	eventSubscriber := MolEventSubscriber events: componentEvents originators: subscribers.
		
	eventSubscriber addOriginator: nil.
	self assert: eventSubscriber originators isEmpty.
		
	eventSubscriber addOriginator: #default.
	self assert: eventSubscriber originators isEmpty.
		
	eventSubscriber addOriginator: component.
	self assert: eventSubscriber originators size equals: 1.
	self assert: (eventSubscriber originators includes: component).
]

{ #category : #test }
MolEventSubscriberTest >> testAddOriginators [
	| subscribers componentEvents eventSubscriber componentA componentB |
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	subscribers := OrderedCollection new.
	componentA := MolCompleteComponentImpl new componentName: #compA.
	componentB := MolCompleteComponentImpl new componentName: #compB.	
	eventSubscriber := MolEventSubscriber new.

	eventSubscriber addOriginators: (OrderedCollection with: #default with: nil).
	self assert: eventSubscriber originators isEmpty.	

	eventSubscriber addOriginators: (OrderedCollection with: componentA with: componentB).
	self assert: eventSubscriber originators size equals: 2.
	self assert: (eventSubscriber originators includes: componentA).
	self assert: (eventSubscriber originators includes: componentB).
]

{ #category : #test }
MolEventSubscriberTest >> testEventsOriginators [
	| subscribers componentEvents eventSubscriber componentA componentB |
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	componentA := MolCompleteComponentImpl new componentName: #compA.
	componentB := MolCompleteComponentImpl new componentName: #compB.	
	subscribers := OrderedCollection with: componentA with: componentB.
		
	eventSubscriber := MolEventSubscriber events: componentEvents originators: subscribers.
	self assert: eventSubscriber originators size equals: 2.
	self assert: (eventSubscriber originators includes: componentA).
	self assert: (eventSubscriber originators includes: componentB).
]

{ #category : #test }
MolEventSubscriberTest >> testGetObserversFrom [
	| observer producer |

	observer := MolCompleteComponentImpl start.
	producer := MolCompleteComponentImpl start: #producer.

	self assert: (observer getMolUsedEventsSubscriber getObserversFrom: nil) isEmpty.
	self assert: (observer getMolUsedEventsSubscriber getObserversFrom: producer) isEmpty.
	
	observer getMolUsedEventsSubscriber subscribe: observer.
	self assert: (observer getMolUsedEventsSubscriber getObserversFrom: producer) isEmpty.
	
	observer forEvents: MolUsedEvents useProducer: #producer. 
	self assert: (observer getMolUsedEventsSubscriber getObserversFrom: producer) isEmpty.
	
	observer getMolUsedEventsSubscriber subscribe: observer.
	self assert: (observer getMolUsedEventsSubscriber getObserversFrom: producer) size equals: 1.
	self assert: (observer getMolUsedEventsSubscriber getObserversFrom: producer) first identicalTo: observer.
]

{ #category : #test }
MolEventSubscriberTest >> testIncludesOriginator [
	| subscribers componentEvents eventSubscriber component |
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	component := MolCompleteComponentImpl new.
	subscribers := OrderedCollection with: component.
	
	eventSubscriber := MolEventSubscriber events: componentEvents originators: subscribers.
	self assert: (eventSubscriber includesOriginator: nil) equals: false.
	self assert: (eventSubscriber includesOriginator: #default) equals: false.
	self assert: (eventSubscriber includesOriginator: component).
]

{ #category : #test }
MolEventSubscriberTest >> testInitialize [
	| eventSubscriber |
	eventSubscriber := MolEventSubscriber new.
	
	self assert: eventSubscriber events isNil.
	self assert: eventSubscriber originators isEmpty.
	self assert: eventSubscriber originatorsLinks isEmpty.
	self assert: eventSubscriber observersConnection isEmpty.
]

{ #category : #test }
MolEventSubscriberTest >> testIsAllOriginatorsLinked [
	| subscribers componentEvents eventSubscriber |
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	eventSubscriber := MolEventSubscriber events: componentEvents originators: subscribers.
	
	"Originators is empty, return true"
	self assert: eventSubscriber isAllOriginatorsLinked equals: true.
]

{ #category : #test }
MolEventSubscriberTest >> testIsNotFoundEventsSubscriber [
	| subscribers componentEvents eventSubscriber |
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	eventSubscriber := MolEventSubscriber events: componentEvents originators: subscribers.
	
	self assert: eventSubscriber isNotFoundEventsSubscriber equals: false.
]

{ #category : #test }
MolEventSubscriberTest >> testRelease [
	| subscribers componentEvents eventSubscriber |
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	subscribers := OrderedCollection with: #default.
	eventSubscriber := MolEventSubscriber events: componentEvents originators: subscribers.
	
	eventSubscriber release.
	
	self assert: eventSubscriber events equals: nil.
	self assert: eventSubscriber originators isEmpty.
	self assert: eventSubscriber originatorsLinks isEmpty.
	self assert: eventSubscriber observersConnection isEmpty.
]

{ #category : #test }
MolEventSubscriberTest >> testRemoveOriginator [
	| subscribers componentEvents eventSubscriber component |
	
	subscribers := OrderedCollection new.
	componentEvents := MolUsedChildEvents.
	component := MolCompleteComponentImpl new.
	subscribers := OrderedCollection with: component.
	
	eventSubscriber := MolEventSubscriber events: componentEvents originators: subscribers.
	eventSubscriber removeOriginator: component.
	self assert: (eventSubscriber originators isEmpty).
]

{ #category : #test }
MolEventSubscriberTest >> testRemoveOriginatorWithManyObservers [
	| observer producerA producerB |
	
	observer := MolCompleteComponentImpl start.
	producerA := MolCompleteComponentImpl start: #producerA.
	producerB := MolCompleteComponentImpl start: #producerB.
	observer forEvents: MolUsedEvents useAllProducers: #(#producerA #producerB). 

	observer getMolUsedEventsSubscriber subscribe: observer.
	self assert: (observer getMolUsedEventsSubscriber observersConnection at: observer) size equals: 2.

	"Remove only producer A"
	observer getMolUsedEventsSubscriber removeOriginator: producerA.
	self assert: (observer getMolUsedEventsSubscriber observersConnection at: observer) size equals: 1.
	
	"Remove only producer B"
	observer getMolUsedEventsSubscriber removeOriginator: producerB.
	self assert: (observer getMolUsedEventsSubscriber observersConnection at: observer) isEmpty.
]

{ #category : #test }
MolEventSubscriberTest >> testRemoveOriginatorWithObservers [
	| observer producer |
	
	observer := MolCompleteComponentImpl start.
	producer := MolCompleteComponentImpl start: #producer.
	observer forEvents: MolUsedEvents useProducer: #producer. 

	observer getMolUsedEventsSubscriber subscribe: observer.
	self assert: (observer getMolUsedEventsSubscriber observersConnection at: observer) size equals: 1.

	observer getMolUsedEventsSubscriber removeOriginator: producer.
	self assert: (observer getMolUsedEventsSubscriber observersConnection at: observer) isEmpty.
]

{ #category : #test }
MolEventSubscriberTest >> testSubscribe [
	| eventSubscriber component |
	eventSubscriber := MolEventSubscriber events: MolUsedEvents originators: #(#default).
	component := MolCompleteComponentImpl new.
	
	eventSubscriber subscribe: nil.
	self assert: (eventSubscriber observersConnection includesKey: nil) equals: false.
	
	eventSubscriber subscribe: #key.
	self assert: (eventSubscriber observersConnection includesKey: #key) equals: false.
	
	eventSubscriber subscribe: component.
	self assert: (eventSubscriber observersConnection includesKey: component) equals: true.
	self assert: (eventSubscriber observersConnection at: component) isEmpty.
	self assert: eventSubscriber originators isEmpty.
	self assert: eventSubscriber originatorsLinks isEmpty.
]

{ #category : #test }
MolEventSubscriberTest >> testSubscribe2 [
	| eventSubscriber component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	eventSubscriber := component getMolUsedEventsSubscriber.
	self assert: eventSubscriber observersConnection isEmpty.
	self assert: eventSubscriber originators size equals: 1.
	self assert: eventSubscriber originators first equals: component.
	self assert: (eventSubscriber originatorsLinks at: #default) equals: component.
	
	eventSubscriber subscribe: component.
	self assert: (eventSubscriber observersConnection includesKey: component).
	self assert: (eventSubscriber observersConnection at: component) size equals: 1.
	self assert: ((eventSubscriber observersConnection at: component) includes: #default).
	self assert: eventSubscriber originators size equals: 1.
	self assert: eventSubscriber originators first equals: component.
	self assert: (eventSubscriber originatorsLinks at: #default) equals: component.
	
]

{ #category : #test }
MolEventSubscriberTest >> testUnsubscribe [
	| eventSubscriber component |
	eventSubscriber := MolEventSubscriber events: MolUsedEvents originators: #(#default).
	component := MolCompleteComponentImpl new.
	
	eventSubscriber subscribe: component.
	self assert: (eventSubscriber observersConnection includesKey: component) equals: true.
	
	eventSubscriber unsubscribe: component.
	self assert: (eventSubscriber observersConnection includesKey: component) equals: false.
]

{ #category : #test }
MolEventSubscriberTest >> testUnsubscribe2 [
	| eventSubscriber component |
	component := MolUtils startComponent: MolCompleteComponentImpl.
	eventSubscriber := component getMolUsedEventsSubscriber.
	eventSubscriber subscribe: component.
	eventSubscriber unsubscribe: component.

	self assert: eventSubscriber observersConnection isEmpty.
	self assert: eventSubscriber originators size equals: 1.
	self assert: eventSubscriber originators first equals: component.
	self assert: (eventSubscriber originatorsLinks at: #default) equals: component.
]
