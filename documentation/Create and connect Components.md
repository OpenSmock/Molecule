# Create and connect Components
- In this tutorial, we will create a first Component that produces an Event and provides a Service (a GNSS emitting geographical data)
- We will then create a second Component that uses the provided Service and consumes the produced Event (a Map acting as a display for the data) \
![gps molecule without figure](https://github.com/Eliott-Guevel/Molecule-various-fixes/assets/76944457/a949d2f8-c460-40be-985d-273881e5b3da) \
GPS (Global Positioning System) is the american subsystem of GNSS (Global Navigation Satellite Systems).

# Contents
[STATIC PART: declaration](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#static-part-declaration)
* [Define services and events](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-services-and-events)
* [Define Component types](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-component-types)
	- [Adding Component contract with a Component Type](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#adding-component-contract-with-a-component-type)
	  	+ [Define first Component Type MolGNSSData](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-the-first-component-type-molgnssdata)
	     	+ [Define the second Component Type MolGNSSMap](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-the-second-component-type-molgnssmap)
* [Create a Component implementation of a Type](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#create-a-component-implementation-of-a-type)
	- [Create a new Component from scratch](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#create-a-new-component-from-scratch)
	- [Re-using an existing Class into a Component](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#re-using-an-existing-class-into-a-component)
* [Define the contract for MolGNSSData](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-the-contract-for-molgnssdata)
* [Create the Component implementation for MolGNSSData](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#create-the-component-implementation-for-molgnssdata)
* [Define what the MolGNSSDataImpl Component does](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-what-the-molgnssdataimpl-component-does)
	- [Generated methods](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#generated-methods)
* [Create the Component implementation for MolGNSSMap](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#create-the-component-implementation-for-molgnssmap)
* [Define the contract for MolGNSSMap](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-the-contract-for-molgnssmap)
* [Define what the MolGNSSMapImpl Component does](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#define-what-the-molgnssmapimpl-component-does) \
[DYNAMIC PART: Execution](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#dynamic-part-execution)
* [Starting a Component](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#starting-a-component)
	 - [Start the MolGNSSDataImpl and MolGNSSMapImpl components](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#start-the-molgnssdataimpl-and-molgnssmapimpl-components)
	   - [Starting a component with a name](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#starting-a-component-with-a-name)
* [Stopping a component](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#stopping-a-component)
	 - [Stop the MolGNSSDataImpl and MolGNSSMapImpl components](https://github.com/OpenSmock/Molecule/blob/documentation/documentation/Create%20and%20connect%20Components.md#stop-the-molgnssdataimpl-and-molgnssmapimpl-components)

The complete GNSS example is present in the **Molecule-Examples** package, but if it's your first time using Molecule, you should follow this tutorial step-by-step in order to understand how Molecule works. \
A graphical form of the example is available in the [Molecule-Geographical-Position-Example](https://github.com/OpenSmock/Molecule-Geographical-Position-Example) repository.

# STATIC PART: declaration

## Define services and events
Code spaces beginning by `Trait` need to be put in the code space under *New class* in the **System Browser**, located in the **Browse** tab of Pharo.

First, we create a Service Trait¹ (a Trait that uses the `MolComponentServices` Trait)
```smalltalk
Trait named: #MolGNSSDataServices
	uses: MolComponentServices
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```
¹ Trait: *an independent set of methods with their implementation and requirements (methods and variables). \
Classes using a Trait automatically benefit from these methods, and must define that Trait’s requirements. \
A Trait can be composed of multiple other traits.*

We then add a Service to this Trait which is `getAccuracyRadiusInMeters`, which means that the `MolGNSSDataServices` is a provider of the `getAccuracyRadiusInMeters` Service
```smalltalk
 MolGNSSDataServices>>getAccuracyRadiusInMeters
	"Gets and return the accuracy of the GNSS depending on quality of signal and quantity of connected satellites"
	"method is left empty, will be defined in the Component that provides it"
```

Then, we create an Event Trait (a Trait that uses the `MolComponentEvents` Trait)
```smalltalk
Trait named: #MolGNSSDataEvents
	uses: MolComponentEvents
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

This Event trait produces the `currentPositionChanged: aGeoPosition` Event
```smalltalk
 MolGNSSDataEvents>>currentPositionChanged: aGeoPosition
	"Notify the current geographic position of the GNSSreceiver when changed"
	"method is left empty, will be defined in the Component that consumes it"
```

## Define Component types

### Adding Component contract with a Component Type
Whatever the method to create a Component (from scratch or with an existing Class) is, its contract first needs to be defined (for the two methods, the construction and assignment of the contract is the same).

The Component Type implements the Component contract (used/provided Services, consumed/produced Events, used/provided Parameters). \
The Type is implemented through a Trait. \
Types don't have any methods on the Instance side of Pharo, their contract is to be defined by overriding some methods on the **Class side** of Pharo.

#### Define the first Component Type MolGNSSData
```smalltalk
Trait named: #MolGNSSData
	uses: MolComponentType
	instanceVariableNames: ''
	package: 'Molecule-Tutorial'
```

#### Define the second Component Type MolGNSSMap
```smalltalk
Trait named: #MolGNSSMap
	uses: MolComponentType
	instanceVariableNames: ''
	package: 'Molecule-Tutorial'
```

## Create a Component implementation of a Type
There are two ways to create a new Molecule Component :
- Create a new Component from scratch : write a new Class inheriting from the Component hierarchy
- Re-using an existing Class : augmenting that class with Component behavior

### Create a new Component from scratch
To develop a new Component from scratch, a class needs to be created that must subclass the `MolAbstractComponentImpl` abstract Class.

### Re-using an existing Class into a Component
Imagine that we want to reuse an open-source library that implements the behavior for our use case. We want to reuse a class from this existing implementation in our application to add the capability to use this behavior. This class is not a Molecule Component, and does not share the same Class hierarchy as Molecule Components. Therefore this class does not answer the Molecule Component’s interface, and cannot be reused directly as a Component. To manually plug this Class into a molecule component, we have to write glue code for the component to use the API of this Class. This requires an additional effort to write non-functional code, which introduces noise in the application code. This makes such architecture less understandable and maintainable.

With Molecule, we reuse any existing Class by augmenting that Class with Component behavior. This Class becomes seamlessly usable as a Component in a Molecule architecture.

We must use the Molecule Component interface `MolComponentImpl`, which is a Trait, in the existing Class. Any class that implements this interface is usable as a Molecule component. Then, we assign the type Component to the class as a standard Molecule Component.

![classes et composants Molecule](https://github.com/Eliott-Guevel/Molecule-various-fixes/assets/76944457/82fe912e-8db9-479f-ae0f-1d1d050318eb)

## Define the contract for MolGNSSData
For this tutorial, the GNSS needs to send its geographical data to the Map. \
In order to do that, its contract needs to be redefined to indicate which Services and Events are produced and provided by it.

![implementation contrat molecule](https://github.com/Eliott-Guevel/Molecule-various-fixes/assets/76944457/a9c14388-0abe-4f09-8ac5-578054f98ad1)

Redefining a Component's contract is done on the **Class side** of Pharo (in the **System Browser**, accessible through the **Browser** tab of Pharo, click on the radio button located left to the Class side text, which is located in the middle of the **System Browser** window). \
The needed methods for the contract already exist (since the Components' Type use `MolComponentType`), they just need to be overridden. \
A Component Type can provide multiple Services and Events (separated by a comma), there's just one each for this tutorial (each one being put between the curly brackets of the methods).

Since the `MolGNSSData` Component Type needs to inform the Map when its position is changed, it produces the `MolGNSSDataEvents>>currentPositionChanged: aGeoPosition` Event.
```smalltalk
MolGNSSData>>producedComponentEvents

	<componentContract>
	^ { MolGNSSDataEvents }
```

Since the `MolGNSSData` Component Type needs to returns its accuracy when its position is changed, it provides the `MolGNSSDataServices>>getAccuracyRadiusInMeters` Service.
```smalltalk
MolGNSSData>>providedComponentServices

	<componentContract>
	^ { MolGNSSDataServices }
```

## Create the Component implementation for MolGNSSData
Code spaces beginning by `MolAbstractComponentImpl` need to be put in the code space under *New class* in the **System Browser**, located in the **Browse** tab of Pharo.

When this is all done, we can move on to create the GNSS Component, being `MolGNSSDataImpl`. This component uses the `MolGNSSData` Trait, used to define the Component's contract, as well as the `MolGNSSDataServices` interface which needs to be specified in order for the Component to provide its Service.
```smalltalk
MolAbstractComponentImpl subclass: #MolGNSSDataImpl
	uses: MolGNSSData + MolGNSSDataServices
	instanceVariableNames: 'accuracy sendCurrentPositionThread'
	classVariableNames: ''
	package: 'Molecule-Tutorial'
```

## Define what the MolGNSSDataImpl Component does
Next, we will need to specify what exactly the GNSS sends. This is where the previously declared instance variable `accuracy` comes into play. 
First, create a getter and setter for it.
```smalltalk
MolGNSSDataImpl>>accuracy

	^ accuracy
```

```smalltalk
MolGNSSDataImpl>>accuracy: anObject

	accuracy := anObject
```

Next, create a method that changes the value of this instance variable.
```smalltalk
MolGNSSDataImpl>>increaseAccuracy

	| nextAccuracy |
	self accuracy > 1 ifTrue: [
		nextAccuracy := self accuracy - (0.1 * self accuracy). "10% better precision at each time"
		nextAccuracy < 1 ifTrue: [ "stay to 1" nextAccuracy := 1 ].
		self accuracy: nextAccuracy ]
```

Then, override the `getAccuracyRadiusInMeters` Service (which will simply return `accuracy`)
```smalltalk
MolGNSSDataImpl>>getAccuracyRadiusInMeters
	"Get and return the accuracy of the GNSS depending quality of signal and quantity of connected satellites"

	^ self accuracy
```

`getRandomizedGNSSPosition` is used to return a randomized couple of values.
```smalltalk
MolGNSSDataImpl>>getRandomizedGNSSPosition
	| random |
	random := Random new.
	^ random next @ random next
 ```

After that, the `MolGNSSDataImpl` Component needs to use this Service. \
This is done by overriding 
- `MolComponentImpl class>>componentActivate`, invoked when a Component is started
- `MolComponentImpl class>>componentInitialize` when a Component is initialized (comes after starting)
- `MolComponentImpl class>>componentPassivate`, invoked when a Component is stopped

```smalltalk
MolGNSSDataImpl>>componentInitialize
	"Set starting accuracy"

	self accuracy: 1000
  ```

```smalltalk
MolGNSSDataImpl>>componentActivate
	"Start a thread to simulate sending of the geo position and accuracy precision each second"

	sendCurrentPositionThread := [
	                             [ true ] whileTrue: [
		                             (Delay forMilliseconds: 50) wait.
		                             self getMolGNSSDataEventsNotifier
			                             currentPositionChanged:
			                             self getRandomizedGNSSPosition.
		                             self increaseAccuracy ] ] forkAt:
		                             Processor userBackgroundPriority
```

### Generated methods
To quickly detail this method, we first need to examine `getMolGNSSDataEventsNotifier`. This method was generated by Pharo after `MolGNSSDataEvents` was put in the `producedComponentEvents` part of the Component's contract.
To return to `componentActivate`, after every 50 milliseconds, a random geographical position is generated which is sent through the `currentPositionChanged: aGeoPosition` Event.

Generated methods take the following forms:
- get[componentName]EventsNotifier
- get[componentName]EventsSubscriber
- get[componentName]ServicesProvider
There is no need to manually type them.

If you're not getting all the generated methods you should have, you can first click on the **Library** tab of Pharo, then select **Molecule** -> **Debug and Tools** and then click on **Define All Components**. If you're still not getting what you expected, you will need to verify what is put in your component's contract (no empty instance variable for example). 

```smalltalk
MolGNSSDataImpl>>componentPassivate
	"stops the thread and resets it"

	sendCurrentPositionThread ifNotNil: [ :e | e terminate ].
	sendCurrentPositionThread := nil
```

## Create the Component implementation for MolGNSSMap
Same way as `MolGNSSDataImpl`, we can move on to create the Map Component, being `MolGNSSMapImpl`. This component uses the `MolGNSSMap` Trait, used to define the Component's contract, as well as the `MolGNSSDataEvents` interface, which needs to be specified in order for the Component to consume its Service.
```smalltalk
MolAbstractComponentImpl subclass: #MolGNSSMapImpl
	uses: MolGNSSMap + MolGNSSDataEvents
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Molecule-Examples-GNSS Example'
```

## Define the contract for MolGNSSMap
Conversely, the Map needs to be informed and receive the data through the same Event and Service as `MolGNSSData`.
Instead of producing and providing interfaces, it will instead consume and use them respectively.
```smalltalk
MolGNSSMap>>consumedComponentEvents

	<componentContract>
	^ { MolGNSSDataEvents }
```

```smalltalk
MolGNSSMap>>usedComponentServices

	<componentContract>
	^ { MolGNSSDataServices }
```

## Define what the MolGNSSMapImpl Component does
First off, this method is used to show in the Transcript (available from the **Browse** tab of Pharo) every position received from `MolGNSSDataImpl`.
```smalltalk
MolGNSSMapImpl>>updatePositionCircleOnMap: aGeoPosition radius: radius
	"Update geographic position of the received GNSS position circle with a precision radius"

	| point text |
	point := aGeoPosition.
	point := point truncateTo: 0.01.
	text := (point x printShowingDecimalPlaces: 2) , '@'
	        , (point y printShowingDecimalPlaces: 2).

	Transcript
		show: '[Map] Receive new GNSS position: ' , text , ' radius: '
			, radius rounded printString , ' m';
		cr
```

Then, we will need to subscribe to `MolGNSSDataEvents` through `getMolGNSSDataEventsSubscriber` (automatically generated by Pharo when `MolGNSSDataEvents` was put in the `consumedComponentEvents` part of the Component's contract). Subscribing means that `MolGNSSMapImpl` will be informed whenever an Event is produced from `MolGNSSDataEvents`, and since `MolGNSSDataImpl` is the only Component that can produce such Events, `MolGNSSMapImpl` is informed by it.
```smalltalk
MolGNSSMapImpl>>componentActivate

	self getMolGNSSDataEventsSubscriber subscribe: self
```

Stopping `MolGNSSMapImpl` means that it will not listen anymore to the events produced by `MolGNSSDataEvents`.
```smalltalk
MolGNSSMapImpl>>componentPassivate

	self getMolGNSSDataEventsSubscriber unsubscribe: self
```

Next, we need to override the `currentPositionChanged: aGeoPosition` inherited from `MolGNSSDataServices` (present in the `usedComponentServices` part of the Component's contract). In this case, the `accuracy` variable is used in order to display it in the Transcript by using `updatePositionCircleOnMap: aGeoPosition radius: radius`.
```smalltalk
MolGNSSMapImpl>>currentPositionChanged: aGeoPosition
	"Display a circle on the map view at the current position"

	| radius |
	radius := self getMolGNSSDataServicesProvider
		          getAccuracyRadiusInMeters.

	self updatePositionCircleOnMap: aGeoPosition radius: radius
```

# DYNAMIC PART: Execution

## Starting a Component
Components are started using the `MolComponentImpl class>>start` instruction.
Components are created with the `default` name when the `start` instruction is used.
This is also why it's not possible to start two components of the same Type at any moment, since they both use the same name (`default`) and same Type Trait (leading to a `ComponentAlreadyExistsError`).

**add img**

### Start the MolGNSSDataImpl and MolGNSSMapImpl components
In a **Playground** (located in the **Browse** tab of Pharo):
```smalltalk
MolGNSSDataImpl start.
MolGNSSMapImpl start
```
The Pharo **Transcript** (also located in the **Browse** tab of Pharo) will start showing messages in the form of \
'[Map] Receive new GNSS position: x@x radius: x m';

### Starting a component with a name
It's also possible to create a component with a name by using the `MolComponentImpl class>>start: #[name]` method.
This will be useful for [Producers](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Producers.md), which determine which component of a given Type A receives events from which component of a given Type B, if multiple components of the same Type exist.

## Stopping a component
Components are stopped using the `MolComponentImpl class>>stop` instruction. \
Components with a name are stopped a similar method as `start`, which is `MolComponentImpl class>>stop: #[name]`.

## Stop the MolGNSSDataImpl and MolGNSSMapImpl components
In a **Playground** (located in the **Browse** tab of Pharo):

```smalltalk
MolGNSSDataImpl stop.
MolGNSSMapImpl stop
```

To verify that all your Components are stopped, you can use `MolUtils allComponentInstancesOfType:` on the Type Trait of a Component. If it returns an empty list, it means that no Component is currently active.

You can also use the **Inspect Component Manager** option of Molecule, available from the **Library tab of Pharo**. If the window shown doesn't have a *deployedComponents* field or is set to *nil*, it also means that no Component is currently active.
