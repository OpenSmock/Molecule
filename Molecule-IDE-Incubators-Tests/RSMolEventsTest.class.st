Class {
	#name : #RSMolEventsTest,
	#superclass : #TestCase,
	#category : #'Molecule-IDE-Incubators-Tests-Cases'
}

{ #category : #tests }
RSMolEventsTest >> testOnShape [
	| molEvent component announcer subscriptions event announcement |
	molEvent := RSMolEvents new.
	
	component := RSEllipse new.
	
	component 
	when: RSMouseRightClick 
	do:
	[ :evt | | molMenu |
				molEvent selectedShape: component model. 
				molMenu := MolMenu new.
				molMenu selectedComponent: molEvent selectedShape.
				molMenu open: molMenu. ].
	
	announcer := component announcer.
	subscriptions := announcer subscriptions subscriptions asOrderedCollection.
	announcement := subscriptions at:1.
	event := announcement announcementClass.
	
	self assert: event equals: RSMouseRightClick.
]
