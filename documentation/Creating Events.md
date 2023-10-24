Events are connected to a component similarly to Services, **with an added step explained at the end of this very tutorial**.
They differ in terms of goals since Events are used for data treatment, which operations need to be done on received data.
An Event Trait is typically named after the Type it's used by, in the form of [Type]Events.
Events use the `MolComponentEvents` Trait in their class definition (`uses: MolComponentEvents`).
After that, a method needs to be created for every event that will be transmitted from one component to another.
Similarly to Services, these methods are typically left empty apart from an eventual comment clarifying their use.
It's in the implementations of these events (classes using a Type Trait linked to an Event Trait) that code execution will be taking place.

To link Events to a component, you first need to place yourself in the class side of a Type Trait then look for the methods that make its contract.
For Events, they're 
- `consumedComponentEvents`: received by the Trait, for a component listening for Events 
- `producedComponentEvents`: created by the Trait, for emitting Events

In the case of multiple events, you just need to separate the different Event Traits by a dot.
This will in return add other methods in the implementations of a Type, namely every event in the added Event Trait(s).
It's here that the event's implementation is made, what you want it to do whenever it's received.
The Event Trait added in `consumedComponentEvents` will in return add a `get[componentName]EventsSubscriber` method which will be used to subscribe to the events emitted from the Trait.
If you're not getting all the methods you should have, you can first click on the Library tab of Pharo, then select Molecule -> Debug and Tools, then click on Define All Components. If you're still not getting what you expected, you will need to verify what is put in your component's contract (no empty instance variable for example). Methods related to the Events as well as `get[componentName]EventsSubscriber` are automatically generated, there is no need to manually type them.

For Events in particular, you will need to subscribe to the class specified in `consumedComponentEvents`. 
This is done in the `componentActivate` method of a Molecule component (which you will need to create). You then fill out the following template:
`self get[componentName]EventsSubscriber subscribe: self`
Conversely, you then need to create a `componentPassivate` method which follows the same template, but for unsubscribing:
`self get[componentName]EventsSubscriber unsubscribe: self`

Notifiers will be needed to trigger an event and are explained in this [Creating Notifiers](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Notifiers.md) tutorial.

**add img**
