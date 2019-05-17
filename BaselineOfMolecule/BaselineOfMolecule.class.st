"
Core
	Molecule
	
All
	Molecule
	Molecule-Examples
	Molecule-Tests
"
Class {
	#name : #BaselineOfMolecule,
	#superclass : #BaselineOf,
	#category : #BaselineOfMolecule
}

{ #category : #baselines }
BaselineOfMolecule >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [			
			"Packages"
			spec
				package: 'Molecule';
				package: 'Molecule-Examples' with: [ spec requires: #('Molecule') ];
				package: 'Molecule-Tests' with: [ spec requires: #('Molecule') ].
		 ]
]
