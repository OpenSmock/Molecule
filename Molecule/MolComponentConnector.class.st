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
		'eventsNotifiers',
		'component'
	],
	#category : #'Molecule-Core'
}

{ #category : #service }
MolComponentConnector >> activateComponent [

	eventsNotifiers do: [ :e | e activate ]
]

{ #category : #service }
MolComponentConnector >> connectComponent: aComponent [

	aComponent componentConnector: self.
	
	component := aComponent.
	eventsNotifiers := Dictionary new.
	eventsSubscribers := Dictionary new.
	servicesProviders := Dictionary new.
	parametersProviders := Dictionary new.
	
	component class allProducedEvents do: [ :evt | eventsNotifiers at: evt put: (MolEventNotifier new interface: evt originator: component)].
	component class allUsedServices do: [ :svc | servicesProviders at: svc put: #default].
	component class allConsumedEvents do: [ :evt | eventsSubscribers at: evt put: #default].
	component class allUsedParameters do: [ :svc | parametersProviders at: svc put: #default].

]

{ #category : #accessing }
MolComponentConnector >> eventsNotifiers [

	^ eventsNotifiers
]

{ #category : #accessing }
MolComponentConnector >> eventsSubscribers [

	^ eventsSubscribers
]

{ #category : #'initialize-release' }
MolComponentConnector >> initialize [

	super initialize.

	eventsNotifiers := Dictionary new.
	eventsSubscribers := Dictionary new.
	servicesProviders := Dictionary new.
	parametersProviders := Dictionary new.
]

{ #category : #accessing }
MolComponentConnector >> parametersProviders [

	^ parametersProviders
]

{ #category : #service }
MolComponentConnector >> passivateComponent [
	
	eventsNotifiers do: [ :e | e deactivate]

]

{ #category : #'initialize-release' }
MolComponentConnector >> release [

	super release.

	eventsNotifiers := nil.
	eventsSubscribers := nil.
	servicesProviders := nil.
	parametersProviders := nil.
	component := nil.
	
]

{ #category : #accessing }
MolComponentConnector >> servicesProviders [

	^ servicesProviders
]
