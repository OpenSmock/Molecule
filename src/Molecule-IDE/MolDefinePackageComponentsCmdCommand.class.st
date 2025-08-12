Class {
	#name : #MolDefinePackageComponentsCmdCommand,
	#superclass : #MolPackagesCmdCommand,
	#category : #'Molecule-IDE-Commands'
}

{ #category : #activation }
MolDefinePackageComponentsCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^ CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserPackageContext
]

{ #category : #private }
MolDefinePackageComponentsCmdCommand >> aboutText [

	^ 'Define all components in the selected packages: force to generate from contract definition'
]

{ #category : #accessing }
MolDefinePackageComponentsCmdCommand >> defaultMenuIconName [

	^ #smallUpdate
]

{ #category : #accessing }
MolDefinePackageComponentsCmdCommand >> defaultMenuItemName [

	^ 'Define Components'
]

{ #category : #accessing }
MolDefinePackageComponentsCmdCommand >> description [

	^ self aboutText
]

{ #category : #execution }
MolDefinePackageComponentsCmdCommand >> execute [

	| result components nbOfDefinedComponents text |
	
	components := (self selectedPackages flatCollect: #classes) select:[ :p | 
		p isComponentClass
	].
	nbOfDefinedComponents := components size.
	
	result := UIManager default 
		confirm: 'Do you want to define all ', nbOfDefinedComponents printString ,' Molecule Component(s) in these packages ?' 
		label: 'Molecule - Define Components confirmation'.
	result ifFalse:[ ^ self ].
	
	components do: [ :c | MolComponentFactory defineComponent: c ].
	
	text := nbOfDefinedComponents = 1
		        ifTrue: [
		        'Define component: ' , components first printString ]
		        ifFalse: [
			        nbOfDefinedComponents asString , ' component'
			        , (nbOfDefinedComponents > 1
					         ifTrue: [ 's' ]
					         ifFalse: [ '' ]) , ' defined' ].

	MolUtils showInformation: text
]
