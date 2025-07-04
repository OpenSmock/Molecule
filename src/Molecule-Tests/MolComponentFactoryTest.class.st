"
A MolComponentFactoryTest is a test class for testing the behavior of MolComponentFactory
"
Class {
	#name : #MolComponentFactoryTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #'setUp-tearDown' }
MolComponentFactoryTest >> cleanGeneratedClassesAndTraits [
	<script: 'self new cleanGeneratedClassesAndTraits'>

	| edited |
	edited := false.

	self class environment at: self generatedComponentClassSymbolName ifPresent: [ :c | c removeFromSystem. edited := true].
	self class environment at: self generatedComponentClass2SymbolName ifPresent: [ :c | c removeFromSystem. edited := true].
	self class environment at: self generatedComponentTypeSymbolName ifPresent: [ :c | c removeFromSystem. edited := true].
	self class environment at: self generatedComponentServicesSymbolName ifPresent: [ :c | c removeFromSystem. edited := true].
	self class environment at: self generatedComponentParametersSymbolName ifPresent: [ :c | c removeFromSystem. edited := true].
	self class environment at: self generatedComponentEventsSymbolName ifPresent: [ :c | c removeFromSystem. edited := true].
	
	(MolCompleteComponent usedComponentServices includes: MolUsedServices) ifFalse:[
		MolComponentFactory addUsedServices: MolUsedServices in: MolCompleteComponent.
		edited := true.
	].
	
	edited ifTrue:[(Delay forMilliseconds: 100) wait].
]

{ #category : #utils }
MolComponentFactoryTest >> createInstanceMethod: aSelector in: aClassOrTrait protocol: aProtocolString withCode: aSourceCodeString [
	"Create an instance method in a Class or Trait with source code implementation"
	| sourceCode |
	sourceCode := WriteStream on: String new.
	sourceCode nextPutAll: aSelector.
	aSourceCodeString ifNotNil:[
		sourceCode crtab: 1.
		sourceCode nextPutAll: aSourceCodeString
	].
	
	"Compile"
	aClassOrTrait compile: sourceCode contents classified: aProtocolString.
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentClass [
	^self class environment at: self generatedComponentClassSymbolName
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentClass2 [
	^self class environment at: self generatedComponentClass2SymbolName
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentClass2SymbolName [
	^ #MolTestGeneratedComponentImpl
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentClassSymbolName [
	^ #MolCompleteComponentTestImpl
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentEventsSymbolName [
	^ #MolTestGeneratedComponentEvents
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentEventsTrait [
	^self class environment at: self generatedComponentEventsSymbolName
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentParametersSymbolName [
	^ #MolTestGeneratedComponentParameters
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentParametersTrait [
	^self class environment at: self generatedComponentParametersSymbolName
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentServicesSymbolName [
	^ #MolTestGeneratedComponentServices
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentServicesTrait [
	^self class environment at: self generatedComponentServicesSymbolName
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentTypeSymbolName [
	^ #MolTestGeneratedComponentType
]

{ #category : #accessing }
MolComponentFactoryTest >> generatedComponentTypeTrait [
	^self class environment at: self generatedComponentTypeSymbolName
]

{ #category : #accessing }
MolComponentFactoryTest >> generationTag [
	^'Molecule-Tests-Resources - Generated'
]

{ #category : #'setUp-tearDown' }
MolComponentFactoryTest >> restoreRemovedThings [
	"Restore things removed in tests"
	<script: 'self new restoreRemovedThings'>
	
	self createInstanceMethod: 'usedComponentServices' in: (MolCompleteComponentOverloadImpl class) protocol: 'accessing - services' withCode: '
	<componentContract>
	^ { MolUsedServices. MolUsedServices2 }'.
]

{ #category : #running }
MolComponentFactoryTest >> setUp [

	self timeLimit: 30 seconds.
	MolComponentManager cleanUp.
	self cleanGeneratedClassesAndTraits.
	self restoreRemovedThings.
]

{ #category : #'setUp-tearDown' }
MolComponentFactoryTest >> setUpComponentAndType [
	<script: 'self new setUpComponentAndType'>
	| edited |
	edited := false.
	
	"Prepare or reset required test classes"
	self class environment at: self generatedComponentTypeSymbolName ifAbsent: [ 
		MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
		edited := true.
	].
 
	self class environment at: self generatedComponentServicesSymbolName ifAbsent: [ 
		MolComponentFactory createComponentServices: self generatedComponentServicesSymbolName in: self generationTag.
		edited := true.
	].

	self class environment at: self generatedComponentParametersSymbolName ifAbsent: [ 
		MolComponentFactory createComponentParameters: self generatedComponentParametersSymbolName in: self generationTag.
		edited := true.
	].

	self class environment at: self generatedComponentEventsSymbolName ifAbsent: [ 
		MolComponentFactory createComponentEvents: self generatedComponentEventsSymbolName in: self generationTag.
		edited := true.
	].

	self class environment at: self generatedComponentClassSymbolName ifAbsent: [
		MolComponentFactory createComponentForType: MolCompleteComponent named: self generatedComponentClassSymbolName in: self generationTag.
		edited := true.
	].

	self class environment at: self generatedComponentClass2SymbolName ifAbsent: [
		MolComponentFactory createComponentForType: MolCompleteComponent named: self generatedComponentClass2SymbolName in: self generationTag.
		edited := true.
	].

	(MolCompleteComponent usedComponentServices includes: MolUsedServices) ifFalse:[
		MolComponentFactory addUsedServices: MolUsedServices in: MolCompleteComponent.
		edited := true.
	].
	
	edited ifTrue:[(Delay forMilliseconds: 100) wait].
]

{ #category : #running }
MolComponentFactoryTest >> tearDown [

	(Delay forMilliseconds: 10) wait.
	self cleanGeneratedClassesAndTraits.
	self restoreRemovedThings.
	MolComponentManager cleanUp.
]

{ #category : #tests }
MolComponentFactoryTest >> testCollectComponentConnectionTraits [
	| traits |
	traits := MolComponentFactory default collectComponentConnectionTraits: nil.
	self assert: traits isEmpty.
	
	traits := MolComponentFactory default collectComponentConnectionTraits: MolTestComponentImplA.
	self assert: traits isEmpty.
	
	traits := MolComponentFactory default collectComponentConnectionTraits: MolTestComponentImplA new.
	self assert: traits isEmpty.
	
	traits := MolComponentFactory default collectComponentConnectionTraits: MolCompleteComponentImpl.
	self assert: traits size equals: 3.
	self assert: (traits includes: MolUsedServices).
	self assert: (traits includes: MolUsedEvents).
	self assert: (traits includes: MolUsedParameters).
	
	traits := MolComponentFactory default collectComponentConnectionTraits: MolCompleteComponentImpl new.
	self assert: traits size equals: 3.
	self assert: (traits includes: MolUsedServices).
	self assert: (traits includes: MolUsedEvents).
	self assert: (traits includes: MolUsedParameters).
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentChangedOnComponentCreationWithoutType [
	"Create a class, edit this class from different ways and check if the factory define the component or not"
	| isDynamicContractUpdateActivated |
	self assert: MolComponentFactory default dirtyComponents isEmpty.
	
	"For testing deactive the dynamic contract update, store the previous setting for restore it at the end of the test"
	isDynamicContractUpdateActivated := MolComponentFactory default isDynamicContractUpdateActivated.
	MolComponentFactory default deactivateDynamicContractUpdate: false.
	
	"remove the testing class, and create a new component without Type, when the type is added check if the component in on the dirty components list"
	MolComponentFactory createComponentNamed: self generatedComponentClassSymbolName in: self generationTag.
	
	"Waiting for event callback"
	self assert: (MolComponentFactory default dirtyComponents includes: (self generatedComponentClass)).
	MolComponentFactory default dirtyComponents removeAll.
	
	"add the type manually to the created component"
	self generatedComponentClass setTraitComposition: MolCompleteComponent.
	"Waiting for event callback"
	self assert: (MolComponentFactory default dirtyComponents includes: (self generatedComponentClass)).
	MolComponentFactory default dirtyComponents removeAll.
	
	"remove the testing class, and create a new component with Type, check if the component in on the dirty components list"
 	(self class environment at: self generatedComponentClassSymbolName) removeFromSystem.
	MolComponentFactory createComponentForType: MolCompleteComponent named: self generatedComponentClassSymbolName in: self generationTag.
	
	"Waiting for event callback"
	self assert: (MolComponentFactory default dirtyComponents includes: (self generatedComponentClass)).
	MolComponentFactory default dirtyComponents removeAll.
	
	isDynamicContractUpdateActivated 
		ifTrue:[MolComponentFactory default activateDynamicContractUpdate: false] 
		ifFalse:[MolComponentFactory default deactivateDynamicContractUpdate: false].
	
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentContractChanged [
	"Create a class, edit this class from different ways and check if the factory define the component or not"
	| isDynamicContractUpdateActivated methodName source |
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.
	
	"For testing deactive the dynamic contract update, store the previous setting for restore it at the end of the test"
	isDynamicContractUpdateActivated := MolComponentFactory default isDynamicContractUpdateActivated.
	MolComponentFactory default deactivateDynamicContractUpdate: false.
	
	"Add manually a new used services in the MolCompleteComponent Type"
	methodName := 'usedComponentServices'.
	source := String streamContents: [ :s | 
		s nextPutAll: methodName. 
		s nextPut: Character cr. 
		s nextPutAll: '<componentContract>'.
		s nextPut: Character cr.
		s nextPutAll: '^{ }'.
	].
	MolCompleteComponent class compile: source.
	
	self assert: (MolComponentFactory default dirtyComponentTypes includes: MolCompleteComponent).
		
	MolComponentFactory default dirtyComponentTypes removeAll.
	isDynamicContractUpdateActivated 
		ifTrue:[MolComponentFactory default activateDynamicContractUpdate: false] 
		ifFalse:[MolComponentFactory default deactivateDynamicContractUpdate: false].
	
]

{ #category : #'test - overload' }
MolComponentFactoryTest >> testComponentContractImplGeneration [

	| toFind |
	MolCompleteComponentOverloadImpl defineComponent.
	toFind := { #getMolUsedEventsNotifier. #getMolUsedParametersProvider.
	          #getMolUsedServicesProvider. #getMolUsedEventsSubscriber.
	          #getMolUsedEventsSubscriber. #getMolUsedEvents2Notifier.
	          #getMolUsedParameters2Provider.
	          #getMolUsedServices2Provider }.
	toFind := toFind reject: [ :e |
		          MolCompleteComponentOverloadImpl allSelectors includes: e ].
	self assert: toFind isEmpty
]

{ #category : #tests }
MolComponentFactoryTest >> testComponentFactoryDefaultClass [
	MolComponentFactory cleanUp.

	self assert: MolComponentFactory default class equals: MolComponentFactory.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.
	self assert: MolComponentFactory default dirtyComponents isEmpty.
	
	MolComponentFactory cleanUp.
]

{ #category : #'test - component subclasses' }
MolComponentFactoryTest >> testComponentSubclassesTraitsUses [
	"Test if the traits declaration are correctly injected into a component class hierarchy
	We have 3 components : A, B and C which inherits one another.
	- Set a ComponentType (with an empty contract) to the ComponentA
	- Adding Services, Events and Parameters in the Type and check if ComponentTraits are not propagated to B and C by the dynamic contract processing.
	- Add a TraitA in the Component A, check if it only on A
	- Add a TraitB in the Component B, check if it only on B
	- Add a TraitC in the Component C, check if it only on C
	"
	| type |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	MolTestComponentImplA setTraitComposition: #().
	MolTestComponentImplB setTraitComposition: #().
	MolTestComponentImplC setTraitComposition: #().
	
	self testCreateComponentType.
	
	type := self generatedComponentTypeTrait.
	MolTestComponentImplA setTraitComposition: type.

	self testCreateComponentServices.
	self testCreateComponentParameters.
	self testCreateComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: type.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: type.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: type. 
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: type.
	MolComponentFactory addProducedEvents: self generatedComponentEventsTrait in: type. 
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: type.
	
	"Check Trait composition of A, B and C"
	self assert: MolTestComponentImplA traitComposition traits size equals: 4.
	self assert: MolTestComponentImplB traitComposition isEmpty.
	self assert: MolTestComponentImplC traitComposition isEmpty.
	
	"Adding traits"
	MolTestComponentImplA addToComposition: MolTestNoComponentTraitA.
	MolTestComponentImplB setTraitComposition: MolTestNoComponentTraitB.
	MolTestComponentImplC setTraitComposition: MolTestNoComponentTraitC.
	
	"Check Trait composition of A, B and C"
	self assert: MolTestComponentImplA traitComposition traits size equals: 5.
	self assert: MolTestComponentImplB traitComposition traits size equals: 1.
	self assert: MolTestComponentImplC traitComposition traits size equals: 1.
	
	"Remove the type and check if the each no components traits are already here"
	MolTestComponentImplA removeFromComposition: type.
	
	"Check Trait composition of A, B and C"
	self assert: MolTestComponentImplA traitComposition traits size equals: 1.
	self assert: MolTestComponentImplB traitComposition traits size equals: 1.
	self assert: MolTestComponentImplC traitComposition traits size equals: 1.
	
	MolTestComponentImplA setTraitComposition: #().
	MolTestComponentImplB setTraitComposition: #().
	MolTestComponentImplC setTraitComposition: #().
]

{ #category : #'test - component subclasses' }
MolComponentFactoryTest >> testComponentSubclassesTraitsUses2 [

	| type |
	MolTestComponentImplA setTraitComposition: #().
	
	self testCreateComponentType.
	type := self generatedComponentTypeTrait.
	MolTestComponentImplA setTraitComposition: type.

	self testCreateComponentServices.
	self testCreateComponentParameters.
	self testCreateComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: type.

	self assert: MolTestComponentImplA traitComposition traits size equals: 2.
	

]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testCreateComponentClassWithType [
	"Create a Component from scratch with a Type"
	| class |
	"delete generated class if presents"
	self class environment at: self generatedComponentClassSymbolName ifPresent: [ 
		(self class environment at: self generatedComponentClassSymbolName) removeFromSystem 
	].

	MolComponentFactory createComponentForType: MolCompleteComponent named: self generatedComponentClassSymbolName in: self generationTag.

	class := self class environment at: self generatedComponentClassSymbolName.
	self assert: class notNil.
	self assert: class isComponentClass.
	self assert: class haveComponentType.
	
	class comment: 'I am added and removed by test: ', self printString.
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testCreateComponentClassWithoutType [
	"Create a Component from scratch without Type"
	| class |
	"delete generated class if presents"
	self class environment at: self generatedComponentClassSymbolName ifPresent: [ 
		(self class environment at: self generatedComponentClassSymbolName) removeFromSystem.
	].

	MolComponentFactory createComponentNamed: self generatedComponentClassSymbolName in: self generationTag.

	class := self class environment at: self generatedComponentClassSymbolName.
	self assert: class notNil.
	self assert: class isComponentClass.
	self assert: class haveComponentType equals: false.
	
	class comment: 'I am added and removed by test: ', self printString.
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateComponentCompleteContract [
	"Create a Component Type from scratch with services, events and parameters"
	
	self testCreateComponentType.
	self testCreateComponentServices.
	self testCreateComponentParameters.
	self testCreateComponentEvents.
	
	"Initial Local Check"
	self assert: (self generatedComponentTypeTrait providedComponentServices includes: self generatedComponentServicesTrait) equals: false.
	self assert: (self generatedComponentTypeTrait usedComponentServices includes: self generatedComponentServicesTrait) equals: false. 
	self assert: (self generatedComponentTypeTrait providedComponentParameters includes: self generatedComponentParametersTrait) equals: false. 
	self assert: (self generatedComponentTypeTrait usedComponentParameters includes: self generatedComponentParametersTrait) equals: false. 
	self assert: (self generatedComponentTypeTrait producedComponentEvents includes: self generatedComponentEventsTrait) equals: false.
	self assert: (self generatedComponentTypeTrait consumedComponentEvents includes: self generatedComponentEventsTrait) equals: false. 	
		
	"Initial Global Check (inheritance)"
	self assert: (self generatedComponentTypeTrait isProvideServices: self generatedComponentServicesTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isUseServices: self generatedComponentServicesTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isProvideParameters: self generatedComponentParametersTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isUseParameters: self generatedComponentParametersTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isProduceEvents: self generatedComponentEventsTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isConsumeEvents: self generatedComponentEventsTrait) equals: false.
	
	"Declare provide services"
	self assert: (self generatedComponentTypeTrait allProvidedServices includes: self generatedComponentServicesTrait) equals: false.
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	"Local check"
	self assert: (self generatedComponentTypeTrait providedComponentServices includes: self generatedComponentServicesTrait) equals: true.
	
	"Declare use services"
	self assert: (self generatedComponentTypeTrait allUsedServices includes: self generatedComponentServicesTrait) equals: false.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	"Local check"
	self assert: (self generatedComponentTypeTrait usedComponentServices includes: self generatedComponentServicesTrait) equals: true. 
	
	"Declare provide parameters"
	self assert: (self generatedComponentTypeTrait allProvidedParameters includes: self generatedComponentParametersTrait) equals: false.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait. 
	"Local check"
	self assert: (self generatedComponentTypeTrait providedComponentParameters includes: self generatedComponentParametersTrait) equals: true.
	
	"Declare use parameters"
	self assert: (self generatedComponentTypeTrait allUsedParameters includes: self generatedComponentParametersTrait) equals: false.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait. 
	"Local check"
	self assert: (self generatedComponentTypeTrait usedComponentParameters includes: self generatedComponentParametersTrait) equals: true. 
	
	"Declare produce events" 
	self assert: (self generatedComponentTypeTrait allProducedEvents includes: self generatedComponentEventsTrait) equals: false.
	MolComponentFactory addProducedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait. 
	self assert: (self generatedComponentTypeTrait producedComponentEvents includes: self generatedComponentEventsTrait) equals: true.
	
	"Declare consume events"
	self assert: (self generatedComponentTypeTrait allConsumedEvents includes: self generatedComponentEventsTrait) equals: false.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait. 
	"Local check"
	self assert: (self generatedComponentTypeTrait consumedComponentEvents includes: self generatedComponentEventsTrait) equals: true. 
	
	"Final Local Check"
	self assert: (self generatedComponentTypeTrait providedComponentServices includes: self generatedComponentServicesTrait) equals: true.
	self assert: (self generatedComponentTypeTrait usedComponentServices includes: self generatedComponentServicesTrait) equals: true. 
	self assert: (self generatedComponentTypeTrait providedComponentParameters includes: self generatedComponentParametersTrait) equals: true. 
	self assert: (self generatedComponentTypeTrait usedComponentParameters includes: self generatedComponentParametersTrait) equals: true. 
	self assert: (self generatedComponentTypeTrait producedComponentEvents includes: self generatedComponentEventsTrait) equals: true.
	self assert: (self generatedComponentTypeTrait consumedComponentEvents includes: self generatedComponentEventsTrait) equals: true. 	
		
	"Final Global Check (inheritance)"
	self assert: (self generatedComponentTypeTrait isProvideServices: self generatedComponentServicesTrait).
	self assert: (self generatedComponentTypeTrait isUseServices: self generatedComponentServicesTrait).
	self assert: (self generatedComponentTypeTrait isProvideParameters: self generatedComponentParametersTrait).
	self assert: (self generatedComponentTypeTrait isUseParameters: self generatedComponentParametersTrait).
	self assert: (self generatedComponentTypeTrait isProduceEvents: self generatedComponentEventsTrait).
	self assert: (self generatedComponentTypeTrait isConsumeEvents: self generatedComponentEventsTrait).
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateComponentCompleteContractWithoutAPI [
	"Create a Component Type from scratch with services, events and parameters but without API"
	
	self testCreateComponentType.
	self testCreateEmptyComponentServices.
	self testCreateEmptyComponentParameters.
	self testCreateEmptyComponentEvents.
	
	"Initial Local Check"
	self assert: (self generatedComponentTypeTrait providedComponentServices includes: self generatedComponentServicesTrait) equals: false.
	self assert: (self generatedComponentTypeTrait usedComponentServices includes: self generatedComponentServicesTrait) equals: false. 
	self assert: (self generatedComponentTypeTrait providedComponentParameters includes: self generatedComponentParametersTrait) equals: false. 
	self assert: (self generatedComponentTypeTrait usedComponentParameters includes: self generatedComponentParametersTrait) equals: false. 
	self assert: (self generatedComponentTypeTrait producedComponentEvents includes: self generatedComponentEventsTrait) equals: false.
	self assert: (self generatedComponentTypeTrait consumedComponentEvents includes: self generatedComponentEventsTrait) equals: false. 	
		
	"Initial Global Check (inheritance)"
	self assert: (self generatedComponentTypeTrait isProvideServices: self generatedComponentServicesTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isUseServices: self generatedComponentServicesTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isProvideParameters: self generatedComponentParametersTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isUseParameters: self generatedComponentParametersTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isProduceEvents: self generatedComponentEventsTrait) equals: false.
	self assert: (self generatedComponentTypeTrait isConsumeEvents: self generatedComponentEventsTrait) equals: false.
	
	"Declare provide services"
	self assert: (self generatedComponentTypeTrait allProvidedServices includes: self generatedComponentServicesTrait) equals: false.
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	"Local check"
	self assert: (self generatedComponentTypeTrait providedComponentServices includes: self generatedComponentServicesTrait) equals: true.
	
	"Declare use services"
	self assert: (self generatedComponentTypeTrait allUsedServices includes: self generatedComponentServicesTrait) equals: false.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	"Local check"
	self assert: (self generatedComponentTypeTrait usedComponentServices includes: self generatedComponentServicesTrait) equals: true. 
	
	"Declare provide parameters"
	self assert: (self generatedComponentTypeTrait allProvidedParameters includes: self generatedComponentParametersTrait) equals: false.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait. 
	"Local check"
	self assert: (self generatedComponentTypeTrait providedComponentParameters includes: self generatedComponentParametersTrait) equals: true.
	
	"Declare use parameters"
	self assert: (self generatedComponentTypeTrait allUsedParameters includes: self generatedComponentParametersTrait) equals: false.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait. 
	"Local check"
	self assert: (self generatedComponentTypeTrait usedComponentParameters includes: self generatedComponentParametersTrait) equals: true. 
	
	"Declare produce events" 
	self assert: (self generatedComponentTypeTrait allProducedEvents includes: self generatedComponentEventsTrait) equals: false.
	MolComponentFactory addProducedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait. 
	self assert: (self generatedComponentTypeTrait producedComponentEvents includes: self generatedComponentEventsTrait) equals: true.
	
	"Declare consume events"
	self assert: (self generatedComponentTypeTrait allConsumedEvents includes: self generatedComponentEventsTrait) equals: false.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait. 
	"Local check"
	self assert: (self generatedComponentTypeTrait consumedComponentEvents includes: self generatedComponentEventsTrait) equals: true. 
	
	"Final Local Check"
	self assert: (self generatedComponentTypeTrait providedComponentServices includes: self generatedComponentServicesTrait) equals: true.
	self assert: (self generatedComponentTypeTrait usedComponentServices includes: self generatedComponentServicesTrait) equals: true. 
	self assert: (self generatedComponentTypeTrait providedComponentParameters includes: self generatedComponentParametersTrait) equals: true. 
	self assert: (self generatedComponentTypeTrait usedComponentParameters includes: self generatedComponentParametersTrait) equals: true. 
	self assert: (self generatedComponentTypeTrait producedComponentEvents includes: self generatedComponentEventsTrait) equals: true.
	self assert: (self generatedComponentTypeTrait consumedComponentEvents includes: self generatedComponentEventsTrait) equals: true. 	
		
	"Final Global Check (inheritance)"
	self assert: (self generatedComponentTypeTrait isProvideServices: self generatedComponentServicesTrait).
	self assert: (self generatedComponentTypeTrait isUseServices: self generatedComponentServicesTrait).
	self assert: (self generatedComponentTypeTrait isProvideParameters: self generatedComponentParametersTrait).
	self assert: (self generatedComponentTypeTrait isUseParameters: self generatedComponentParametersTrait).
	self assert: (self generatedComponentTypeTrait isProduceEvents: self generatedComponentEventsTrait).
	self assert: (self generatedComponentTypeTrait isConsumeEvents: self generatedComponentEventsTrait).
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateComponentEvents [
	"Create a Component Events from scratch"
	
	self testCreateEmptyComponentEvents.
	
	self createInstanceMethod: 'testGeneratedEventA' in: self generatedComponentEventsTrait protocol: 'events' withCode: nil.
	self createInstanceMethod: 'testGeneratedEventB' in: self generatedComponentEventsTrait protocol: 'events' withCode: nil.
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testCreateComponentForTypeNamedIn [
	"Test errors cases"
	| error |
	error := false.
	[MolComponentFactory createComponentForType: nil named: nil in: nil] on: Error do:[ error := true ].
	self assert: error equals: true.
	
	error := false.
	[MolComponentFactory createComponentForType: String named: #ClassName in: #packageName] on: NotAComponentTypeError do:[ error := true ].
	self assert: error equals: true.
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateComponentParameters [
	"Create a Component Parameters from scratch"
	
	self testCreateEmptyComponentParameters.
	
	self createInstanceMethod: 'testGeneratedParameterA' in: self generatedComponentParametersTrait protocol: 'parameters' withCode: nil.
	self createInstanceMethod: 'testGeneratedParameterB' in: self generatedComponentParametersTrait protocol: 'parameters' withCode: nil.
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateComponentServices [
	"Create a Component Services from scratch"
	
	self testCreateEmptyComponentServices.
	
	self createInstanceMethod: 'testGeneratedServiceA' in: self generatedComponentServicesTrait protocol: 'services' withCode: nil.
	self createInstanceMethod: 'testGeneratedServiceB' in: self generatedComponentServicesTrait protocol: 'services' withCode: nil.
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateComponentType [
	"Create a Component Type from scratch"
	
	"Delete Generated Component Type if presents"
	| trait |
	self class environment at: self generatedComponentTypeSymbolName ifPresent: [ 
		(self class environment at: self generatedComponentTypeSymbolName) removeFromSystem. 
	].

	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.

	trait := self class environment at: self generatedComponentTypeSymbolName.
	self assert: trait notNil.
	self assert: trait isTrait.
	self assert: trait isComponentType.
	self assert: trait isComponentServices equals: false.
	self assert: trait isComponentEvents equals: false.
	self assert: trait isComponentParameters equals: false.
	
	trait comment: 'I am added and removed by test: ', self printString.
	
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateEmptyComponentEvents [
	"Create a Component Events from scratch"
	
	"Delete Generated Component Events if presents"
	| trait |
	self class environment at: self generatedComponentEventsSymbolName ifPresent: [ 
		(self class environment at: self generatedComponentEventsSymbolName) removeFromSystem. 
	].

	MolComponentFactory createComponentEvents: self generatedComponentEventsSymbolName in: self generationTag.

	trait := self class environment at: self generatedComponentEventsSymbolName.
	self assert: trait notNil.
	self assert: trait isTrait.
	self assert: trait isComponentType equals: false.
	self assert: trait isComponentServices equals: false.
	self assert: trait isComponentEvents.
	self assert: trait isComponentParameters equals: false.
	
	trait comment: 'I am added and removed by test: ', self printString.
	
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateEmptyComponentParameters [
	"Create a Component Parameters from scratch"
	
	"Delete Generated Component Parameters if presents"
	| trait |
	self class environment at: self generatedComponentParametersSymbolName ifPresent: [ 
		(self class environment at: self generatedComponentParametersSymbolName) removeFromSystem. 
	].

	MolComponentFactory createComponentParameters: self generatedComponentParametersSymbolName in: self generationTag.

	trait := self class environment at: self generatedComponentParametersSymbolName.
	self assert: trait notNil.
	self assert: trait isTrait.
	self assert: trait isComponentType equals: false.
	self assert: trait isComponentServices equals: false.
	self assert: trait isComponentEvents equals: false.
	self assert: trait isComponentParameters.
	
	trait comment: 'I am added and removed by test: ', self printString.
	
]

{ #category : #'tests - contract creation' }
MolComponentFactoryTest >> testCreateEmptyComponentServices [
	"Create a Component Services from scratch"
	
	"Delete Generated Component Services if presents"
	| trait |
	self class environment at: self generatedComponentServicesSymbolName ifPresent: [ 
		(self class environment at: self generatedComponentServicesSymbolName) removeFromSystem. 
	].

	MolComponentFactory createComponentServices: self generatedComponentServicesSymbolName in: self generationTag.

	trait := self class environment at: self generatedComponentServicesSymbolName.
	self assert: trait notNil.
	self assert: trait isTrait.
	self assert: trait isComponentType equals: false.
	self assert: trait isComponentServices.
	self assert: trait isComponentEvents equals: false.
	self assert: trait isComponentParameters equals: false.
	
	trait comment: 'I am added and removed by test: ', self printString.
	
]

{ #category : #tests }
MolComponentFactoryTest >> testCreateSourceCodeContractSelector [

	| interfaces sourceCode toBeGenerated |
	
	self testCreateComponentType.
	
	interfaces := self generatedComponentTypeTrait consumedComponentEvents asOrderedCollection.
	interfaces add: #MolTestGeneratedComponentEvents.
	
	sourceCode := MolComponentFactory 
		createSourceCodeContractSelector: 'consumedComponentEvents' 
		protocol: MolComponentFactory protocolForComponentEvents
		interfaces: interfaces
		type: self generatedComponentTypeTrait.
	
	toBeGenerated := 'consumedComponentEvents

	<componentContract>
	^ { #MolTestGeneratedComponentEvents }'.
	
	self assert: sourceCode contents equals: toBeGenerated.
]

{ #category : #tests }
MolComponentFactoryTest >> testCreateSourceCodeContractSelector2 [
	"Test with multiple interfaces"

	| interfaces sourceCode toBeGenerated |
	
	self testCreateComponentType.
	
	interfaces := self generatedComponentTypeTrait consumedComponentEvents asOrderedCollection.
	interfaces add: #MolTestGeneratedComponentEvents.
	interfaces add: #MolUsedEvents.
	interfaces add: #MolUsedChildEvents.
	
	sourceCode := MolComponentFactory 
		createSourceCodeContractSelector: 'consumedComponentEvents' 
		protocol: MolComponentFactory protocolForComponentEvents
		interfaces: interfaces
		type: self generatedComponentTypeTrait.
	
	toBeGenerated := 'consumedComponentEvents

	<componentContract>
	^ { #MolTestGeneratedComponentEvents . #MolUsedEvents . #MolUsedChildEvents }'.
	
	self assert: sourceCode contents equals: toBeGenerated.
]

{ #category : #tests }
MolComponentFactoryTest >> testCreateSourceCodeContractSelector3 [
	"Test without interfaces"

	| interfaces sourceCode toBeGenerated |
	
	self testCreateComponentType.
	
	interfaces := {}.
	
	sourceCode := MolComponentFactory 
		createSourceCodeContractSelector: 'consumedComponentEvents' 
		protocol: MolComponentFactory protocolForComponentEvents
		interfaces: interfaces
		type: self generatedComponentTypeTrait.
	
	toBeGenerated := 'consumedComponentEvents

	<componentContract>
	^ {}'.
	
	self assert: sourceCode contents equals: toBeGenerated.
]

{ #category : #tests }
MolComponentFactoryTest >> testDefineAllComponents [
	MolComponentFactory defineAllComponents.
]

{ #category : #tests }
MolComponentFactoryTest >> testDefineComponent [
	"The Factory can define only Component Classes"
	MolComponentFactory defineComponent: nil.
	
	MolComponentFactory defineComponent: Boolean.
	
	MolComponentFactory defineComponent: MolCompleteComponentImpl new.
	
	MolComponentFactory defineComponent: MolCompleteComponentImpl.
	
	MolComponentFactory defineComponent: MolCompleteComponent.
]

{ #category : #tests }
MolComponentFactoryTest >> testDefineComponentTypeImplementors [
	MolComponentFactory default defineComponentTypeImplementors: nil.
	
	MolComponentFactory default defineComponentTypeImplementors: Boolean.
	
	MolComponentFactory default defineComponentTypeImplementors: MolCompleteComponentImpl new.
	
	MolComponentFactory default defineComponentTypeImplementors: MolCompleteComponentImpl.
	
	MolComponentFactory default defineComponentTypeImplementors: MolCompleteComponent.
]

{ #category : #tests }
MolComponentFactoryTest >> testDefineDirtyComponents [
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.

	"Add a dirty component type manually"
	MolComponentFactory default dirtyComponentTypes add: MolMyClientComponent.
	MolComponentFactory default dirtyComponents add: MolMyClientComponentImpl.
	self assert: MolComponentFactory default dirtyComponentTypes notEmpty.
	self assert: MolComponentFactory default dirtyComponents notEmpty.
	
	MolComponentFactory defineDirtyComponents.
	self assert: MolComponentFactory default dirtyComponentTypes isEmpty.
	self assert: MolComponentFactory default dirtyComponents isEmpty.
]

{ #category : #tests }
MolComponentFactoryTest >> testDynamicContractUpdateActivation [
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
	
	MolComponentFactory default isDynamicContractUpdateActivated: false.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: false.
	
	MolComponentFactory default isDynamicContractUpdateActivated: true.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
]

{ #category : #tests }
MolComponentFactoryTest >> testDynamicContractUpdateActivation2 [
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
	
	MolComponentFactory default deactivateDynamicContractUpdate: false.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: false.
	
	MolComponentFactory default activateDynamicContractUpdate: false.
	self assert: MolComponentFactory default isDynamicContractUpdateActivated equals: true.
	
	
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateConsumedEventComponentAccessorsFor [
	MolCompleteComponentImpl removeSelector: #getMolUsedEventsSubscriber.
	MolComponentFactory default generateOrRemoveConsumedEventsComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedEventsSubscriber).
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateProducedEventComponentAccessorsFor [
	MolCompleteComponentImpl removeSelector: #getMolUsedEventsNotifier.
	MolComponentFactory default generateOrRemoveProducedEventsComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedEventsNotifier).
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateUsedParametersComponentAccessorsFor [
	MolCompleteComponentImpl removeSelector: #getMolUsedParametersProvider.
	MolComponentFactory default generateOrRemoveUsedParametersComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedParametersProvider).
]

{ #category : #tests }
MolComponentFactoryTest >> testGenerateUsedServicesComponentAccessorsFor [
	MolCompleteComponentImpl removeSelector: #getMolUsedServicesProvider.
	MolComponentFactory default generateOrRemoveUsedServicesComponentAccessorsFor: MolCompleteComponentImpl.
	self assert: (MolCompleteComponentImpl selectors includes: #getMolUsedServicesProvider).
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentAndAddATrait [
	"Create a Component, adding a trait and adding a component type
	- Create a component Class
	- Add a Trait
	- Declare Component Type
	"
	| class componentClassNameSymbol |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	componentClassNameSymbol := self generatedComponentClass2SymbolName.

	class := MolComponentFactory createComponentNamed: componentClassNameSymbol in: self generationTag.
	class := self class environment at: componentClassNameSymbol.
	class comment: 'I am added and removed by test: ', self printString.
	
	"Set an existing Trait, outside Component system"
	class setTraitComposition: MolTestNoComponentTraitA.
	self assert: (class canPerform: #methodOfNoComponentTrait).
	
	"Set the component type and check if the existing Trait is already functionnal"
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	class addToComposition: self generatedComponentTypeTrait.
	
	self assert: (class canPerform: #methodOfNoComponentTrait).
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentAndAddATraitWithCompleteContract [
	"Create a Component from scratch and adding a trait
	- Create a component Class
	- Create a Component Type
	- Declare Component Type
	- Make Component Contract
	- Add a Trait"
	| componentClassNameSymbol componentClass |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	componentClassNameSymbol := self generatedComponentClass2SymbolName.
	
	MolComponentFactory createComponentNamed: componentClassNameSymbol in: self generationTag.
	componentClass := self class environment at: componentClassNameSymbol.
	
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	componentClass setTraitComposition: self generatedComponentTypeTrait.
	
	self testCreateEmptyComponentServices.
	self testCreateEmptyComponentParameters.
	self testCreateEmptyComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProducedEvents:  self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	
	"Add a trait"
	componentClass addToComposition: MolTestNoComponentTraitA.
	
	self assert: (componentClass canPerform: #methodOfNoComponentTrait).
	self assert: (componentClass traitComposition members size) equals: 5.
	self assert: (componentClass traitComposition includesTrait: MolTestNoComponentTraitA).
	self assert: (componentClass traitComposition includesTrait: MolComponentType).
	self assert: (componentClass traitComposition includesTrait: self generatedComponentServicesTrait).
	self assert: (componentClass traitComposition includesTrait: self generatedComponentParametersTrait).
	self assert: (componentClass traitComposition includesTrait: self generatedComponentEventsTrait).
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentAndAddATraitWithCompleteContractAlternative2 [
	"Create a Component from scratch and adding a trait
	- Create a component Class
	- Add a Trait
	- Create a Component Type
	- Declare Component Type
	- Make Component Contract
	"
	| componentClassNameSymbol componentClass |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	componentClassNameSymbol := self generatedComponentClass2SymbolName.
	
	MolComponentFactory createComponentNamed: componentClassNameSymbol in: self generationTag.
	componentClass := self class environment at: componentClassNameSymbol.
	
	"Add a trait"
	componentClass setTraitComposition: MolTestNoComponentTraitA.
	
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	componentClass addToComposition: self generatedComponentTypeTrait.
	
	self testCreateEmptyComponentServices.
	self testCreateEmptyComponentParameters.
	self testCreateEmptyComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProducedEvents:  self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
 
	self assert: (componentClass canPerform: #methodOfNoComponentTrait).
	self assert: (componentClass traitComposition members size) equals: 5.
	self assert: (componentClass traitComposition includesTrait: MolTestNoComponentTraitA).
	self assert: (componentClass traitComposition includesTrait: MolComponentType).
	self assert: (componentClass traitComposition includesTrait: self generatedComponentServicesTrait).
	self assert: (componentClass traitComposition includesTrait: self generatedComponentParametersTrait).
	self assert: (componentClass traitComposition includesTrait: self generatedComponentEventsTrait).
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentFromScratch [
	"Make a Component from scratch, try to reproduce the workflow of a component creator developper is this order : 
	- Create Component Class
	- Create Type
	- Declare the Type in the Component Class
	- Create Services, Event and Parameters without API
	- Declare Services, Events and Parameters in the Component Type
	- Add API into Services, Events and Parameters"
	| componentClassNameSymbol componentClass |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	componentClassNameSymbol := self generatedComponentClass2SymbolName.
	
	MolComponentFactory createComponentNamed: componentClassNameSymbol in: self generationTag.
	componentClass := self class environment at: componentClassNameSymbol.
	
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	componentClass setTraitComposition: self generatedComponentTypeTrait.
	
	self testCreateEmptyComponentServices.
	self testCreateEmptyComponentParameters.
	self testCreateEmptyComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProducedEvents:  self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	
	"Check generated methods"
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentServicesProvider).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentParametersProvider).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsSubscriber).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsNotifier).
	
	self createInstanceMethod: 'testGeneratedServiceA' in: self generatedComponentServicesTrait protocol: 'services' withCode: nil.
	self createInstanceMethod: 'testGeneratedServiceB' in: self generatedComponentServicesTrait protocol: 'services' withCode: nil.
	self createInstanceMethod: 'testGeneratedParameterA' in: self generatedComponentParametersTrait protocol: 'parameters' withCode: nil.
	self createInstanceMethod: 'testGeneratedParameterB' in: self generatedComponentParametersTrait protocol: 'parameters' withCode: nil.
	self createInstanceMethod: 'testGeneratedEventA' in: self generatedComponentEventsTrait protocol: 'events' withCode: nil.
	self createInstanceMethod: 'testGeneratedEventB' in: self generatedComponentEventsTrait protocol: 'events' withCode: nil.
	
	"Check generated methods"
	self assert: (componentClass canPerform: #testGeneratedServiceA).
	self assert: (componentClass canPerform: #testGeneratedServiceB).
	self assert: (componentClass canPerform: #testGeneratedParameterA).
	self assert: (componentClass canPerform: #testGeneratedParameterB).
	self assert: (componentClass canPerform: #testGeneratedEventA).
	self assert: (componentClass canPerform: #testGeneratedEventB).
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentFromScratchAlternative2 [
	"Make a Component from scratch, try to reproduce the workflow of a component creator developper is this order : 
	- Create Type
	- Create Services, Event and Parameters without API
	- Declare Services, Events and Parameters in the Component Type
	- Add API into Services, Events and Parameters
	- Create Component Class directly with the Type"
	| componentClassNameSymbol componentClass |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	componentClassNameSymbol := self generatedComponentClass2SymbolName.
	
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	
	self testCreateEmptyComponentServices.
	self testCreateEmptyComponentParameters.
	self testCreateEmptyComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProducedEvents:  self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	
	self createInstanceMethod: 'testGeneratedServiceA' in: self generatedComponentServicesTrait protocol: 'services' withCode: nil.
	self createInstanceMethod: 'testGeneratedServiceB' in: self generatedComponentServicesTrait protocol: 'services' withCode: nil.
	self createInstanceMethod: 'testGeneratedParameterA' in: self generatedComponentParametersTrait protocol: 'parameters' withCode: nil.
	self createInstanceMethod: 'testGeneratedParameterB' in: self generatedComponentParametersTrait protocol: 'parameters' withCode: nil.
	self createInstanceMethod: 'testGeneratedEventA' in: self generatedComponentEventsTrait protocol: 'events' withCode: nil.
	self createInstanceMethod: 'testGeneratedEventB' in: self generatedComponentEventsTrait protocol: 'events' withCode: nil.

	MolComponentFactory createComponentForType: self generatedComponentTypeTrait named: componentClassNameSymbol in: self generationTag.
	componentClass := self class environment at: componentClassNameSymbol.
	
	"Check generated methods"
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentServicesProvider).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentParametersProvider).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsSubscriber).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsNotifier).
	
	self assert: (componentClass canPerform: #testGeneratedServiceA).
	self assert: (componentClass canPerform: #testGeneratedServiceB).
	self assert: (componentClass canPerform: #testGeneratedParameterA).
	self assert: (componentClass canPerform: #testGeneratedParameterB).
	self assert: (componentClass canPerform: #testGeneratedEventA).
	self assert: (componentClass canPerform: #testGeneratedEventB).
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentFromScratchAlternative3 [
	"Make a Component from scratch, try to reproduce the workflow of a component creator developper is this order : 
	- Create Type
	- Create Component Class directly with the Type
	- Create Services, Event and Parameters with API
	- Declare Services, Events and Parameters in the Component Type"
	
	| componentClassNameSymbol componentClass |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	componentClassNameSymbol := self generatedComponentClass2SymbolName.
	
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	
	MolComponentFactory createComponentForType: self generatedComponentTypeTrait named: componentClassNameSymbol in: self generationTag.
	componentClass := self class environment at: componentClassNameSymbol.
	
	self testCreateComponentServices.
	self testCreateComponentParameters.
	self testCreateComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProducedEvents:  self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	
	"Check generated methods"
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentServicesProvider).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentParametersProvider).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsSubscriber).
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsNotifier).
	
	self assert: (componentClass canPerform: #testGeneratedServiceA).
	self assert: (componentClass canPerform: #testGeneratedServiceB).
	self assert: (componentClass canPerform: #testGeneratedParameterA).
	self assert: (componentClass canPerform: #testGeneratedParameterB).
	self assert: (componentClass canPerform: #testGeneratedEventA).
	self assert: (componentClass canPerform: #testGeneratedEventB).
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentFromScratchAlternative4 [
	"Make a Component from scratch, try to reproduce the workflow of a component creator developper is this order : 
	- Create Type
	- Create Component Class directly with the Type
	- Create Services, Event and Parameters with API
	- Declare Services, Events and Parameters in the Component Type
	- Remove Component Type uses and check if Traits are removed"
	
	| componentClassNameSymbol componentClass | 
	
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.

	componentClassNameSymbol := self generatedComponentClass2SymbolName.
	
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	
	MolComponentFactory createComponentForType: self generatedComponentTypeTrait named: componentClassNameSymbol in: self generationTag.
	componentClass := self class environment at: componentClassNameSymbol.
	
	self testCreateComponentServices.
	self testCreateComponentParameters.
	self testCreateComponentEvents.
	
	MolComponentFactory addProvidedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedServices: self generatedComponentServicesTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProvidedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addUsedParameters: self generatedComponentParametersTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addConsumedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	MolComponentFactory addProducedEvents:  self generatedComponentEventsTrait in: self generatedComponentTypeTrait.

	self assert: componentClass traitComposition members size equals: 4.
	
	componentClass removeFromComposition: self generatedComponentTypeTrait.

	self assert: componentClass traitComposition isEmpty.
		
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentServicesProvider) equals: false.
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentParametersProvider) equals: false.
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsSubscriber) equals: false.
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsNotifier) equals: false.
	
	self assert: (componentClass canPerform: #testGeneratedServiceA) equals: false.
	self assert: (componentClass canPerform: #testGeneratedServiceB) equals: false.
	self assert: (componentClass canPerform: #testGeneratedParameterA) equals: false.
	self assert: (componentClass canPerform: #testGeneratedParameterB) equals: false.
	self assert: (componentClass canPerform: #testGeneratedEventA) equals: false.
	self assert: (componentClass canPerform: #testGeneratedEventB) equals: false.
]

{ #category : #'tests - component creation' }
MolComponentFactoryTest >> testMakeAComponentFromScratchAlternative5 [
	"Alternative from issue 148 - Make a Component from scratch, try to reproduce the workflow of a component creator developper is this order : 
	- Create Type
	- Create empty Event interface
	- Create native component implementation with the previously created component type
	- Declare consumed Events in the Component Type
	=> Check if the event notifier is generated"
	
	| componentClassNameSymbol componentClass |
	self assert: MolComponentFactory default isDynamicContractUpdateActivated.
	
	MolComponentFactory createComponentType: self generatedComponentTypeSymbolName in: self generationTag.
	
	self testCreateEmptyComponentEvents.
	
	componentClassNameSymbol := self generatedComponentClass2SymbolName.
	MolComponentFactory createComponentForType: self generatedComponentTypeTrait named: componentClassNameSymbol in: self generationTag.
	componentClass := self class environment at: componentClassNameSymbol.
	
	MolComponentFactory addProducedEvents: self generatedComponentEventsTrait in: self generatedComponentTypeTrait.
	
	self assert: (componentClass canPerform: #getMolTestGeneratedComponentEventsNotifier).
]

{ #category : #'tests - protocol' }
MolComponentFactoryTest >> testProtocolForComponentAccess [

	self assert: MolComponentFactory protocolForComponentAccess equals: 'component accessing'.
]

{ #category : #'tests - protocol' }
MolComponentFactoryTest >> testProtocolForComponentEvents [

	self assert: MolComponentFactory protocolForComponentEvents equals: 'accessing - events'.
]

{ #category : #'tests - protocol' }
MolComponentFactoryTest >> testProtocolForComponentParameters [

	self assert: MolComponentFactory protocolForComponentParameters equals: 'accessing - parameters'.
]

{ #category : #'tests - protocol' }
MolComponentFactoryTest >> testProtocolForComponentServices [

	self assert: MolComponentFactory protocolForComponentServices equals: 'accessing - services'.
]

{ #category : #'test - overload' }
MolComponentFactoryTest >> testRemoveInterfaceInImplementationWhichOverloadAType [
	"Testing issue #210 fix"

	| exception |
	exception := nil.

	"Remove the method which overload the services contract: no error should appears"
	[ MolCompleteComponentOverloadImpl class removeSelector: #usedComponentServices ]
		on: Exception
		do: [ :e | exception := e ].
		
	self assert: exception isNil.
]
