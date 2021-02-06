"
I am relative to only one component implementation, and I manage all its connections to others components.

I am automatically managed by component life cycle.
"
Class {
	#name : #MolComponentConnector,
	#superclass : #Object,
	#instVars : [
		'servicesProviders',
		'parametersProviders',
		'eventsSubscribers',
		'eventsNotifiers'
	],
	#category : #'Molecule-Core'
}

{ #category : #connectors }
MolComponentConnector class >> defaultEventsNotifiers [
	^ Dictionary new
]

{ #category : #connectors }
MolComponentConnector class >> defaultEventsSubscribers [
	^ Dictionary new
]

{ #category : #connectors }
MolComponentConnector class >> defaultParametersProviders [
	^ Dictionary new
]

{ #category : #connectors }
MolComponentConnector class >> defaultServicesProviders [
	^ Dictionary new
]

{ #category : #service }
MolComponentConnector >> activateComponent [
	eventsNotifiers do: [ :e | e activate ] 
]

{ #category : #service }
MolComponentConnector >> connectComponent: aComponent [
	
	eventsNotifiers := self class defaultEventsNotifiers.
	eventsSubscribers := self class defaultEventsSubscribers.
	servicesProviders := self class defaultServicesProviders.
	parametersProviders := self class defaultParametersProviders.
	
	aComponent class allProducedEvents do: [ :evt | eventsNotifiers at: evt put: (MolEventNotifier interface: evt originator: aComponent)].
	aComponent class allUsedServices do: [ :svc | servicesProviders at: svc put: #default].
	aComponent class allConsumedEvents do: [ :evt | eventsSubscribers at: evt put: #default].
	aComponent class allUsedParameters do: [ :svc | parametersProviders at: svc put: #default].

]

{ #category : #service }
MolComponentConnector >> disconnectComponent: aComponent [
	"Remove link between component and connector"
	aComponent componentConnector == self ifFalse:[^self].
	
	eventsNotifiers := nil.
	eventsSubscribers := nil.
	servicesProviders := nil.
	parametersProviders := nil.
]

{ #category : #accessing }
MolComponentConnector >> eventsNotifiers [
	^ eventsNotifiers 
]

{ #category : #accessing }
MolComponentConnector >> eventsSubscribers [
	^ eventsSubscribers 
]

{ #category : #accessing }
MolComponentConnector >> parametersProviders [
	^ parametersProviders 
]

{ #category : #service }
MolComponentConnector >> passivateComponent [
	eventsNotifiers do: [ :e | e deactivate ] 
]

{ #category : #'initialize-release' }
MolComponentConnector >> release [
	eventsNotifiers := nil.
	eventsSubscribers := nil.
	servicesProviders := nil.
	parametersProviders := nil.
	super release.	
]

{ #category : #accessing }
MolComponentConnector >> servicesProviders [
	^ servicesProviders
]
