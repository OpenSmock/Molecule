Class {
	#name : 'MolSourceCodeMetrics',
	#superclass : 'Object',
	#instVars : [
		'classes'
	],
	#category : 'Molecule-IDE-Tools',
	#package : 'Molecule-IDE',
	#tag : 'Tools'
}

{ #category : 'constructor' }
MolSourceCodeMetrics class >> classes: aListOfClasses [

	^ self new classes: aListOfClasses; yourself
]

{ #category : 'accessing' }
MolSourceCodeMetrics >> classes [

	^ classes ifNil:[ classes := OrderedCollection new ]
]

{ #category : 'accessing' }
MolSourceCodeMetrics >> classes: anObject [

	classes := anObject
]

{ #category : 'accessing' }
MolSourceCodeMetrics >> componentClasses [

	^ self classes select: [ :c | c isComponentClass ]
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbAugmentedClassAsComponents [

	^ (self componentClasses reject: [ :comp | comp allSuperclasses includes: MolAbstractComponentImpl ]) size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbClasseMethods [

	| nbClasseMethods |
	nbClasseMethods := 0.
	(self classes collect:[ :c | c class numberOfMethods ]) do:[ :e | nbClasseMethods := nbClasseMethods + e ].
	^ nbClasseMethods
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbClasses [

	^ (self classes select: [ :c | c isClass ]) size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbComponentTypes [

	^ (self classes select:[ :c | c isTrait and:[ c isComponentType ] ]) size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbComponents [

	^ self componentClasses size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbEventsInterfaces [

	^ (self classes select:[ :c | c isTrait and:[ c isComponentEvents ] ]) size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbInstanceMethods [

	| nbInstanceMethods |
	nbInstanceMethods := 0.
	(self classes collect: [ :c | c numberOfMethods ]) do: [ :e |	nbInstanceMethods := nbInstanceMethods + e ].
	^ nbInstanceMethods
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbNativeComponents [

	^ (self componentClasses select: [ :comp | comp allSuperclasses includes: MolAbstractComponentImpl ]) size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbParametersInterfaces [

	^ (self classes select:[ :c | c isTrait and:[ c isComponentParameters ] ]) size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbServicesInterfaces [

	^ (self classes select:[ :c | c isTrait and:[ c isComponentServices ] ]) size
]

{ #category : 'testing' }
MolSourceCodeMetrics >> nbTraits [

	^ (self classes select: [ :c | c isTrait ]) size
]

{ #category : 'printing' }
MolSourceCodeMetrics >> printMetrics [

	^ self printString
]

{ #category : 'printing' }
MolSourceCodeMetrics >> printOn: aStream [
	"Print metrics on a Stream"

	| nbClasses nbTraits nbComponents nbTypes nbServicesInterface nbEventsInterface nbParametersInterface nbInstanceMethods nbClasseMethods nbOfNativeComponents nbOfAugmentedClassAsComponents |

	self classes ifEmpty: [ ^ super printOn: aStream ].

	nbClasses := self nbClasses.
	nbTraits := self nbTraits.
	nbInstanceMethods := self nbInstanceMethods.
	nbClasseMethods := self nbClasseMethods.
	nbComponents := self nbComponents.
	nbOfNativeComponents := self nbNativeComponents.
	nbOfAugmentedClassAsComponents := self nbAugmentedClassAsComponents.
	nbTypes := self nbComponentTypes.
	nbServicesInterface := self nbServicesInterfaces.
	nbEventsInterface := self nbEventsInterfaces.
	nbParametersInterface := self nbParametersInterfaces.

	aStream nextPutAll: '### Global metrics'; cr.
	aStream nextPutAll: ((nbComponents * 100 / nbClasses) rounded) asString, '% of classes are components'; cr.
	nbTraits > 0 ifTrue:[
		aStream nextPutAll: (((nbTypes + nbServicesInterface + nbEventsInterface + nbParametersInterface) * 100 / nbTraits) rounded) asString, '% of traits are component contract'; cr
	].
	aStream nextPutAll: 'Nb of classes: ', nbClasses asString; cr.
	aStream nextPutAll: 'Nb of traits: ', nbTraits asString; cr.
	aStream nextPutAll: 'Total: ', (nbClasses + nbTraits) asString; cr.
	aStream cr.

	aStream nextPutAll: 'Nb of methods: ', nbInstanceMethods asString; cr.
	aStream nextPutAll: 'Nb of class methods: ', nbClasseMethods asString; cr.
	aStream cr.

	aStream nextPutAll: '### Molecule entities'; cr.
	aStream nextPutAll: 'Nb of components: ', nbComponents asString; cr.
	
	nbComponents > 0 ifTrue:[
		aStream nextPutAll: 'Nb of native components: ', nbOfNativeComponents asString, ' (', (nbOfNativeComponents * 100 / nbComponents) rounded asString , '%)'; cr.
		aStream nextPutAll: 'Nb of augmented classes into components: ', nbOfAugmentedClassAsComponents asString, ' (', (nbOfAugmentedClassAsComponents * 100 / nbComponents) rounded asString , '%)'; cr.
	].
	aStream cr.
	
	aStream nextPutAll: 'Nb of types interfaces: ', nbTypes asString; cr.
	aStream nextPutAll: 'Nb of services interfaces: ', nbServicesInterface asString; cr.
	aStream nextPutAll: 'Nb of events interfaces: ', nbEventsInterface asString; cr.
	aStream nextPutAll: 'Nb of parameters interfaces: ', nbParametersInterface asString; cr.
	aStream nextPutAll: 'Total: ', (nbComponents + nbTypes + nbServicesInterface + nbEventsInterface + nbParametersInterface) asString; cr.
	aStream cr.

	aStream nextPutAll: '### No Molecule entities'; cr.
	aStream nextPutAll: 'Nb of classes: ', (nbClasses - nbComponents) asString; cr.
	aStream nextPutAll: 'Nb of traits: ', (nbTraits - nbTypes - nbServicesInterface - nbEventsInterface - nbParametersInterface) asString; cr.
	aStream nextPutAll: 'Total: ', ((nbClasses - nbComponents) + (nbTraits - nbTypes - nbServicesInterface - nbEventsInterface - nbParametersInterface)) asString; cr.
	
]
