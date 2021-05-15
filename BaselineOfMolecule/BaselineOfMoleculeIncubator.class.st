Class {
	#name : #BaselineOfMoleculeIncubator,
	#superclass : #BaselineOfMolecule,
	#category : #BaselineOfMolecule
}

{ #category : #baselines }
BaselineOfMoleculeIncubator >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [			
			"Pre and post load scripts"
			spec preLoadDoIt: #'preload:package:'.
			spec postLoadDoIt: #'postload:package:'.
						
			"Packages"
			spec
				package: 'Molecule';
				package: 'Molecule-IDE' with: [ spec requires: #('Molecule') ];
				package: 'Molecule-Examples' with: [ spec requires: #('Molecule') ];
				package: 'Molecule-Tests' with: [ spec requires: #('Molecule') ];
				package: 'Molecule-IDE-Tests' with: [ spec requires: #('Molecule-IDE') ];
				package: 'Molecule-IDE-Incubators' with: [ spec requires: #('Molecule-IDE') ].
		 ]
]
