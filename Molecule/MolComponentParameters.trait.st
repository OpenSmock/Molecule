"
I represent a set of parameters of a component. A parameter change the internal behavior of a component. A trait can define several parameters, a parameter is a method. A component provide parameters, than can be used by others components.

To create your own parameters trait, you have to use this trait.

MySocketTest provides simple examples of  uses of the parameters.

Naming conventions :
<Name of my parameter>Parameters

The difference between the parameters and the services is semantic.
"
Trait {
	#name : #MolComponentParameters,
	#category : #'Molecule-Component Contract'
}
