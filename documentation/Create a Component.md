# Create a Component
In this tutorial, we will create a first Component that produces an Event and provides a Service (a GPS emitting geographical data). \
Then we will create a second Component that uses the provided Service and consumes the produced Event (a Map acting as a display for the data). \
The complete GPS example is present in the **Molecule-Examples** package, but if it's your first time using Molecule, you should follow this tutorial step-by-step in order to understand how Molecule works.

# STATIC PART: declaration

## Define services and events
Code spaces beginning by `Trait` need to be put in the code space under *New class* in the **System Browser**, located in the **Browse** tab of Pharo.

First, we will create a Service Trait¹ 
with a Service inside it.
```smalltalk
Trait named: #MolGPSDataServices
	uses: MolComponentServices
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

¹ Trait: *an independent set of methods with their implementation and requirements (methods and variables). \
Classes using a Trait automatically benefit from these methods, and must define that Trait’s requirements. \
A Trait can be composed of multiple other traits.*

Then, we create an Event interface with an Trait inside it.
```smalltalk
Trait named: #MolGPSDataEvents
	uses: MolComponentEvents
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

Next, we need to add the Service and Event interfaces as suppliers (of a Service and an Event respectively).
```smalltalk
 MolGPSDataServices>>getAccuracyRadiusInMeters
	"Gets and return the accuracy of the GPS depending on quality of signal and quantity of connected satellites"
	"method is left empty, will be defined in the Component that provides it"
```

```smalltalk
 MolGPSDataEvents>>currentPositionChanged: aGeoPosition
	"Notify the current geographic position of the GPSreceiver when changed"
	"method is left empty, will be defined in the Component that consumes it"
```

Note: Parameters are similar to Services, their Trait Type just need to be changed to `MolComponentParameters`
```smalltalk
Trait named: # MolGPSDataParameters
	uses: MolComponentParameters
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

## Define Component types

## Adding Component contract with a Component Type
Whatever the method to create a Component (from scratch or with an existing Class) is, its contract first needs to be defined (for the two methods, the construction and assignment of the contract is the same).

The Component Type implements the Component contract (used/provided Services, consumed/produced Events, used/provided Parameters). \
The Type is implemented through a Trait. \
Types don't have any methods on the Instance side of Pharo, their contract is to be defined by overriding some methods on the **Class side** of Pharo.

## Define the first Component Type
```smalltalk
Trait named: #MolGPSData
	uses: MolComponentType
	instanceVariableNames: ''
	package: 'Molecule-Tutorial'
```

## Define the second Component Type
```smalltalk
Trait named: #MolGPSMap
	uses: MolComponentType
	instanceVariableNames: ''
	package: 'Molecule-Tutorial'
```

## Create a Component implementation of a Type
There are two ways to create a new Molecule Component :
- Create a new Component from scratch : write a new Class inheriting from the Component hierarchy
- Re-using an existing Class : augmenting that class with Component behavior

## Create a new Component from scratch
To develop a new Component from scratch, a class needs to be created that must subclass the `MolAbstractComponentImpl` abstract Class.

## Re-using an existing Class into a Component
Imagine that we want to reuse an open-source library that implements the behavior for our use case. We want to reuse a class from this existing implementation in our application to add the capability to use this behavior. This class is not a Molecule Component, and does not share the same Class hierarchy as Molecule Components. Therefore this class does not answer the Molecule Component’s interface, and cannot be reused directly as a Component. To manually plug this Class into a molecule component, we have to write glue code for the component to use the API of this Class. This requires an additional effort to write non-functional code, which introduces noise in the application code. This makes such architecture less understandable and maintainable.

With Molecule, we reuse any existing Class by augmenting that Class with Component behavior. This Class becomes seamlessly usable as a Component in a Molecule architecture.

We must use the Molecule Component interface `MolComponentImpl`, which is a Trait, in the existing Class. Any class that implements this interface is usable as a Molecule component. Then, we assign the type Component to the class as a standard Molecule Component.

## Define the contract for MolGPSData
For this tutorial, the GPS needs to send its geographical data to the Map. \
In order to do that, its contract needs to be redefined to indicate which Services and Events are produced and provided by it. \
Redefining a Component's contract is done on the **Class side** of Pharo (in the **System Browser**, accessible through the **Browser** tab of Pharo, click on the radio button located left to the Class side text, which is located in the middle of the **System Browser** window). \
The needed methods for the contract already exist (since the Components' Type use `MolComponentType`), they just need to be overridden. \
A Component Type can provide multiple Services and Events (separated by a comma), there's just one each for this tutorial (each one being put between the curly brackets of the methods).

Since the `MolGPSData` Component Type needs to inform the Map when its position is changed, it produces the `MolGPSDataEvents>>currentPositionChanged: aGeoPosition` Event.
```smalltalk
MolGPSData>>producedComponentEvents

	<componentContract>
	^ { MolGPSDataEvents }
```

Since the `MolGPSData` Component Type needs to returns its accuracy when its position is changed, it provides the `MolGPSDataServices>>getAccuracyRadiusInMeters` Service.
```smalltalk
MolGPSData>>providedComponentServices

	<componentContract>
	^ { MolGPSDataServices }
```

## Create the Component implementation for MolGPSData
Code spaces beginning by `MolAbstractComponentImpl` need to be put in the code space under *New class* in the **System Browser**, located in the **Browse** tab of Pharo.

When this is all done, we can move on to create the GPS Component, being `MolGPSDataImpl`. This component uses the `MolGPSData` Trait, used to define the Component's contract, as well as the `MolGPSDataServices` interface, which needs to be specified in order for the Component to provide its Service.
```smalltalk
MolAbstractComponentImpl subclass: #MolGPSDataImpl
	uses: MolGPSData + MolGPSDataServices
	instanceVariableNames: 'accuracy sendCurrentPositionThread'
	classVariableNames: ''
	package: 'Molecule-Tutorial'
```

## Define what does the GPS Component do
Next, we will need to specify what exactly the GPS sends. This is where the previously declared instance variables `accuracy` comes into play. 
First, put a getter and setter for it.
```smalltalk
MolGPSDataImpl>>accuracy

	^ accuracy
```

```smalltalk
MolGPSDataImpl>>accuracy: anObject

	accuracy := anObject
```

Next, create a method that changes the value of this instance variable.
```smalltalk
MolGPSDataImpl>>increaseAccuracy

	| nextAccuracy |
	self accuracy > 1 ifTrue: [
		nextAccuracy := self accuracy - (0.1 * self accuracy). "10% better precision at each time"
		nextAccuracy < 1 ifTrue: [ "stay to 1" nextAccuracy := 1 ].
		self accuracy: nextAccuracy ]
```

Then, override the Service `getAccuracyRadiusInMeters` (which will simply return `accuracy`)
```smalltalk
MolGPSDataImpl>>getAccuracyRadiusInMeters
	"Get and return the accuracy of the GPS depending quality of signal and quantity of connected satellites"

	^ self accuracy
```

This method is used to return a randomized couple of values.
```smalltalk
MolGPSDataImpl>>getRandomizedGPSPosition
	| random |
	random := Random new.
	^ random next @ random next
 ```

After that, the Component needs to call these methods and send them to the `MolGPSMapImpl` (component created in the next part).
This is done by overriding the `MolComponentImpl class>>componentActivate`, invoked when a Component is started, `MolComponentImpl class>>componentInitialize` when a Component is initialized (comes after starting and only triggers one time) and `MolComponentImpl class>>componentPassivate`, invoked when a Component is stopped.

```smalltalk
MolGPSDataImpl>>componentInitialize
	"Set starting accuracy"

	self accuracy: 1000
  ```

```smalltalk
MolGPSDataImpl>>componentActivate
	"Start a thread to simulate sending of the geo position and accuracy precision each second"

	sendCurrentPositionThread := [
	                             [ true ] whileTrue: [
		                             (Delay forMilliseconds: 50) wait.
		                             self getMolGPSDataEventsNotifier
			                             currentPositionChanged:
			                             self getRandomizedGPSPosition.
		                             self increaseAccuracy ] ] forkAt:
		                             Processor userBackgroundPriority
```
To quickly detail this method, we first need to examine the `getMolGPSDataEventsNotifier`. This method was generated by Pharo after `MolGPSDataEvents` was put in the `producedComponentEvents` part of the Component's contract.
To return to `componentActivate`, after every 50 milliseconds, a random geographical position is generated, 

```smalltalk
MolGPSDataImpl>>componentPassivate

	sendCurrentPositionThread ifNotNil: [ :e | e terminate ].
	sendCurrentPositionThread := nil
```

## Create the Component implementation for MolGPSMap
Same way as `MolGPSDataImpl`, we can move on to create the Map Component, being `MolGPSMapImpl`. This component uses the `MolGPSMap` Trait, used to define the Component's Contract, as well as the `MolGPSDataEvents` interface, which needs to be specified in order for the Component to consume its Service.
```smalltalk
MolAbstractComponentImpl subclass: #MolGPSMapImpl
	uses: MolGPSMap + MolGPSDataEvents
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Molecule-Examples-GPS Example'
```

## Define the contract for MolGPSMap
Conversely, the Map needs to be informed and receive the data through the same Event and Service as `MolGPSData`.
Instead of producing and providing interfaces, it will instead consume and use them respectively.
```smalltalk
MolGPSMap>>consumedComponentEvents

	<componentContract>
	^ { MolGPSDataEvents }
```

```smalltalk
MolGPSMap>>usedComponentServices

	<componentContract>
	^ { MolGPSDataServices }
```

## Define what does the Map Component do
First off, this method is used to show in the Transcript (available from the **Browse** tab of Pharo) every position received from `MolGPSDataImpl`.
```smalltalk
MolGPSMapImpl>>updatePositionCircleOnMap: aGeoPosition radius: radius
	"Update geographic position of the received GPS position circle with a precision radius"

	| point text |
	point := aGeoPosition.
	point := point truncateTo: 0.01.
	text := (point x printShowingDecimalPlaces: 2) , '@'
	        , (point y printShowingDecimalPlaces: 2).

	Transcript
		show: '[Map] Receive new GPS position: ' , text , ' radius: '
			, radius rounded printString , ' m';
		cr
```

Then, we will need to subscribe to `MolGPSDataEvents` through the `getMolGPSDataEventsSubscriber` (automatically generated by Pharo when `MolGPSDataEvents` was put in the `consumedComponentEvents` part of the Component's contract). Subscribing means that `MolGPSMapImpl` will be informed whenever an Event is produced from `MolGPSDataEvents`, and since `MolGPSDataImpl` is the only Component that can produce such Events, `MolGPSMapImpl` is informed by it.
```smalltalk
MolGPSMapImpl>>componentActivate

	self getMolGPSDataEventsSubscriber subscribe: self
```

Stopping the component means that it will not listen anymore to the events produced by `MolGPSDataEvents`.
```smalltalk
MolGPSMapImpl>>componentPassivate

	self getMolGPSDataEventsSubscriber unsubscribe: self
```

Next, we need to override the `currentPositionChanged: aGeoPosition` inherited from the `MolGPSDataServices` (present in the `usedComponentServices` part of the Component's contract). In this case, the `accuracy` variable is used in order to display it in the Transcript by using `updatePositionCircleOnMap: aGeoPosition radius: radius`.
```smalltalk
MolGPSMapImpl>>currentPositionChanged: aGeoPosition
	"Display a circle on the map view at the current position"

	| radius |
	radius := self getMolGPSDataServicesProvider
		          getAccuracyRadiusInMeters.

	self updatePositionCircleOnMap: aGeoPosition radius: radius
```

# DYNAMIC PART: Execution

## Starting a Component
Components are started using the `MolComponentImpl class>>start` instruction, with the complete syntax being `[componentName] start`.
Components are created with the `default` name when the `start` instruction is used.
This is also why it's not possible to start two components of the same Type at any moment, since they both use the same name (`default`) and same Type Trait (leading to a `ComponentAlreadyExistsError`).

**add img**

### Start the two components
In a **Playground** (located in the **Browse** tab of Pharo):

```smalltalk
	 MolGPSDataImpl start.
	 MolGPSMapImpl start
```

### Starting a component with a name
It's also possible to create a component with a name by using the following syntax: 
`[componentName] start: #[name]`.
This will be useful for [Producers](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Producers.md), which determine which component of a given Type A receives events from which component of a given Type B, if multiple components of the same Type exist.

## Stopping a component
Components are stopped using the `MolComponentImpl class>> stop` instruction, the syntax being similar to the `start` instruction since
Components are stopped by `[componentName] stop`.
Components with a name are stopped using the same syntax as `start`, which is 
`[componentName] stop: #[name]`.

## Stop the two components
In a **Playground** (located in the **Browse** tab of Pharo):

```smalltalk
	 MolGPSDataImpl stop.
	 MolGPSMapImpl stop
```
