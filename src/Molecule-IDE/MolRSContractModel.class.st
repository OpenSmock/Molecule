"
I am used as a model for the Roassal3 inspection add-on (see: `MolComponentToRoassal`).

I sort the different contracts (services, events, parameters).
I contain:
- the `#component`: the `MolComponentImpl` of the modelized component.
- the `#eventClass`: the class of the modelized event.
- the `#name`: the name of the component if the model is source, or the name of the targeted component if the model is target.
- the `#color`: the `Color` of the event on the Roassal canvas (the colors are defined in `MolComponentToRoassal`).
- the `#rsCornerRadius`: the `RSCornerRadius` object to shape the Roassal element (right for source, left for target).
"
Class {
	#name : #MolRSContractModel,
	#superclass : #Object,
	#instVars : [
		'component',
		'name',
		'eventClass'
	],
	#category : #'Molecule-IDE-Inspectors'
}

{ #category : #testing }
MolRSContractModel class >> isAbstract [

	^ self == MolRSContractModel
]

{ #category : #comparing }
MolRSContractModel >> <= aMolRSContractModel [

	^ self eventClass name < aMolRSContractModel eventClass name
]

{ #category : #adding }
MolRSContractModel >> addBreakpointFor: aSelector [

	self shouldBreakOnCall
		ifTrue: [ self breakOnceOn: aSelector ]
		ifFalse: [ self breakOnceOnBeforeSend: aSelector ]
]

{ #category : #debug }
MolRSContractModel >> breakOnceOn: aSelector [

	| method breakpoint |
	method := self component class lookupSelector: aSelector.
	breakpoint := BreakDebugPoint new.
	breakpoint node: method ast.
	breakpoint targetInstance: self component.

	DebugPointManager
		installDebugPoint: breakpoint
		withBehaviors: { OnceBehavior }.
	^ breakpoint
]

{ #category : #'as yet unclassified' }
MolRSContractModel >> breakOnceOnBeforeSend: aSelector [

	| allSenders allASTSenderNodes |
	allSenders := aSelector senders select: [ :method |
		              method methodClass isComponentClass ].
	allASTSenderNodes := allSenders flatCollect: [ :method |
		                     method ast sendNodes select: [ :node |
			                     node selector = aSelector ] ].
	allASTSenderNodes do: [ :node |
		| breakpoint |
		node methodNode methodClass = self component class ifTrue: [
			breakpoint := BreakDebugPoint new.
			breakpoint node: node.
			breakpoint targetInstance: self component.

			DebugPointManager
				installDebugPoint: breakpoint
				withBehaviors: { OnceBehavior } ] ]
]

{ #category : #'as yet unclassified' }
MolRSContractModel >> breakpointLabelFor: aSelector [

	self shouldBreakOnCall ifTrue: [ ^ 'Halt once on #' , aSelector ]
	ifFalse: [ ^ 'Halt once before send #' , aSelector ]
]

{ #category : #accessing }
MolRSContractModel >> component [

	^ component
]

{ #category : #accessing }
MolRSContractModel >> component: anObject [

	component := anObject
]

{ #category : #accessing }
MolRSContractModel >> eventClass [

	^ eventClass
]

{ #category : #accessing }
MolRSContractModel >> eventClass: anObject [

	eventClass := anObject
]

{ #category : #testing }
MolRSContractModel >> isContractSource [

	^ self explicitRequirement
]

{ #category : #accessing }
MolRSContractModel >> name [

	^ name
]

{ #category : #accessing }
MolRSContractModel >> name: anObject [

	name := anObject
]

{ #category : #asserting }
MolRSContractModel >> shouldBreakOnCall [

	^ self explicitRequirement
]

{ #category : #'as yet unclassified' }
MolRSContractModel >> showContractUsers [

	MolInterfacesPresenter new
		interface: self eventClass;
		open
]
