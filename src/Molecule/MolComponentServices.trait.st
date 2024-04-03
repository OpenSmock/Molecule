"
I represent a set of services of a component. A service  corresponds to request,  the service provider has to answer to this query. The response can be nil (or nothing). A trait can define several services, a service is a method. A component provide services, than can be used by others components.

To create your own services trait, you have to use this trait.

MyTableTest provides simple examples of  uses of the services.

Naming conventions :
<Name of my service>Services

The difference between the parameters and the services is semantic.
"
Trait {
	#name : 'MolComponentServices',
	#category : 'Molecule-Component Contract',
	#package : 'Molecule',
	#tag : 'Component Contract'
}
