Class {
	#name : #MolCodeMetricsCmdCommand,
	#superclass : #MolPackagesCmdCommand,
	#category : #'Molecule-IDE-Incubator-Menus'
}

{ #category : #activation }
MolCodeMetricsCmdCommand class >> browserMenuActivation [
	<classAnnotation>
	^ CmdContextMenuActivation byItemOf: MolCmdMenuGroup for: ClyFullBrowserPackageContext
]

{ #category : #private }
MolCodeMetricsCmdCommand >> aboutText [

	^ 'Molecule metrics'
]

{ #category : #accessing }
MolCodeMetricsCmdCommand >> defaultMenuIconName [

	^'smallLanguage'
]

{ #category : #accessing }
MolCodeMetricsCmdCommand >> defaultMenuItemName [

	^ 'Metrics'
]

{ #category : #accessing }
MolCodeMetricsCmdCommand >> execute [
	| presenter stream |
	presenter := SpTextPresenter new.
	
	stream := ReadWriteStream on: String new.
	stream 
		nextPutAll: 'Nb packages: '; 
		nextPutAll: self selectedPackages size asString; 
		cr; cr.
	self metricsForSelectedPackagesClasses: stream.
	
	presenter text: stream contents.
	
	presenter open.
	presenter withWindowDo: [ :w | w title: self titleForSelectedItems; aboutText: self aboutText ]
]

{ #category : #private }
MolCodeMetricsCmdCommand >> metricsForSelectedPackagesClasses: aStream [

	"Number of classes and traits"
	| nbClasses nbTraits nbComponents nbTypes nbServicesInterface nbEventsInterface nbParametersInterface |
	nbClasses := (self selectedPackagesClasses select:[ :c | c isClass ]) size.
	nbTraits := (self selectedPackagesClasses select:[ :c | c isTrait ]) size.

	"Number of components class"
	nbComponents := (self selectedPackagesClasses select:[ :c | c isComponentClass ]) size.	
	
	"Number of Component Types and contract interfaces"
	nbTypes := (self selectedPackagesClasses select:[ :c | c isTrait and:[ c isComponentType ] ]) size.
	nbServicesInterface := (self selectedPackagesClasses select:[ :c | c isTrait and:[ c isComponentServices ] ]) size.
	nbEventsInterface := (self selectedPackagesClasses select:[ :c | c isTrait and:[ c isComponentEvents ] ]) size.
	nbParametersInterface := (self selectedPackagesClasses select:[ :c | c isTrait and:[ c isComponentParameters ] ]) size.

	aStream nextPutAll: '### General metrics'; cr.
	aStream nextPutAll: (nbComponents * 100 / nbClasses) rounded asString, '% of classes are components'; cr.
	nbTraits > 0 ifTrue:[aStream nextPutAll: ((nbTypes + nbServicesInterface + nbEventsInterface + nbParametersInterface) * 100 / nbTraits) rounded asString, '% of traits are component contract'; cr].
	aStream cr.

	aStream nextPutAll: '### Molecule entities'; cr.
	aStream nextPutAll: 'Nb of components: ', nbComponents asString; cr.
	aStream nextPutAll: 'Nb of types interfaces: ', nbTypes asString; cr.
	aStream nextPutAll: 'Nb of services interfaces: ', nbServicesInterface asString; cr.
	aStream nextPutAll: 'Nb of events interfaces: ', nbEventsInterface asString; cr.
	aStream nextPutAll: 'Nb of parameters interfaces: ', nbParametersInterface asString; cr.
	aStream nextPutAll: 'Total: ', (nbComponents + nbTypes + nbServicesInterface + nbEventsInterface + nbParametersInterface) asString; cr.
	aStream cr.

	aStream nextPutAll: '### Standard entities'; cr.
	aStream nextPutAll: 'Nb of classes: ', nbClasses asString; cr.
	aStream nextPutAll: 'Nb of traits: ', nbTraits asString; cr.
	aStream nextPutAll: 'Total: ', (nbClasses + nbTraits) asString; cr.
	
	
]

{ #category : #private }
MolCodeMetricsCmdCommand >> titleForSelectedItems [

	| nbPackages |
	nbPackages := selectedItems size.
	^ 'Molecule metrics for ' , nbPackages asString , ' package' , (nbPackages > 0 ifTrue:[ 's' ] ifFalse: [ '' ]).
]
