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
	(aComponentClass isNil or:[aComponentClass isClass not or:[aComponentClass isComponentClass not]]) ifTrue: [ ^ NotAComponentClassError signal: 'Cannot allow no Component class deployment'. ].
	(aComponentClass haveComponentType) ifFalse: [ ^ NotATypedComponentClassError signal: 'Cannot allow no Typed Component class deployment' ].
	
	MolComponentManager default homeServices addDeployedComponent: aComponentClass
]

{ #category : #deployment }
MolDeploymentServices >> isDeployedComponentImplementation: aComponentClass [
	(aComponentClass isNil or:[aComponentClass isClass not or:[aComponentClass isComponentClass not]]) ifTrue: [ ^ NotAComponentClassError signal: 'Cannot allow no Component class deployment'. ].
	(aComponentClass haveComponentType) ifFalse: [ ^ NotATypedComponentClassError signal: 'Cannot allow no Typed Component class deployment' ].
	
	^MolComponentManager default homeServices isDeployedComponent: aComponentClass
]

{ #category : #deployment }
MolDeploymentServices >> undeployComponentImplementation: aComponentClass [ 
	(aComponentClass isNil or:[aComponentClass isClass not or:[aComponentClass isComponentClass not]]) ifTrue: [ ^ NotAComponentClassError signal: 'Cannot allow no Component class undeployment'. ].
	(aComponentClass haveComponentType) ifFalse: [ ^ NotATypedComponentClassError signal: 'Cannot allow no Typed Component class undeployment' ].

	MolComponentManager default homeServices removeDeployedComponent: aComponentClass
]
