Class {
	#name : #MCPackageLoaderStarted,
	#superclass : #Announcement,
	#instVars : [
		'packageLoader',
		'label'
	],
	#category : #'Molecule-Announcers'
}

{ #category : #accessing }
MCPackageLoaderStarted >> label [

	^ label
]

{ #category : #accessing }
MCPackageLoaderStarted >> label: anObject [

	label := anObject
]

{ #category : #accessing }
MCPackageLoaderStarted >> packageLoader [

	^ packageLoader
]

{ #category : #accessing }
MCPackageLoaderStarted >> packageLoader: anObject [

	packageLoader := anObject
]
