Class {
	#name : #MolBenchmarkComponentB,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolBenchmarkTypeB + MolBenchmarkEventsA',
	#classTraits : 'MolBenchmarkTypeB classTrait + MolBenchmarkEventsA classTrait',
	#category : #'Molecule-Benchmarks-Benchs Components'
}

{ #category : #'component accessing' }
MolBenchmarkComponentB >> componentActivate [ 

	self getMolBenchmarkEventsASubscriber subscribe: self. 

	
]

{ #category : #'component accessing' }
MolBenchmarkComponentB >> componentPassivate [

	self getMolBenchmarkEventsASubscriber unsubscribe: self. 

	
]

{ #category : #'component accessing' }
MolBenchmarkComponentB >> getMolBenchmarkEventsASubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolBenchmarkEventsA.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [self error:'Events not found'].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolBenchmarkEventsA named:  eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
MolBenchmarkComponentB >> getMolBenchmarkServicesAProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolBenchmarkServicesA.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [self error:'Services not found'].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolBenchmarkServicesA named:  servicesSymbol]. 
	^servicesProvider
]

{ #category : #events }
MolBenchmarkComponentB >> receiveAnEvent [

	"do nothing"
]

{ #category : #events }
MolBenchmarkComponentB >> receiveAnEventWith: anObject [

	"do nothing"
]
