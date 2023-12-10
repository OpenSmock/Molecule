Class {
	#name : #MCPackageLoaderStopped,
	#superclass : #Announcement,
	#instVars : [
		'packageLoader',
		'label'
	],
	#category : #'Molecule-Announcers'
}

{ #category : #accessing }
MCPackageLoaderStopped >> label [
	^ label
]

{ #category : #accessing }
MCPackageLoaderStopped >> label: anObject [
	label := anObject
]

{ #category : #accessing }
MCPackageLoaderStopped >> packageLoader [

	^ packageLoader
]

{ #category : #accessing }
MCPackageLoaderStopped >> packageLoader: anObject [

	packageLoader := anObject
]
