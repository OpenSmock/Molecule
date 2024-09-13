Class {
	#name : #MolInterfacesPresenter,
	#superclass : #MolOptionsPresenter,
	#instVars : [
		'selectedInterface',
		'requiredList',
		'offeredList',
		'dropList',
		'servicesProvidedList',
		'eventsConsumedList',
		'parametersUsedList',
		'servicesUsedList',
		'eventsProducedList',
		'parametersProvidedList',
		'listImplementationBoth',
		'eventsConsumed',
		'parametersUsed',
		'servicesUsed',
		'eventsProduced',
		'parametersProvided',
		'servicesProvided',
		'implemList'
	],
	#category : #'Molecule-IDE-Tools'
}

{ #category : #initialization }
MolInterfacesPresenter >> addTrait: trait IfInterfaceCorrespondsIn: interfaceList forList: interfaceForScreenList [
	"adds the interfaces that appear in the relevant parts of the component contract to lists in order to show them after using requiredList and offeredList"

	interfaceList ifNotNil: [
		interfaceList do: [ :interface |
			interface = selectedInterface ifTrue: [
				interfaceForScreenList add: trait ] ] ]
]

{ #category : #adding }
MolInterfacesPresenter >> addTypesInInterfaceList: trait [
	"add a Trait to the lists if it corresponds to a part of their component contract"

	selectedInterface isComponentEvents ifTrue: [
		eventsConsumed := trait allConsumedEvents.
		self
			addTrait: trait
			IfInterfaceCorrespondsIn: eventsConsumed
			forList: eventsConsumedList.

		eventsProduced := trait allProducedEvents.
		self
			addTrait: trait
			IfInterfaceCorrespondsIn: eventsProduced
			forList: eventsProducedList ].

	selectedInterface isComponentParameters ifTrue: [
		parametersUsed := trait allUsedParameters.
		self
			addTrait: trait
			IfInterfaceCorrespondsIn: parametersUsed
			forList: parametersUsedList.

		parametersProvided := trait allProvidedParameters.
		self
			addTrait: trait
			IfInterfaceCorrespondsIn: parametersProvided
			forList: parametersProvidedList ].

	selectedInterface isComponentServices ifTrue: [
		servicesUsed := trait allUsedServices.
		self
			addTrait: trait
			IfInterfaceCorrespondsIn: servicesUsed
			forList: servicesUsedList.

		servicesProvided := trait allProvidedServices.
		self
			addTrait: trait
			IfInterfaceCorrespondsIn: servicesProvided
			forList: servicesProvidedList ]
]

{ #category : #adding }
MolInterfacesPresenter >> addTypesInInterfaceLists [

	selectedInterface ifNil: [ ^ self ].
	
	(MolUtils requiredTypes: selectedInterface) do: [ :trait |
		self addTypesInInterfaceList: trait ].

	(MolUtils offeredTypes: selectedInterface) do: [ :trait |
		self addTypesInInterfaceList: trait ]
]

{ #category : #private }
MolInterfacesPresenter >> andMode [
	"if a Type appears in both columns (is both required and offered), show it in both columns"
	"doesn't show it in either if it only appears once"

	self emptyLists.

	self addTypesInInterfaceLists.

	self require: eventsConsumedList andOffer: eventsProducedList.
	self require: parametersUsedList andOffer: parametersProvidedList.
	self require: servicesUsedList andOffer: servicesProvidedList.

	self fillRequiredAndOfferedLists.

	self applyFilter
]

{ #category : #initialization }
MolInterfacesPresenter >> applyFilter [
	"used when changing boolean operator modes in order to conserve the filters typed, for both the required and offered interfaces"

	| requiredListFilter offeredListFilter |
	requiredList ifNotNil: [
		requiredListFilter := requiredList filterText.
		offeredListFilter := offeredList filterText.

		requiredList applyFilter: requiredListFilter.
		offeredList applyFilter: offeredListFilter ]
]

{ #category : #initialization }
MolInterfacesPresenter >> browseLastSelectedElement [
	"the Browse button always browses the last selected Trait, no matter in which list it is. However, selecting an element in a list, selecting another element in the other list then selecting again the first element opens the one in the other list since the selection of the first list isn't emptied. This method is here to remedy to this problem"

	"see https://github.com/OpenSmock/Molecule/pull/168#issuecomment-2020688480"

	requiredList whenSelectionChangedDo: [ offeredList selectItem: nil ].
	offeredList whenSelectionChangedDo: [ requiredList selectItem: nil ]
]

{ #category : #initialization }
MolInterfacesPresenter >> buttonBrowseAction [
	"an implementation needs to be selected in order to browse it. The last selected one (for both lists) being the one browsed"

	| item |
	item := implementationList selectedItem.
	item ifNotNil: [ item browse ]
]

{ #category : #initialization }
MolInterfacesPresenter >> connectPresenters [
	"enables the Browse button if a Type is selected, disables it if another mode is chosen since the lists are reset and the selection could point to nothing in particular"

	dropList whenSelectionChangedDo: [ buttonBrowse disable ].
	
	self browseLastSelectedElement.

	self enableBrowseButton: requiredList.
	self enableBrowseButton: offeredList
]

{ #category : #initialization }
MolInterfacesPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: 'Component Types which are using this interface:'
		  expand: false;
		  add: dropList expand: false;
		  add: (SpBoxLayout newLeftToRight
				   add: (SpBoxLayout newVertical
						    add: 'Required' expand: false;
						    add: requiredList;
						    yourself);
				   add: SpBoxLayout newLeftToRight width: 5 yourself;
				   add: (SpBoxLayout newVertical
						    add: 'Offered' expand: false;
						    add: offeredList;
						    yourself);
				   yourself);
		  addLast: actionBar;
		  yourself
]

{ #category : #initialization }
MolInterfacesPresenter >> dropList [
	"used for test purposes"

	^ dropList
]

{ #category : #initialization }
MolInterfacesPresenter >> emptyLists [
	"since the implementations change when switching from one boolean operator to another, the lists of implementations need to be reset"

	"is also used to initialize them since this method is called at the start of required[And/Or/Xor]OfferedMode"

	eventsConsumedList := OrderedCollection new.
	parametersUsedList := OrderedCollection new.
	servicesUsedList := OrderedCollection new.

	eventsProducedList := OrderedCollection new.
	parametersProvidedList := OrderedCollection new.
	servicesProvidedList := OrderedCollection new.

	listImplementationBoth := OrderedCollection new
]

{ #category : #initialization }
MolInterfacesPresenter >> enableBrowseButton: listOnScreen [
	"determines which list was the last one selected, necessary for using the Browse button"

	listOnScreen whenSelectionChangedDo: [
		implementationList := listOnScreen.
		listOnScreen selectedItem ifNotNil: [ buttonBrowse enable ] ]
]

{ #category : #private }
MolInterfacesPresenter >> fillRequiredAndOfferedLists [
	"used for the and mode"

	requiredList items: listImplementationBoth.
	offeredList items: listImplementationBoth
]

{ #category : #initialization }
MolInterfacesPresenter >> initializePresenters [

	"Required OR Offered selected by default in the drop down list"

	super initializePresenters.

		"set to a placeholder value since the name of the interface is given after in execute: in the contextual menu side of things (MolInspectInterfaceImplementationsCmdCommand)"
	selectedInterface := nil.

	eventsConsumedList := OrderedCollection new.
	parametersUsedList := OrderedCollection new.
	servicesUsedList := OrderedCollection new.

	eventsProducedList := OrderedCollection new.
	parametersProvidedList := OrderedCollection new.
	servicesProvidedList := OrderedCollection new.

	"drop list, no width property"
	dropList := self newDropList
		            help: 'Component Types which are using this interface:';
		            addItemLabeled: 'Required and/or Offered'
		            do: [ self orMode ];
		            addItemLabeled: 'Required and Offered'
		            do: [ self andMode ];
		            addItemLabeled: 'Required or Offered (XOR)'
		            do: [ self xorMode ].

	requiredList := MolSpFilteringListDoubleClickPresenter new.
	requiredList
		displayIcon: [ :elem | self iconNamed: elem systemIconName ];
		contextMenu: [ self listMenu ].

	offeredList := MolSpFilteringListDoubleClickPresenter new.
	offeredList
		displayIcon: [ :elem | self iconNamed: elem systemIconName ];
		contextMenu: [ self listMenu ]
]

{ #category : #initialization }
MolInterfacesPresenter >> interface: anInterface [
	"when an interface is given, loads the filtering lists"

	"only one interface can be selected at a time"

	selectedInterface := anInterface.
	implemList := self listImplementations: anInterface.

	self orMode
]

{ #category : #initialization }
MolInterfacesPresenter >> interfaceListAssignment: interfaceList for: listOnScreen [
	"adds the Types to a list if they are required or offered by the selected interface"

	listOnScreen ifNotNil: [
		interfaceList = OrderedCollection new ifFalse: [
			listOnScreen items: interfaceList ] ]
]

{ #category : #initialization }
MolInterfacesPresenter >> listMenu [

	^ self newMenu addItem: [ :item |
		  item
			  name: 'See Component Implementations';
			  icon: (self iconNamed: #package);
			  help: 'Shows implementations of this Molecule Type';
			  action: [ self seeComponentImplementations ] ]
]

{ #category : #initialization }
MolInterfacesPresenter >> offeredList [
	"used for test purposes"

	^ offeredList
]

{ #category : #private }
MolInterfacesPresenter >> orMode [
	"if an implementation requires or provides the selected interface, make it appear in the correct column"

	"is selected by default"

	self emptyLists.

	self addTypesInInterfaceLists.

	self requireOrOffer.

	self applyFilter
]

{ #category : #private }
MolInterfacesPresenter >> require: listRequired andOffer: listOffered [
		"adds the items in the lists shown on screen if the interface is both required and offered by an implementation"

	listRequired do: [ :interfaceRequired |
		listOffered do: [ :interfaceOffered |
			interfaceRequired = interfaceOffered ifTrue: [
				listImplementationBoth add: interfaceRequired ] ] ]
]

{ #category : #private }
MolInterfacesPresenter >> require: listRequired xorOffer: listOffered [
	"removes the items in the lists shown on screen if the interface is both required and offered by an implementation"

	listRequired do: [ :interfaceRequired |
		listOffered do: [ :interfaceOffered |
			interfaceRequired = interfaceOffered ifTrue: [
				listRequired remove: interfaceRequired.
				listOffered remove: interfaceRequired ] ] ]
]

{ #category : #private }
MolInterfacesPresenter >> requireOrOffer [
	"adds the items in the lists shown on screen if the interface is required or offered by a Type"

	self interfaceListAssignment: eventsConsumedList for: requiredList.
	self interfaceListAssignment: parametersUsedList for: requiredList.
	self interfaceListAssignment: servicesUsedList for: requiredList.

	self interfaceListAssignment: eventsProducedList for: offeredList.
	self interfaceListAssignment: parametersProvidedList for: offeredList.
	self interfaceListAssignment: servicesProvidedList for: offeredList
]

{ #category : #initialization }
MolInterfacesPresenter >> requiredList [
	"used for test purposes"

	^ requiredList
]

{ #category : #initialization }
MolInterfacesPresenter >> seeComponentImplementations [
	"code based on the execute method in MolInspectTypeImplementationsCmdCommand without the multiple selection part since multiple elements can't be chosen at the same time in requiredList and offeredList"

	| selectedType implem |
	selectedType := implementationList selectedItem.
	implem := MolImplementationsPresenter new.

	selectedType isComponentType ifTrue: [
		implem type: selectedType.
		implem open ]
]

{ #category : #initialization }
MolInterfacesPresenter >> title [

	| typeName |
	selectedInterface ifNil: [ ^ 'No Molecule interface' ].

	typeName := 'events'.
	selectedInterface isComponentParameters ifTrue: [
		typeName := 'parameters' ].
	selectedInterface isComponentServices ifTrue: [
		typeName := 'services' ].

	^ selectedInterface asString , ' ' , typeName
]

{ #category : #private }
MolInterfacesPresenter >> xorMode [
	"boolean operator equivalent to OR minus AND, show a Type only if it exists and doesn't appear in both columns (requires or offers the interface, but not both)"

	self emptyLists.

	"adds the interfaces"
	self addTypesInInterfaceLists.

	"removes implementations that both require and offer this interface"
	self require: eventsConsumedList xorOffer: eventsProducedList.
	self require: servicesUsedList xorOffer: servicesProvidedList.
	self require: parametersUsedList xorOffer: parametersProvidedList.

	"adds the interfaces in requiredList and offeredList"
	self requireOrOffer.

	self applyFilter
]
