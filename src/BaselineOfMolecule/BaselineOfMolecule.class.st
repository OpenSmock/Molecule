Class {
	#name : #BaselineOfMolecule,
	#superclass : #BaselineOf,
	#instVars : [
		'isPreviouslyAutoComponentTypeUpdateActivated'
	],
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

	| componentManagerClass |
	componentManagerClass := RGClassDefinition named: #MolComponentManager.
	componentManagerClass isDefined ifFalse:[ ^ self ].
	componentManagerClass realClass cleanUp.

	"Define all components after loading"
	MolComponentFactory defineAllComponents.
	MolSystemObserver active.
	
	"Active auto ComponentType update if necessary"
	(isPreviouslyAutoComponentTypeUpdateActivated ifNil:[ false ]) ifFalse:[
		MolComponentFactory default activateDynamicContractUpdate.	
	].
]

{ #category : #'load scripts' }
BaselineOfMolecule >> preload: loader package: packageSpec [
	"If a Molecule component system is running, confirm loading and cleanUp before installation of the new version"
	
	| componentManagerClass |
	componentManagerClass := RGClassDefinition named: #MolComponentManager.
	componentManagerClass isDefined ifFalse:[ ^ self ].
	
	isPreviouslyAutoComponentTypeUpdateActivated := false.
	componentManagerClass realClass isRunningComponents ifTrue:[ 
		(Smalltalk ui theme
		proceedIn: Morph new 
		text: 'Warning, you are going to modify Molecule then components are started, do you want to continue ?'
		title: 'Molecule - Loading a baseline') ifFalse:[ 
			self flag:'PLA : How to stop the loading ? For the moment you should close the debug windows opened when Halt is call'.	
			Halt now.
		].
	].
 
	componentManagerClass realClass cleanUp.
	isPreviouslyAutoComponentTypeUpdateActivated := MolComponentFactory default isDynamicContractUpdateActivated.
	MolComponentFactory default deactivateDynamicContractUpdate.
	MolSystemObserver deactive.
]
