Trait {
	#name : 'TMolEventsNotifier',
	#category : 'Molecule-Component Implementation',
	#package : 'Molecule',
	#tag : 'Component Implementation'
}

{ #category : 'testing' }
TMolEventsNotifier >> isFoundEventsNotifier [

	self explicitRequirement
]

{ #category : 'testing' }
TMolEventsNotifier >> isNotFoundEventsNotifier [

	^ self isFoundEventsNotifier not
]
