"
Class for the icon of a component
"
Class {
	#name : #MolIcon,
	#superclass : #Object,
	#instVars : [
		'moleculeIcon',
		'moleculeIconSelectedSearch'
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
MolIcon >> iconSelectedSearch [
	^moleculeIconSelectedSearch ifNil: [ moleculeIconSelectedSearch := Form fromBinaryStream: self moleculeIconSelectedSearch  base64Decoded readStream ]
]

{ #category : #'as yet unclassified' }
MolIcon >> moleculeIcon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAABcElEQVQ4jaWTTUsCURSG3zvOTEzawPSBRbQpRWiZtQwki7bSIiJXLqOFQe2CmB/gH4ggWlQSgQtbJxYEES1apgtXUbQxndJ0nHtvi8oEv6Z6lpfznHNfDgf4J6TV49LG7lSZy9cMgtROdBBGJaEyQ/ZCIT95NW4JpzCdavDZ70+nHt1UG/UB4B1GExQeMhAU8/3Uq7rgUVWolXJS12MDsuLiHWUA4ByS0scEwpkA/l3MCfDm5Yx2i15HMBQlnC0UkSsaMAfdKwFdvyGCaL/BWiJ5xTQtamraTiQeP7NtfkH2FuZOxpXeZQC4LxrZ9YtL33z0kDn7R1puqJFS/omJLlFadAiftUM98gSAY2qZXeV6BMOiiRqloIwhz3gGwKpDlLusoCECAMSCgTDhkDZT6YOArovii8e0HQEAts7TR3YnNkX4q9i2QQBgVrXE2pzJD4TAqpZoy6rI9v5YLl+7k2Sno51fM8t0dnJ4+pcfbuYD4niENW2FlpcAAAAASUVORK5CYII='
]

{ #category : #'as yet unclassified' }
MolIcon >> moleculeIconSelectedSearch [
	^"'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAEvSURBVDhPY6AUMEJpFBBUMNNobcOVs1AuTuDfpGXEODsgwJjx86czjP//Mvzi5nN+aWx8oL7g7d+//L+hynAD5o+sDEycv76vVuXjYVDh42Pg+/FtU0NDjzBUnijAxPj/HxPD//9Q7n+gl76oQjlEAaZPnJzRtz58ZLj38RPDLxHxCIeGhlNQOaIAU+a6TUf/CQrm/xIUrEtcvnwzVJxowDjb1WmlEidXGIhz4+OnW9kHD6n//5D7n+hA5GFhdWdmYmQAYVF2NmWg+DKINHGA6dOfv+t+//3L8PffP4Z3//7fBIpFQaSIA+CE1OPsEM34n4G1eN+BBcBAZNlf8PY3sV7ASImkGsAEZZMNMAxwYGD4B2USBbBmpsTqebLzSs8/gnJxgtrFrkpQJrmAgQEADgBtJjrNR2oAAAAASUVORK5CYII='"
	'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAE0SURBVDhPY6AUMEJpFBBUMNNorfHKs1AuTuB/PtSIcXZAgDHj509nGP//ZfjFzef80tj4QL3yob8MWppQZXjAtesMTJy/vq9W5eNhUOHjY+D78W1TQ0OPMFSaKMDE+P8fE8P//1Duf6CXvqhCOUQBpk+cnNG3PnxkuPfxE8MvEfEIh4aGU1A5ogBT5rpNR/8JCub/EhSsS1y+fDNUnGjAONvVaaUSJ1cYiHPj46db2QcPqf9f7PSf6EDkYWF1Z2ZiZABhUXY2ZaDwMogscYDp05+/637//cvw998/hnf//t8EikVBpIgDTOm79yRd/PYt5sKXr4kZe/ZqAwORBSpHFMBIiSAD9isf+k10GECZZAMMAxwYGP5BmUQBrJkpsXqe7DyNJY+gXJyg9kOBEpRJLmBgAABMZmgnybtEbAAAAABJRU5ErkJggg=='
]

{ #category : #'as yet unclassified' }
MolIcon >> moleculeIconSelectedSearchStream [
	^moleculeIconSelectedSearch 
]

{ #category : #'as yet unclassified' }
MolIcon >> moleculeIconStream [
	^moleculeIcon 
]
