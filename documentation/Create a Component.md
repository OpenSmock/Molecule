# Create a Component
In this tutorial, we will create a first Component that produces an Event and provides a Service. \
Then we will create a second Component that uses the provided Service and consumes the produced Event.

# STATIC PART: declaration

## Define services and events
Code spaces beginning by **Trait** need to be put in the code space under *New class* in the **System Browser$$, located in the **Browse** tab of Pharo.

First, we will create a Service Trait¹ 
with a Service inside it.
```smalltalk
Trait named: # Services
	uses: MolComponentServices
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

¹ Trait: *an independent set of methods with their implementation and requirements (methods and variables). \
Classes using a Trait automatically benefit from these methods, and must define that Trait’s requirements. \
A Trait can be composed of multiple other traits.*

Then, we create an Event Trait with an Event inside it.
```smalltalk
Trait named: # Events
	uses: MolComponentEvents
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

Next, we need to add the Service and Event Traits as suppliers.
```smalltalk
  Services>> :
  "method is left empty, will be defined in the Components that provide it"
```

```smalltalk
  Events>> :
  "method is left empty, will be defined in the Components that consume it"
```

Note: Parameters are similar to Services, their Trait Type just needs to be changed to `MolComponentParameters`
```smalltalk
Trait named: # Parameters
	uses: MolComponentParameters
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

## Define component types

## Adding Component contract with a Component Type
Whatever the method to create a component (from scratch or with an existing Class), the construction and assignment of the contract is the same.

The component type implements the component contract (used/provided services, consumed/produced events, used/provided parameters). The type is implemented through a Trait.

## Define the first component type

TODO : Quelque soit la manière de créer un composant (from scratch ou en réutilisant une class) il faut d'abord définir son contrat.

TODO : Créer un ComponentType pour le premier composant

## Define the second component type

TODO : pareil avec l'inverse

## Create a component implmentation of a type

There are two ways to create a new Molecule Component :
- Create a new Component from scratch : write a new Class inheriting from the Component hierarchy
- Re-using an existing Class : augmenting that class with Component behavior

## Create a new Component from scratch
To develop a new Component from scratch, a class needs to be created that must subclass the `MolAbstractComponentImpl` abstract Class.

## Re-using an existing Class into a Component
Imagine that we want to reuse an open-source library that implements the behavior for our use case. We want to reuse a class from this existing implementation in our application to add the capability to use this behavior. This class is not a Molecule Component, and does not share the same Class hierarchy as Molecule Components. Therefore this class does not answer the Molecule Component’s interface, and cannot be reused directly as a Component. To manually plug this Class into a molecule component, we have to write glue code for the component to use the API of this Class. This requires an additional effort to write non-functional code, which introduces noise in the application code. This makes such architecture less understandable and maintainable.

With Molecule, we reuse any existing Class by augmenting that Class with Component behavior. This Class becomes seamlessly usable as a Component in a Molecule architecture.

We must use the Molecule Component interface `MolComponentImpl`, which is a Trait, to the existing Class. Any class that implements this interface is usable as a Molecule component. Then, we assign the type Component to the class as a standard Molecule Component.

## Create the component implementation for contract 1

TODO

## Create the component implementation for contract 2

TODO

# DYNAMIC PART: Execution

## Starting a Component
Components are started using the `MolComponentImpl class>>start` instruction, with the complete syntax being `[componentName] start`.
Similarly, they're stopped by `[componentName] stop`.
Components are created with the `default` name when the `start` instruction is used.
This is also why it's not possible to start two components of the same Type at any moment, since they both use the same name (`default`) and same Type Trait (leading to a `ComponentAlreadyExistsError`).

**add img**

### Start the two components


### Starting a component with a name
It's also possible to create a component with a name by using the following syntax: 
`[componentName] start: #[name]`.
This will be useful for [Producers](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Producers.md), which determine which component of a given Type A receives events from which component of a given Type B, if multiple components of the same Type exist.

## Stop the two components
