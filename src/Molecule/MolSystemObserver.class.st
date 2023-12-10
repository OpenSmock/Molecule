"
This classe observe Pharo evolution (source code modifications, iceberg, etc.) and control all components contract generation.
"
Class {
	#name : #MolSystemObserver,
	#superclass : #Object,
	#classInstVars : [
		'pragmaCollector',
		'isActive'
	],
	#category : #'Molecule-Core'
}

{ #category : #'class initialization' }
MolSystemObserver class >> active [
	<script>

	self isActive ifTrue:[ ^ self ].
	self subscribeMolPragmaAnnouncements.
	self subscribeSystemAnnouncements.
	self isActive: true.
]

{ #category : #accessing }
MolSystemObserver class >> componentFactory [

	| class |
	class := RGClassDefinition named: #MolComponentFactory.
	
	class isDefined
		ifTrue: [ ^ class realClass default ]
		ifFalse: [ ^ nil ]
]

{ #category : #'class initialization' }
MolSystemObserver class >> deactive [ 
	<script>

	self unsubscribeSystemAnnouncements.
	self unsubscribeMolPragmaAnnouncements.
	self isActive: false.
]

{ #category : #'class initialization' }
MolSystemObserver class >> initialize [

	self active
]

{ #category : #accessing }
MolSystemObserver class >> isActive [

	^ isActive ifNil:[ isActive := false ]
]

{ #category : #accessing }
MolSystemObserver class >> isActive: anObject [

	isActive := anObject
]

{ #category : #receiving }
MolSystemObserver class >> receiveClassAdded: anAnnouncement [
	"Check if a component implementation class is added"

	| class |
	class := anAnnouncement classAdded ifNil:[ ^ self ].
	class isObsolete ifTrue:[ ^ self ].
	class isTrait ifTrue:[ ^ self ].
	class isComponentClass ifFalse:[ ^ self ].
	
	self componentFactory ifNotNil:[ :e | e componentChanged: class ]
]

{ #category : #receiving }
MolSystemObserver class >> receiveClassModificationApplied: anAnnouncement [
	"Check if a component implementation class is modified"

	| class |
	class := anAnnouncement classAffected ifNil:[ ^ self ].
	class isObsolete ifTrue:[ ^ self ].
	class isTrait ifTrue:[ ^ self ].
	class isComponentClass ifFalse:[ ^ self ].
	
	self componentFactory ifNotNil:[ :e | e componentChanged: class ]
]

{ #category : #receiving }
MolSystemObserver class >> receiveIceAnnouncement: anAnnouncement [

	"do nothing"
]

{ #category : #receiving }
MolSystemObserver class >> receiveMCVersionLoaderStarted: anAnnouncement [

	self componentFactory ifNotNil:[ :e | e deactivateDynamicContractUpdate: false ]
]

{ #category : #receiving }
MolSystemObserver class >> receiveMCVersionLoaderStopped: anAnnouncement [

	self componentFactory ifNotNil:[ :e | e activateDynamicContractUpdate: false ]
]

{ #category : #receiving }
MolSystemObserver class >> receiveMolPragmaAnnouncement: anAnnouncement [

	| pragma method methodClass componentType |
	pragma := anAnnouncement pragma ifNil:[ ^ self ].
	method := pragma method ifNil:[ ^ self ].
	methodClass := method methodClass ifNil:[ ^ self ].
	componentType := methodClass instanceSide ifNil:[ ^ self ].

	componentType isObsolete ifTrue:[ ^ self ].
	componentType isTrait ifFalse:[ ^ self ].
	componentType isComponentType ifFalse:[ ^ self ].

	self componentFactory ifNotNil:[ :e | e contractChanged: componentType ]
]

{ #category : #'class initialization' }
MolSystemObserver class >> release [ 

	self deactive
]

{ #category : #announcements }
MolSystemObserver class >> subscribeMolPragmaAnnouncements [

	pragmaCollector := (PragmaCollector new filter: [ :prg |
		                    prg selector
		                    =
		                    MolComponentFactory componentContractPragmaSymbol 
							]) reset.
		
	pragmaCollector announcer when: PragmaAnnouncement send: #receiveMolPragmaAnnouncement: to: self
]

{ #category : #announcements }
MolSystemObserver class >> subscribeSystemAnnouncements [

	| announcer |
	announcer := SystemAnnouncer uniqueInstance weak.
	announcer ifNil: [
		MolUtils log: 'Error on Systems announcements initialization, SystemAnnouncer is nil'.
		^ self 
	].

	"Component events"
	announcer when: ClassAdded send: #receiveClassAdded: to: self.
	announcer when: ClassModificationApplied send: #receiveClassModificationApplied: to: self.

	"Monticello events"
	announcer when: MCVersionLoaderStarted send: #receiveMCVersionLoaderStarted: to: self.
	announcer when: MCVersionLoaderStopped send: #receiveMCVersionLoaderStopped: to: self.
	
	"Iceberg events"
	announcer when: IceAnnouncement send: #receiveIceAnnouncement: to: self.
]

{ #category : #announcements }
MolSystemObserver class >> unsubscribeMolPragmaAnnouncements [

	pragmaCollector ifNotNil: [ :e | e release ].
	pragmaCollector := nil
]

{ #category : #announcements }
MolSystemObserver class >> unsubscribeSystemAnnouncements [

	| announcer |
	announcer := SystemAnnouncer uniqueInstance ifNil: [ ^ self ].
	announcer unsubscribe: self
]
