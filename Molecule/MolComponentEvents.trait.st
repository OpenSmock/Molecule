"
I represent an event of a component. One component can produce events which are consumed by subscribed components. Events are synchronous. A producer send events without wait a response of its subscribers. 

To create your own events, you have to use this trait.

MyWarningSystemTest provides simple examples of  uses of the events.

Naming conventions :
<Name of my event>Events
"
Trait {
	#name : #MolComponentEvents,
	#category : #'Molecule-Core'
}
