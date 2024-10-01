"
A MolComponentInstanciatedTest is a test class for testing the behavior of MolComponentInstanciated
"
Class {
	#name : #MolComponentAnnouncementTest,
	#superclass : #TestCase,
	#category : #'Molecule-Tests-Cases'
}

{ #category : #running }
MolComponentAnnouncementTest >> setUp [

	super setUp.
	MolComponentManager cleanUp
]

{ #category : #running }
MolComponentAnnouncementTest >> tearDown [

	MolComponentManager cleanUp.
	super tearDown
]

{ #category : #tests }
MolComponentAnnouncementTest >> testAnnounceActivated [

	| announcement component component2 |
	announcement := nil.
	SystemAnnouncer uniqueInstance when: MolComponentActivated do:[ :a | announcement := a ].

	"test by standard instanciation"
	MolMyUserComponentImpl deploy.
	component := MolMyUserComponentImpl instantiate.
	self assert: announcement isNil.
	
	MolMyUserComponentImpl activate.
	self assert: announcement notNil.
	self assert: announcement component equals: component.
	self assert: announcement componentName equals: MolUtils defaultComponentName.
	announcement := nil.
	
	"test by named instanciation"
	component2 := MolMyUserComponentImpl instantiate: #myComponent.
	MolMyUserComponentImpl activate: #myComponent.
	self assert: announcement notNil.
	self assert: announcement component equals: component2.
	self assert: announcement componentName equals: #myComponent.
]

{ #category : #tests }
MolComponentAnnouncementTest >> testAnnounceInstanciated [

	| announcement component component2 |
	announcement := nil.
	SystemAnnouncer uniqueInstance when: MolComponentInstantiated do:[ :a | announcement := a ].

	"test by standard instanciation"
	MolMyUserComponentImpl deploy.
	component := MolMyUserComponentImpl instantiate.
	self assert: announcement notNil.
	self assert: announcement component equals: component.
	self assert: announcement componentName equals: MolUtils defaultComponentName.
	announcement := nil.
	
	"test by named instanciation"
	component2 := MolMyUserComponentImpl instantiate: #myComponent.
	self assert: announcement notNil.
	self assert: announcement component equals: component2.
	self assert: announcement componentName equals: #myComponent.
]

{ #category : #tests }
MolComponentAnnouncementTest >> testAnnouncePassivated [

	| announcement component component2 |
	announcement := nil.
	SystemAnnouncer uniqueInstance when: MolComponentPassivated do:[ :a | announcement := a ].

	"test by standard instanciation"
	MolMyUserComponentImpl deploy.
	component := MolMyUserComponentImpl instantiate.
	MolMyUserComponentImpl activate.
	self assert: announcement isNil.
	
	MolMyUserComponentImpl passivate.
	self assert: announcement notNil.
	self assert: announcement component equals: component.
	self assert: announcement componentName equals: MolUtils defaultComponentName.
	announcement := nil.
	
	"test by named instanciation"
	component2 := MolMyUserComponentImpl instantiate: #myComponent.
	MolMyUserComponentImpl activate: #myComponent.
	MolMyUserComponentImpl passivate: #myComponent.
	self assert: announcement notNil.
	self assert: announcement component equals: component2.
	self assert: announcement componentName equals: #myComponent.
]

{ #category : #tests }
MolComponentAnnouncementTest >> testAnnounceRemoved [

	| announcement component component2 |
	announcement := nil.
	SystemAnnouncer uniqueInstance when: MolComponentRemoved do:[ :a | announcement := a ].

	"test by standard instanciation"
	MolMyUserComponentImpl deploy.
	component := MolMyUserComponentImpl instantiate.
	MolMyUserComponentImpl activate.
	MolMyUserComponentImpl passivate.
	self assert: announcement isNil.
	
	MolMyUserComponentImpl remove.
	self assert: announcement notNil.
	self assert: announcement component equals: component.
	self assert: announcement componentName equals: MolUtils defaultComponentName.
	announcement := nil.
	
	"test by named instanciation"
	component2 := MolMyUserComponentImpl instantiate: #myComponent.
	MolMyUserComponentImpl activate: #myComponent.
	MolMyUserComponentImpl passivate: #myComponent.
	self assert: announcement isNil.
	
	MolMyUserComponentImpl remove: #myComponent.
	self assert: announcement notNil.
	self assert: announcement component equals: component2.
	self assert: announcement componentName equals: #myComponent.
]
