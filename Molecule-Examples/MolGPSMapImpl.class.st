Class {
	#name : #MolGPSMapImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolGPSMap + MolGPSDataEvents',
	#classTraits : 'MolGPSMap classTrait + MolGPSDataEvents classTrait',
	#category : #'Molecule-Examples-GPS Example'
}

{ #category : #'component life cycle' }
MolGPSMapImpl >> componentActivate [
	
	self getMolGPSDataEventsSubscriber subscribe: self.
]

{ #category : #'component life cycle' }
MolGPSMapImpl >> componentPassivate [
	
	self getMolGPSDataEventsSubscriber unsubscribe: self.
]

{ #category : #events }
MolGPSMapImpl >> currentPositionChanged: aGeoPosition [

	"Display a circle on the map view at the current position"

	| radius |
	radius := self getMolGPSDataServicesProvider getAccuracyRadiusInMeters.

	self updatePositionCircleOnMap: aGeoPosition radius: radius
]

{ #category : #'component accessing' }
MolGPSMapImpl >> getMolGPSDataEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolGPSDataEvents.
	eventsSymbol := self eventsSubscribers at: itf  ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolGPSDataEvents named:  eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolGPSMapImpl >> getMolGPSDataServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolGPSDataServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolGPSDataServices named:  servicesSymbol]. 
	^servicesProvider
]

{ #category : #'map updating' }
MolGPSMapImpl >> updatePositionCircleOnMap: aGeoPosition radius: radius [
	"Update geographic position of the received GPS position circle with a precision radius"
	
	Transcript show: ('[Map] Receive new GPS position: ', ((aGeoPosition roundTo: 0.1) printString), ' radius: ', radius rounded printString, ' m'); cr.
]
