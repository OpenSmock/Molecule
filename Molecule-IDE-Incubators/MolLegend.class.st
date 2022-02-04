"
class for the legend
"
Class {
	#name : #MolLegend,
	#superclass : #Object,
	#instVars : [
		'legend'
	],
	#category : #'Molecule-IDE-Incubators-Legend'
}

{ #category : #interface }
MolLegend >> container: aCanvas items: items title: title onDemand: onDemand [
	self legend: RSLegend new.
	legend container: aCanvas.
	legend title: title.
	items do: [ :selector |
		legend text: selector model withShape: selector.
		 ].
	legend onDemand: onDemand.
	legend withFrame.
	^legend build.
]

{ #category : #accessing }
MolLegend >> items: items [
	items do: [ :selector |
		legend text: selector model withShape: selector.
		 ].
]

{ #category : #accessing }
MolLegend >> legend [
	^legend.
]

{ #category : #accessing }
MolLegend >> legend: anObject [
	legend := anObject.
]
