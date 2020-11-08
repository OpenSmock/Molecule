"
I am a superclass of a component implementation. Notice that I use the trait ComponentImpl, and I have just two additional instance variables componentName and componentConnector.

You can create a componant implementation by using me as superclass, or directly use ComponentImpl trait. In that case, you have to implement the behavior of methods componentName, componentName:, componentConnector and componentConnector:.

Also,  a component needs a definition. My subclasses have to use a trait which use ComponentType trait. See ComponentType for more informations.

Naming conventions for all my  subclasses :
<component type name>[something relative to my specific implementation]ComponentImpl.
If the component has only one implementation, it is not necessary to precise something about the specific implementation.

"
Class {
	#name : #MolAbstractComponentImpl,
	#superclass : #Object,
	#traits : 'MolComponentImpl',
	#classTraits : 'MolComponentImpl classTrait',
	#category : #'Molecule-Core-Impl'
}
