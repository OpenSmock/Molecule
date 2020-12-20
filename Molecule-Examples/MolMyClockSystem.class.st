"
I am not a part of this component system. I provide some methods to start and use it.

This system uses 4 components: a server time send global hour to a clock. The clock send local hour to alarms and to final user (which could be an HMI). The final user can change the parameters of the system as alarm time or set manual time for the clock. The alarm is subscribed to clock time, and sounds when it is time.

This system provides a global example of the use of components. Use Transcript to see the result, and activate Molecule log by using 'MolUtils isLogActive: true'.
"
Class {
	#name : #MolMyClockSystem,
	#superclass : #Object,
	#classVars : [
		'ClockUser'
	],
	#category : #'Molecule-Examples-Clock System Example'
}

{ #category : #private }
MolMyClockSystem class >> deploy [
	
	MolComponentManager default deploymentServices deployComponentImplementation: MolMyServerTimeComponentImpl.
	MolComponentManager default deploymentServices deployComponentImplementation: MolMyClockComponentImpl.
	MolComponentManager default deploymentServices deployComponentImplementation: MolMyAlarmComponentImpl.
	MolComponentManager default deploymentServices deployComponentImplementation: MolMyUserFacadeComponentImpl.
]

{ #category : #'start-stop' }
MolMyClockSystem class >> start [

	| cm |
	cm := MolComponentManager default.
	self deploy.
	
	cm homeServices instanciateComponent: MolMyServerTimeComponentImpl.
	cm homeServices instanciateComponent: MolMyClockComponentImpl.
	cm homeServices instanciateComponent: MolMyUserFacadeComponentImpl.
	cm homeServices instanciateComponent: MolMyAlarmComponentImpl.
	
	cm homeServices activateComponent: MolMyServerTimeComponentImpl.
	cm homeServices activateComponent: MolMyClockComponentImpl.
	cm homeServices activateComponent: MolMyUserFacadeComponentImpl.
	cm homeServices activateComponent: MolMyAlarmComponentImpl.
]

{ #category : #launcher }
MolMyClockSystem class >> startAlarmExample [
	"Start Clock System example : simulate a clock alarm for sleeping !"
	<script: 'self startAlarmExample'>
	| now alarm alarmParameters alarmActivationServices |
	
	"Activate the Molecule log for display results"
	MolUtils isLogActive: true.
	
	"Dialog to inform user to open a Transcrip to see results"
	(UITheme current
		proceedIn: Morph new 
		text: 'Open a Transcript to see this example.'
		title: 'Molecule - Clock System') ifFalse:[^self].
	
	"Clean up the Component Manager in case of previous example running"
	MolComponentManager cleanUp.
	
	"Start the system"
	self start.
	
	"Configure an alarm in 5 seconds"
	now := Time now.
	alarm := Time hour: now hour minute: now minute second: now second + 5.
	
	"The alarm is configured by MolMyClockSystem, we need to get manualy each services and parameters because MolMyClockSystem is not a Molecule component"
	"First : setup the time of the alarm"
	alarmParameters := MolComponentManager default locatorServices searchParametersProviderFor: MolMyAlarmParameters.
	alarmParameters setTime: alarm.
	
	"Second : activate the alarm"
	alarmActivationServices := MolComponentManager default locatorServices searchServicesProviderFor: MolMyAlarmActivationServices.
	alarmActivationServices activate.
	
	"Stop the system in 10 seconds"
	[
		(Duration seconds: 10) wait.
		self stop. 
		"Clean up the Component Manager in case of next example running"
		MolComponentManager cleanUp.
	] fork.
]

{ #category : #'start-stop' }
MolMyClockSystem class >> stop [
	
	MolComponentManager default homeServices removeAllComponents.
	self undeploy.
	
]

{ #category : #private }
MolMyClockSystem class >> undeploy [
	
	MolComponentManager default deploymentServices undeployComponentImplementation: MolMyServerTimeComponentImpl.
	MolComponentManager default deploymentServices undeployComponentImplementation: MolMyClockComponentImpl.
	MolComponentManager default deploymentServices undeployComponentImplementation: MolMyAlarmComponentImpl.
	MolComponentManager default deploymentServices undeployComponentImplementation: MolMyUserFacadeComponentImpl.
]
