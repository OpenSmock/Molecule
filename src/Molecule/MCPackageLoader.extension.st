Extension { #name : #MCPackageLoader }

{ #category : #'*Molecule' }
MCPackageLoader >> announceLoad: aString do: aBlock [
	| returnValue |
	returnValue := nil.
	[ self announceLoadStart: aString ] ensure: [ 
		[ returnValue := aBlock value ] ensure: [ 
			self announceLoadStop: aString ] ].
	^ returnValue
]

{ #category : #'*Molecule' }
MCPackageLoader >> announceLoadStart: aString [
	SystemAnnouncer uniqueInstance announce: (MCPackageLoaderStarted new
		packageLoader: self;
		label: aString; 
		yourself)
]

{ #category : #'*Molecule' }
MCPackageLoader >> announceLoadStop: aString [
	SystemAnnouncer uniqueInstance announce: (MCPackageLoaderStarted new
		packageLoader: self;
		label: aString; 
		yourself)
]

{ #category : #'*Molecule' }
MCPackageLoader >> basicLoadWithNameLike: baseName [

	self validate.
	self useNewChangeSetNamedLike: baseName during: [self basicLoad].
]

{ #category : #'*Molecule' }
MCPackageLoader >> loadWithNameLike: aString [
	
	^ self announceLoad: aString do: [ self basicLoadWithNameLike: aString ]
]
