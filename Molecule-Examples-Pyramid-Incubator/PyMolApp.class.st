Class {
	#name : #PyMolApp,
	#superclass : #BlElement,
	#instVars : [
		'map',
		'switch'
	],
	#category : #'Molecule-Examples-Pyramid-Incubator'
}

{ #category : #'instance creation' }
PyMolApp class >> open [

	<script>
	| element |
	element := self new.
	element open
]

{ #category : #initialization }
PyMolApp >> initialize [

	| rope1 rope2 label1 label2 |
	super initialize.
	self size: 400 @ 470.

	switch := PyMolSwitch new.
	switch position: 152.5 @ 420.
	switch whenOffDo: [
		MolGPSDataImpl stop.
		MolGPSHardware start ].
	switch whenOnDo: [
		MolGPSHardware stop.
		MolGPSDataImpl start ].

	MolGPSHardware start.
	PyMolMap start.
	map := MolUtils instanceOf: PyMolMap.

	rope1 := 'Accurate GPS' asRopedText.
	rope1 attribute: (BlFontSizeAttribute size: 20).
	label1 := rope1 asElement.
	label1 position: 10 @ 425.

	rope2 := 'Inaccurate GPS' asRopedText.
	rope2 attribute: (BlFontSizeAttribute size: 20).
	label2 := rope2 asElement.
	label2 position: 260 @ 425.

	self addChild: map.
	self addChild: switch.
	self addChild: label1.
	self addChild: label2
]

{ #category : #'as yet unclassified' }
PyMolApp >> open [

	| space |
	space := BlSpace new
		         extent: 400 @ 470;
		         yourself.
		
	space root addChild: self.
		
	space
		when: BlSpaceClosedEvent
		do: [ :evt | MolComponentManager cleanUp ].
	space when: BlKeyDownEvent do: [ :evt |
		evt key = KeyboardKey F12 ifTrue: [
			(self canPerform: #pyramidOpenInEditor) ifTrue: [
				self pyramidOpenInEditor ] ] ].

	space enqueueTask: (BlTaskAction new
			 action: [ space center ];
			 yourself).

	space show
]
