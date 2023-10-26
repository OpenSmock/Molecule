# Create a Component

TODO : Dans ce tutorial on vas créer un premier composant qui produit un event et fournis un service. Ensuite nous allons créer une second composant qui utilise le service produit et consomme l'event

## PARTIE STATIQUE : déclaration ##

# Define services and events

TODO : Créer une interface de services avec un service dedans

TODO : Créer une interface d'event avec un event dedans

TODO : ajouter services/events en fournisseur

TODO : Petit note : les paramètres en disant que c'est comme les services en changeant le type de Trait à utiliser

# Define component types

## Adding Component contract with a Component Type
Whatever the method to create a component (from scratch or with an existing Class), the construction and assignment of the contract is the same.

The component type implements the component contract (used/provided services, consumed/produced events, used/provided parameters). The type is implemented through a Trait.

## Define the first component type

TODO : Quelque soit la manière de créer un composant (from scratch ou en réutilisant une class) il faut d'abord définir son contrat.

TODO : Créer un ComponentType pour le premier composant

## Define the second component type

TODO : pareil avec l'inverse

# Create a component implmentation of a type

There are two ways to create a new Molecule Component :
- Create a new Component from scratch : write a new Class inheriting from the Component hierarchy
- Re-using an existing Class : augmenting that class with Component behavior

## Create a new Component from scratch
To develop a new Component from scratch, a class needs to be created that must subclass the `MolAbstractComponentImpl` abstract Class.

## Re-using an existing Class into a Component
Imagine that we want to reuse an open-source library that implements the behavior for our use case. We want to reuse a class from this existing implementation in our application to add the capability to use this behavior. This class is not a Molecule Component, and does not share the same Class hierarchy as Molecule Components. Therefore this class does not answer the Molecule Component’s interface, and cannot be reused directly as a Component. To manually plug this Class into a molecule component, we have to write glue code for the component to use the API of this Class. This requires an additional effort to write non-functional code, which introduces noise in the application code. This makes such architecture less understandable and maintainable.

With Molecule, we reuse any existing Class by augmenting that Class with Component behavior. This Class becomes seamlessly usable as a Component in a Molecule architecture.

We must use the Molecule Component interface `MolComponentImpl`, which is a Trait, to the existing Class. Any class that implements this interface is usable as a Molecule component. Then, we assign the type Component to the class as a standard Molecule Component.

# Create the component implementation for contract 1

TODO

# Create the component implementation for contract 2

TODO

## PARTIE DYNAMIQUE : Execution ##

# Starting a Component
Components are started using the `MolComponentImpl class>>start` instruction, with the complete syntax being `[componentName] start`.
Similarly, they're stopped by `[componentName] stop`.
Components are created with the `default` name when the `start` instruction is used.
This is also why it's not possible to start two components of the same Type at any moment, since they both use the same name (`default`) and same Type Trait (leading to a `ComponentAlreadyExistsError`).

**add img**

# Start the two components


# Starting a component with a name
It's also possible to create a component with a name by using the following syntax: 
`[componentName] start: #[name]`.
This will be useful for [Producers](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Producers.md), which determine which component of a given Type A receives events from which component of a given Type B, if multiple components of the same Type exist.

# Stop the two components
