Class {
	#name : #MolComponentAnnouncement,
	#superclass : #MolAnnouncement,
	#instVars : [
		'component',
		'componentName'
	],
	#category : #'Molecule-Announcements'
}

{ #category : #accessing }
MolComponentAnnouncement >> component [

	^ component
]

{ #category : #accessing }
MolComponentAnnouncement >> component: anObject [

	component := anObject
]

{ #category : #accessing }
MolComponentAnnouncement >> componentName [

	^ componentName
]

{ #category : #accessing }
MolComponentAnnouncement >> componentName: anObject [

	componentName := anObject
]
