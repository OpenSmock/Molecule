Class {
	#name : #MolLegendTest,
	#superclass : #TestCase,
	#instVars : [
		'legend'
	],
	#category : #'Molecule-IDE-Incubators-Tests-Cases'
}

{ #category : #running }
MolLegendTest >> setUp [
	super setUp.
	legend := MolLegend new.
	"Put here a common initialization logic for tests"
]

{ #category : #tests }
MolLegendTest >> testContainerItemsTitleOnDemand [

	|  label ellipse canvas |
	label := RSLabel new model: 'label'.
	ellipse := RSEllipse new model: 'ellipse'.
	
	canvas := RSCanvas new.
	canvas @ RSCanvasController .
	
	self assert: (legend container: canvas items: { label. ellipse } title: 'test' onDemand: 'Test legend') equals: legend legend build.
]

{ #category : #tests }
MolLegendTest >> testItems [

	|  label ellipse |
	label := RSLabel new model: 'label'.
	ellipse := RSEllipse new model: 'ellipse'.
	
	legend legend: RSLegend new.
	self assert: (legend items: { label. ellipse }) equals: legend.
]
