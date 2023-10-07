"
I am an example of table which provide services to all its users. My services are defined with trait MyTableServices.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyTableComponentImpl,
	#superclass : #Object,
	#traits : 'MolMyTableComponent + MolComponentImpl + MolMyTableServices',
	#classTraits : 'MolMyTableComponent classTrait + MolComponentImpl classTrait + MolMyTableServices classTrait',
	#instVars : [
		'tableContent',
		'columnNames'
	],
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #accessing }
MolMyTableComponentImpl >> addRow: aName attribute1: aNumber1 attribute2: aNumber2 [

	| collection |
	collection := OrderedCollection new
		add: aName;
		add: aNumber1;
		add: aNumber2.
	tableContent add: collection.
		
]

{ #category : #'life cycle' }
MolMyTableComponentImpl >> componentInitialize [
	"here write the code corresponding to component initialisation phase"
	
	tableContent := OrderedCollection new.
	self addRow: 'Raw1' attribute1: 3 attribute2: 0.254.
	self addRow: 'Raw2' attribute1: 12 attribute2: 3.219.
	self addRow: 'Raw3' attribute1: 5 attribute2: 1.587.
]

{ #category : #services }
MolMyTableComponentImpl >> getContent [

	^ tableContent
]

{ #category : #services }
MolMyTableComponentImpl >> getContentAtRow: aRowNumber [

	aRowNumber isInteger ifFalse: [ self error: 'Argument must be an integer.' ].
	^ tableContent at: aRowNumber
]

{ #category : #services }
MolMyTableComponentImpl >> nbOfRows [

	^ tableContent size
]
