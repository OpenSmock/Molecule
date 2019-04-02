"
I am responsable for trigger events.
"
Class {
	#name : #MolEventNotifier,
	#superclass : #Object,
	#instVars : [
		'interface',
		'originator',
		'activate'
	],
	#category : #'Molecule-Core'
}

{ #category : #actions }
MolEventNotifier >> activate [
	activate := true
]

{ #category : #actions }
MolEventNotifier >> deactivate [
	activate := false
]

{ #category : #'reflective operations' }
MolEventNotifier >> doesNotUnderstand: aMessage [
	(interface allSelectors includes: aMessage selector)
		ifFalse: [ MolUtils log: originator printString , ' send an undefined event: ' , aMessage selector ].
	activate
		ifFalse: [ MolUtils log: originator printString , ' send event when passivate: ' , aMessage selector ].
	originator triggerEvent: aMessage selector withArguments: aMessage arguments
]

{ #category : #'initialize-release' }
MolEventNotifier >> initialize [
	activate := false
]

{ #category : #accessing }
MolEventNotifier >> interface: anInterface originator: aComponentInstance [
	interface := anInterface.
	originator := aComponentInstance
]

{ #category : #'initialize-release' }
MolEventNotifier >> release [
	super release.
	interface := nil.
	originator := nil
]
