"
Class for the icon of a component
"
Class {
	#name : #MolIcon,
	#superclass : #Object,
	#instVars : [
		'moleculeIcon'
	],
	#classInstVars : [
		'moleculeIcon'
	],
	#category : #'Molecule-IDE-Incubators-Icon'
}

{ #category : #accessing }
MolIcon >> icon [
	^moleculeIcon ifNil: [ moleculeIcon := Form fromBinaryStream: self moleculeIcon base64Decoded readStream ]
]

{ #category : #'as yet unclassified' }
MolIcon >> moleculeIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAABcElEQVQ4jaWTTUsCURSG3zvOTEzawPSBRbQpRWiZtQwki7bSIiJXLqOFQe2CmB/gH4ggWlQSgQtbJxYEES1apgtXUbQxndJ0nHtvi8oEv6Z6lpfznHNfDgf4J6TV49LG7lSZy9cMgtROdBBGJaEyQ/ZCIT95NW4JpzCdavDZ70+nHt1UG/UB4B1GExQeMhAU8/3Uq7rgUVWolXJS12MDsuLiHWUA4ByS0scEwpkA/l3MCfDm5Yx2i15HMBQlnC0UkSsaMAfdKwFdvyGCaL/BWiJ5xTQtamraTiQeP7NtfkH2FuZOxpXeZQC4LxrZ9YtL33z0kDn7R1puqJFS/omJLlFadAiftUM98gSAY2qZXeV6BMOiiRqloIwhz3gGwKpDlLusoCECAMSCgTDhkDZT6YOArovii8e0HQEAts7TR3YnNkX4q9i2QQBgVrXE2pzJD4TAqpZoy6rI9v5YLl+7k2Sno51fM8t0dnJ4+pcfbuYD4niENW2FlpcAAAAASUVORK5CYII='
]
