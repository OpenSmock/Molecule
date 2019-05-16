"
I am an example of socket component. I provided services to create an UDP or TCP connection. That is just an example.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMySocketComponentImpl,
	#superclass : #MolAbstractComponentImpl,
	#traits : 'MolMySocketComponent + MolMySocketServices + MolMySocketParameters',
	#classTraits : 'MolMySocketComponent classTrait + MolMySocketServices classTrait + MolMySocketParameters classTrait',
	#instVars : [
		'ip',
		'port',
		'protocol'
	],
	#category : #'Molecule-Tests-Parameters Resources'
}

{ #category : #services }
MolMySocketComponentImpl >> connect [

	MolUtils log: self printString, ' connect to: ', ip printString, ':', port printString, ' with protocol: ', protocol printString.
]

{ #category : #services }
MolMySocketComponentImpl >> disconnect [

	MolUtils log: self printString, ' disconnect.'
]

{ #category : #services }
MolMySocketComponentImpl >> receive: aMessage [

	MolUtils log: self printString, ' receive: ', aMessage.
]

{ #category : #services }
MolMySocketComponentImpl >> send: aMessage [

	MolUtils log: self printString, 'send a message: ', aMessage.
]

{ #category : #parameters }
MolMySocketComponentImpl >> setIp: anIpAddress [

	ip := anIpAddress 
]

{ #category : #parameters }
MolMySocketComponentImpl >> setPort: aPort [

	port := aPort
]

{ #category : #parameters }
MolMySocketComponentImpl >> setProtocol: aProtocol [

	protocol := aProtocol = #tcp
		ifTrue: [ 'TCP' ]
		ifFalse: [ 'UDP' ]
]
