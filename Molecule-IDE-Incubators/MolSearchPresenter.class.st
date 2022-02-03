"
window spec after click on search in MolActionMenu
"
Class {
	#name : #MolSearchPresenter,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'models',
		'elements',
		'relation',
		'edges',
		'inspectable',
		'popup',
		'droplist',
		'label',
		'legend',
		'componentCanvas',
		'classAugmentedCanvas',
		'filterInputPresenter',
		'listPresenter',
		'updatelabel',
		'toolbar'
	],
	#category : #'Molecule-IDE-Incubators-Windows Spec2'
}

{ #category : #specs }
MolSearchPresenter class >> defaultLayout [
	<spec: #default>
	^ SpBoxLayout newTopToBottom 
		add:#toolbar withConstraints: [ :c | c height: self toolbarHeight ];
		add: (SpBoxLayout newLeftToRight
			add:(SpBoxLayout newTopToBottom
			add:#filterInputPresenter;
			add:#listPresenter height: 130;
			add:#updatelabel withConstraints: [ :c | c padding: 5 ]) 
		) height: 180;
		add: (SpBoxLayout newLeftToRight
		add:#componentCanvas;
		add:#classAugmentedCanvas)
	yourself.
]

{ #category : #specs }
MolSearchPresenter class >> open [
	<script:'self new open'>
	
]

{ #category : #accessing }
MolSearchPresenter >> components [
	^SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ (c allSuperclasses includes: Object) and: [ c isComponentClass ] ] ].
]

{ #category : #initialization }
MolSearchPresenter >> configure: canvas type: aType [
	| icon type |
	"componentHierarchyTitle"
	type := RSLabel new bold
		position: 100@15;
		color: Color black;
		fontSize: 12.
	type isFixed: true.
	
	aType = 'class' 
	ifTrue: [ 
		type text: 'Augmented class Component'.
		self models: SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ (c allSuperclasses includes: Object ) and: [c isComponentClass ]] ].
		models removeAllSuchThat: [ :class | class allSuperclasses includes: MolAbstractComponentImpl ]. ]

	ifFalse:[
		type text: 'Native Component'.
		self models: SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [  (c allSuperclasses includes: MolAbstractComponentImpl ) 
			or: [ c == MolAbstractComponentImpl ] ] ].].

	
	self relation: [ :cls | cls dependentClasses ].
	self elements: models.
	
	canvas addAll: elements.
	canvas add: type.
	
	self edges: RSEdgeBuilder line.
	edges canvas: canvas .
	edges connectToAll: relation.
	
	elements @ RSHighlightable red withEdges.
	
	RSForceBasedLayout on: elements.
	
	inspectable := RSMolEvents new.
	
	icon := RSBitmap new 
		model: 'component'; 
		form: MolIcon moleculeComponent2Icon;
		size: 16.
		
	legend := MolLegend new. 
	legend container: canvas items:{icon} title: '' onDemand: 'Legend' .
	
	elements @ inspectable .
	canvas @ RSCanvasController.
	^canvas
]

{ #category : #initialization }
MolSearchPresenter >> configure: canvas type: aType selected: anItem [
	| component  |
	
	self configure: canvas type: aType.
	
	"find the selected component as a Bitmap"
	component := canvas nodes shapeFromModel: anItem.
	
	"this bitmap change a form to highlight the selected element"
	component form: ((MolIcon moleculeComponent2Icon copy) mapColor: Color white to: Color orange).
	
	
]

{ #category : #initialization }
MolSearchPresenter >> connectPresenters [
|class component |

	super connectPresenters.

	componentCanvas script: [ :canvas | self configure: canvas type: 'component' . ].
	classAugmentedCanvas script: [ :canvas | self configure: canvas type: 'class'. ].
	
	"list of component from existing class"
	class := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [ (c allSuperclasses includes: Object ) and: [c isComponentClass ]] ].
		class removeAllSuchThat: [ :comp | comp allSuperclasses includes: MolAbstractComponentImpl ].
		
	"list of component from component hierarchy"
	component := SystemNavigation default allClasses select: [ :c | 
		        c isTrait not and: [  (c allSuperclasses includes: MolAbstractComponentImpl ) 
			or: [ c == MolAbstractComponentImpl ] ] ].
	
	"when I select an item in a drop list"
	listPresenter whenSelectedDo: [ :item | 
		(class includes: item) "if item is a component from existing class"
		ifTrue: [
			"update the label of selected item"
			self updateLabel: item title: 'class'.
			"the component become orange in the canvas"
			classAugmentedCanvas script:[ :aCanvas|
				self configure: aCanvas type: 'class' selected:item ].
			componentCanvas script:[ :aCanvas|
				self configure: aCanvas type: 'component' ]
			]
		ifFalse: [ 
			self updateLabel: item title: 'component'.
			componentCanvas script:[ :aCanvas|
				self configure: aCanvas type: 'component' selected:item].
				classAugmentedCanvas script:[ :aCanvas|
					self configure: aCanvas type: 'class']
				].
		].
]

{ #category : #accessing }
MolSearchPresenter >> edges: someEdges [
	edges := someEdges.
	edges moveBehind.
	edges borderColor: '80CDC1'.
	edges withBorderAttachPoint.
]

{ #category : #accessing }
MolSearchPresenter >> elements [
	^elements
]

{ #category : #accessing }
MolSearchPresenter >> elements: someElements [
	elements := someElements collect: 
		[ :m | 
		|icon |
		icon := RSBitmap new 
		model:m; 
		form: MolIcon moleculeComponent2Icon;
		size: 10.
		self popup:m.
		icon @ RSDraggableCanvasInteraction @ popup
		 ] as: RSGroup. 
	
	
]

{ #category : #initialization }
MolSearchPresenter >> initializePresenters [
	
	super initializePresenters.
	
	"define canvas"
	componentCanvas := self instantiate: SpRoassalPresenter.
	classAugmentedCanvas := self instantiate: SpRoassalPresenter.
	
	"define label"
	updatelabel := self newLabel.
	
	"define list and filtering input"
	droplist := self instantiate: MolSearchListPresenter.
	filterInputPresenter := droplist filterInputPresenter.
	filterInputPresenter cursorPositionIndex.
	listPresenter := droplist listPresenter.
	
	"define toolbar"
	toolbar := self instantiate: SpToolbarPresenter.
	
	"2 buttons in toolbar (refresh and trash)"
	toolbar 
		add: (SpToolbarButtonPresenter new 
			icon: (self iconNamed: #glamorousRefresh);
			help: 'Clear search';
			"refresh canvas and list"
			action: [ componentCanvas refresh. classAugmentedCanvas refresh. droplist items: self components. ];
			yourself);
		add: (SpToolbarButtonPresenter new
			icon: (self iconNamed: #glamorousGrayCircleEmpty);
			help: 'Clear selection';
			"reset a selection from the list"
			action: [ listPresenter resetListSelection. self updateLabel: listPresenter selectedItem.
				"refresh canvas whithout selection"
				 componentCanvas script:[ :aCanvas|
				self configure: aCanvas type: 'component'.].
			 	 classAugmentedCanvas script:[ :aCanvas|
				self configure: aCanvas type: 'class'.] ];
			yourself).
			
	"add icon in list"
	listPresenter displayIcon: [ :e |
		self flag:'PLA : mettre une icone si composant natif ou pas'.
		self iconNamed: #classIcon. 
	].
	
	"add text to label"
	self updateLabel: listPresenter selectedItem.
	
	"add item to list"
	droplist items: self components.
	

]

{ #category : #initialization }
MolSearchPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	aWindowPresenter title: 'Molecule Search'.
	aWindowPresenter initialExtent: 900 @ 650.
	aWindowPresenter windowIcon: MolIcon moleculeIcon.
]

{ #category : #accessing }
MolSearchPresenter >> models [
	^models 
]

{ #category : #accessing }
MolSearchPresenter >> models: someObjects select: aBlock [
	models := someObjects select: aBlock
	
]

{ #category : #accessing }
MolSearchPresenter >> popup: aComponent [

	| molPopup |
	
	molPopup := MolPopup new.
	popup := RSPopup new.
	molPopup popup: popup title: aComponent.
		
]

{ #category : #accessing }
MolSearchPresenter >> relation: aBlock [
	relation := aBlock
]

{ #category : #initialization }
MolSearchPresenter >> updateLabel: anItem [
	| component consumedEvents producedEvents providedServices usedServices providedParameters usedParameters someInterfaces |
	component := listPresenter selectedItem.
	component isNotNil ifTrue:[
		updatelabel label: 'Selection : ', (component asString).
		component haveComponentType ifTrue: [ 
		component consumedComponentEvents isNotNil 
		ifTrue:[consumedEvents := component consumedComponentEvents size.].
		component producedComponentEvents isNotNil 
		ifTrue:[producedEvents := component producedComponentEvents size.].
		component providedComponentServices isNotNil 
		ifTrue:[providedServices := component providedComponentServices size.].
		component usedComponentServices isNotNil 
		ifTrue:[usedServices := component usedComponentServices size.].
		component providedComponentParameters isNotNil 
		ifTrue:[providedParameters := component providedComponentParameters size.].
		component usedComponentParameters isNotNil 
		ifTrue:[usedParameters := component usedComponentParameters size.].
		someInterfaces := consumedEvents + producedEvents + providedServices + usedServices + providedParameters + usedParameters.
		someInterfaces ~= 0 
		ifTrue: [ updatelabel label: 'Selection : ', (component asString), ' - nb interface : ', someInterfaces asString.]
		ifFalse: [ updatelabel label: 'Selection : ', (component asString) ]
		]
		ifFalse: [ updatelabel label: 'Selection : ', (component asString). ]
	]
	ifFalse: [ updatelabel label: '' ]
]

{ #category : #initialization }
MolSearchPresenter >> updateLabel: anItem title: aTitle [
	| component consumedEvents producedEvents providedServices usedServices providedParameters usedParameters someInterfaces  |
	component := listPresenter selectedItem.
	component isNotNil ifTrue:[
		component haveComponentType ifTrue: [ 
		component consumedComponentEvents isNotNil 
		ifTrue:[consumedEvents := component consumedComponentEvents size.].
		component producedComponentEvents isNotNil 
		ifTrue:[producedEvents := component producedComponentEvents size.].
		component providedComponentServices isNotNil 
		ifTrue:[providedServices := component providedComponentServices size.].
		component usedComponentServices isNotNil 
		ifTrue:[usedServices := component usedComponentServices size.].
		component providedComponentParameters isNotNil 
		ifTrue:[providedParameters := component providedComponentParameters size.].
		component usedComponentParameters isNotNil 
		ifTrue:[usedParameters := component usedComponentParameters size.].
		someInterfaces := consumedEvents + producedEvents + providedServices + usedServices + providedParameters + usedParameters.
		aTitle = 'class' ifTrue: [ 
			someInterfaces ~= 0 
			ifTrue: [ updatelabel label: 'Selection : ', (component asString),
				 '- augmented Class Component - nb interface : ', someInterfaces asString .]
			ifFalse: [ updatelabel label: 'Selection : ', (component asString) , ' - augmented Class Component'.]
			]
		ifFalse: [ 	someInterfaces ~= 0 
			ifTrue: [ updatelabel label: 'Selection : ', (component asString), ' - native Component - nb interface : ', 
				someInterfaces asString.]
			ifFalse: [ updatelabel label: 'Selection : ', (component asString) , ' - native Component'.]
			].
		]
		ifFalse: [ 
			aTitle = 'class'
			ifTrue: [ updatelabel label: 'Selection : ', (component asString), ' - augmented Class Component'.]
			ifFalse: [ updatelabel label: 'Selection : ', (component asString), ' - native Component'.]
		]
	]
	ifFalse: [ updatelabel label: '' ]
]
