Class {
	#name : #MolCodeMetricsCmdCommand,
	#superclass : #MolPackagesCmdCommand,
	#category : #'Molecule-IDE-Commands'
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

	^ #smallLanguage
]

{ #category : #accessing }
MolCodeMetricsCmdCommand >> defaultMenuItemName [

	^ 'Metrics'
]

{ #category : #accessing }
MolCodeMetricsCmdCommand >> description [

	^'Display metrics about Molecule entities from selected packages'
]

{ #category : #execution }
MolCodeMetricsCmdCommand >> execute [

	| presenter stream metrics |
	presenter := SpTextPresenter new.

	stream := ReadWriteStream on: String new.
	stream
		nextPutAll: 'Nb packages: ';
		nextPutAll: self selectedPackages size asString;
		cr;
		cr.

	metrics := MolSourceCodeMetrics classes: (self selectedPackages flatCollect: #classes).
	metrics printOn: stream.

	presenter text: stream contents.

	presenter open.
	presenter withWindowDo: [ :w |
		w
			title: self titleForSelectedItems;
			aboutText: self aboutText ]
]

{ #category : #private }
MolCodeMetricsCmdCommand >> titleForSelectedItems [

	| nbPackages |
	nbPackages := self selectedPackages size.
	^ 'Molecule metrics for <1p> package<2?s:>'
		  expandMacrosWith: nbPackages
		  with: nbPackages > 1
]
