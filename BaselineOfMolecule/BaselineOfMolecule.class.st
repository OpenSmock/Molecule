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
			"Pre and post load scripts"
			spec preLoadDoIt: #'preload:package:'.
			spec postLoadDoIt: #'postload:package:'.
						
			"Packages"
			spec
				package: 'Molecule';
				package: 'Molecule-IDE' with: [ spec requires: #('Molecule') ];
				package: 'Molecule-Examples' with: [ spec requires: #('Molecule') ];
				package: 'Molecule-Tests' with: [ spec requires: #('Molecule') ];
				package: 'Molecule-IDE-Tests' with: [ spec requires: #('Molecule-IDE') ].
		 ]
]

{ #category : #'load scripts' }
BaselineOfMolecule >> postload: loader package: packageSpec [
	"Reload new Molecule tools"

	(Smalltalk includesKey: #MolComponentManager) ifFalse:[ ^self ].
	(Smalltalk classNamed: #MolComponentManager) cleanUp
]

{ #category : #'load scripts' }
BaselineOfMolecule >> preload: loader package: packageSpec [
	"If a Molecule component system is running, confirm loading and cleanUp before installation of the new version"
	
	(Smalltalk includesKey: #MolComponentManager) ifFalse:[ ^self ].
	(Smalltalk classNamed: #MolComponentManager) isRunningComponents ifTrue:[ 
		(UITheme current
		proceedIn: Morph new 
		text: 'Warning, you are going to modify Molecule then components are started, do you want to continue ?'
		title: 'Molecule - Loading a baseline') ifFalse:[ "Stop loading" Halt now ].
	].

	(Smalltalk classNamed: #MolComponentManager) cleanUp.	
	(Smalltalk classNamed: #MolComponentFactory) cleanUp.
]
