"
class for the legend
"
Class {
	#name : #MolLegend,
	#superclass : #Object,
	#category : #'Molecule-IDE-Incubators-Legend'
}

{ #category : #'as yet unclassified' }
MolLegend >> legend: aLegend container: aCanvas items: items title: title onDemand: onDemand [
	aLegend container: aCanvas.
	aLegend title: title.
	items do: [ :selector |
		aLegend text: selector model withShape: selector.
		 ].
	aLegend onDemand: onDemand.
	aLegend withFrame.
	"legend legendDo: [ : border | border border:(RSBorder new color: 'C7EAE5'; width: 0.5); padding: 5. ]."
	^aLegend build.
]
