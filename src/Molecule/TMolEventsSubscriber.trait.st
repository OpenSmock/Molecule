Trait {
	#name : #TMolEventsSubscriber,
	#category : #'Molecule-Component Implementation'
}

{ #category : #testing }
TMolEventsSubscriber >> isFoundEventsSubscriber [

	self explicitRequirement 
]

{ #category : #testing }
TMolEventsSubscriber >> isNotFoundEventsSubscriber [

	^ self isFoundEventsSubscriber not
]
