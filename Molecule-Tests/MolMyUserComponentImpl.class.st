"
I am an example of user of table component. I have a method which give me an access to the table component.

Because I am a component implementation, you can force my automatic definition. To do it,  use class method 'self defineComponent'.
"
Class {
	#name : #MolMyUserComponentImpl,
	#superclass : #Object,
	#traits : 'MolMyUserComponent + MolComponentImpl',
	#classTraits : 'MolMyUserComponent classTrait + MolComponentImpl classTrait',
	#instVars : [
		'myTableServices'
	],
	#category : #'Molecule-Tests-Resources - Components'
}

{ #category : #'component accessing' }
MolMyUserComponentImpl >> getMolMyTableServicesProvider [
	| servicesSymbol servicesProvider itf |
	itf := MolMyTableServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [^MolNotFoundServicesProvider new interface: itf name: nil].
	servicesSymbol isSymbol
	 	ifTrue: 
			[servicesProvider := MolComponentManager default locatorServices 
						searchServicesProviderFor: MolMyTableServices named: servicesSymbol]. 
	^servicesProvider
]
