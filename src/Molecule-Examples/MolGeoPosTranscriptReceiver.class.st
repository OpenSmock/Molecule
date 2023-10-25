Class {
	#name : #MolGeoPosTranscriptReceiver,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolGeoPosReceiverType + MolGeoPosEquipmentEvents',
	#classTraits : 'MolGeoPosReceiverType classTrait + MolGeoPosEquipmentEvents classTrait',
	#category : #'Molecule-Examples-Geographical Position Example'
}

{ #category : #'component life cycle' }
MolGeoPosTranscriptReceiver >> componentActivate [
	
	self getMolGeoPosEquipmentEventsSubscriber subscribe: self.
]

{ #category : #'component life cycle' }
MolGeoPosTranscriptReceiver >> componentPassivate [
	
	self getMolGeoPosEquipmentEventsSubscriber unsubscribe: self.
]

{ #category : #events }
MolGeoPosTranscriptReceiver >> currentPositionChanged: aGeoPosition [

	"Display a circle on the map view at the current position"

	| radius |
	radius := self getMolGeoPosEquipmentServicesProvider getAccuracyRadiusInMeters.

	self updatePositionCircleOnMap: aGeoPosition radius: radius
]

{ #category : #'component accessing' }
MolGeoPosTranscriptReceiver >> getMolGeoPosEquipmentEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolGeoPosEquipmentEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolGeoPosEquipmentEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolGeoPosTranscriptReceiver >> getMolGeoPosEquipmentServicesProvider [
	| servicesSymbol servicesProvider itf |

	itf := MolGeoPosEquipmentServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].
	(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolGeoPosEquipmentServices named: servicesSymbol.
	^servicesProvider
]

{ #category : #'map updating' }
MolGeoPosTranscriptReceiver >> updatePositionCircleOnMap: aGeoPosition radius: radius [
	"Update geographic position of the received GPS position circle with a precision radius"
	
	| point text |
	point := aGeoPosition.
	point := point truncateTo: 0.01.
	text := (point x printShowingDecimalPlaces: 2), '@', (point y printShowingDecimalPlaces: 2).
	
	Transcript show: ('[Map] Receive geographical position: ', text, ' radius: ', radius rounded printString, ' m'); cr.
]
