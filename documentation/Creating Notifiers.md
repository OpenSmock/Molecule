Notifiers are used to trigger events between components.
They're automatically generated based on the Consumed Events part of a component's contract (what Event Trait was put in the `consumedComponentEvents` method), there is no need to manually type it.
If you're not getting this method, you can first click on the Library tab of Pharo, then select Molecule -> Debug and Tools, then click on Define All Components. If you're still not getting what you expected, you will need to verify what is put in your component's contract (no empty instance variable for example).

To trigger an event, the syntax follows this template:
`self get[componentName]EventsNotifier [eventName]`
If a component is currently listening to the one emitting this event (see the last part of [Creating Events]()) and if the eventual Producers are set up correctly (see [Creating Producers]()), then the component listening will receive the event and execute its method that has the same name. 
All steps are needed in order for this communication to happen.

**add img**
