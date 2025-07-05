Class {
	#name : #BaselineOfMolecule,
	#superclass : #BaselineOf,
	#instVars : [
		'previousDynamicContractUpdateActivated'
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
				
			"Pharo backward compatibility: to preserve running from Pharo 11"
			spec 
				for: #'pharo11.x'
				do:[
					    spec
    						baseline: 'PharoBackwardCompatibility'
    						with: [ spec repository: 'github://labordep/PharoBackwardCompatibility:master/src' ]
				].
		 ]
]

{ #category : #'load scripts' }
BaselineOfMolecule >> postload: loader package: packageSpec [
	"Reload new Molecule tools"

	(Smalltalk globals includesKey: #MolComponentManager) ifFalse:[ ^self ].

	(Smalltalk globals classNamed: #MolComponentManager) cleanUp.
	
	"Rebuild all components"
	MolComponentFactory defineAllComponents.
	
	"Reactive dynamic contract update if necessary"
	(previousDynamicContractUpdateActivated ifNil:[false]) ifFalse:[
		MolComponentFactory default activateDynamicContractUpdate.	
	].
]

{ #category : #'load scripts' }
BaselineOfMolecule >> preload: loader package: packageSpec [
	"If a Molecule component system is running, confirm loading and cleanUp before installation of the new version"
	
	(Smalltalk globals includesKey: #MolComponentManager) ifFalse:[ ^self ].
	
	previousDynamicContractUpdateActivated := false.
	
	(Smalltalk globals classNamed: #MolComponentManager) isRunningComponents ifTrue:[ 
		(Smalltalk ui theme
		proceedIn: Morph new 
		text: 'Warning, you are going to modify Molecule then components are started, do you want to continue ?'
		title: 'Molecule - Loading a baseline') ifFalse:[ 
			self flag:'PLA : How to stop the loading ? For the moment you should close the debug windows opened when Halt is call'.	
			Halt now.
		].
	].
 
	(Smalltalk globals classNamed: #MolComponentManager) cleanUp.
	previousDynamicContractUpdateActivated := MolComponentFactory default isDynamicContractUpdateActivated.
	MolComponentFactory default deactivateDynamicContractUpdate.
]
