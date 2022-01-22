Class {
	#name : #MolViewConnectorIn,
	#superclass : #MolViewConnector,
	#category : #'Molecule-IDE-Incubators-Mol View'
}

{ #category : #'instance creation' }
MolViewConnectorIn >> fromEvent: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self eventColor.
]

{ #category : #'instance creation' }
MolViewConnectorIn >> fromParameter: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self parameterColor.
]

{ #category : #'instance creation' }
MolViewConnectorIn >> fromService: aTrait [ 
	self trait: aTrait.
	self drawLabelWithColor: self serviceColor.
]
