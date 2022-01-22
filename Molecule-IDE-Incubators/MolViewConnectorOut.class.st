Class {
	#name : #MolViewConnectorOut,
	#superclass : #MolViewConnector,
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'instance creation' }
MolViewConnectorOut >> fromEvent: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self eventColor.
]

{ #category : #'instance creation' }
MolViewConnectorOut >> fromParameter: aTrait [
	self trait: aTrait.
	self drawLabelWithColor: self parameterColor.
]

{ #category : #'instance creation' }
MolViewConnectorOut >> fromService: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self serviceColor.
]
