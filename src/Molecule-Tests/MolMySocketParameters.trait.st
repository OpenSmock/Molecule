"
I define all the parameters provided by a socket component. Some of these parameters are not used in the tests, there are examples.

My providers must use me as trait. If the component type is correctly defined, it will be automatically done after use method defineComponent.

See ComponentParameters for more informations about parameters.
"
Trait {
	#name : 'MolMySocketParameters',
	#traits : 'MolComponentParameters',
	#classTraits : 'MolComponentParameters classTrait',
	#category : 'Molecule-Tests-Resources - Contracts',
	#package : 'Molecule-Tests',
	#tag : 'Resources - Contracts'
}

{ #category : 'parameters' }
MolMySocketParameters >> setIp: anIpAddress [

	self explicitRequirement
]

{ #category : 'parameters' }
MolMySocketParameters >> setPort: aPort [

	self explicitRequirement
]

{ #category : 'parameters' }
MolMySocketParameters >> setProtocol: aProtocol [

	self explicitRequirement
]
