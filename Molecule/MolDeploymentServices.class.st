"
I am responsible for the deployment of components in a system.  A component not deployed can not be used. 

See examples of my use in Tests and Examples packages.
"
Class {
	#name : #MolDeploymentServices,
	#superclass : #Object,
	#category : #'Molecule-Core'
}

{ #category : #deployment }
MolDeploymentServices >> deployComponentImplementation: aComponentClass [

	(aComponentClass isComponent) ifFalse: [ ^ self error: '[Molecule] Cannot allow no Component class deployment.' ].
	(aComponentClass haveComponentType) ifFalse: [ ^ self error: '[Molecule] Cannot allow no Typed Component class deployment' ].
	
	MolComponentManager default homeServices addDeployedComponent: aComponentClass
]

{ #category : #deployment }
MolDeploymentServices >> isDeployedComponentImplementation: aComponentClass [

	aComponentClass isTrait ifTrue: [ ^ self error: 'No component type allowed, deploy implementations' ].
	^MolComponentManager default homeServices isDeployedComponent: aComponentClass
]

{ #category : #deployment }
MolDeploymentServices >> undeployComponentImplementation: aComponentClass [ 

	MolComponentManager default homeServices removeDeployedComponent: aComponentClass
]
