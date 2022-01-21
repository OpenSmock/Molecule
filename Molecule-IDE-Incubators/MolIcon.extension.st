Extension { #name : #MolIcon }

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon >> icon [
	^self class moleculeIcon 
]

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon >> iconSelectedSearch [
	^moleculeIconSelectedSearch ifNil: [ moleculeIconSelectedSearch := Form fromBinaryStream: self moleculeIconSelectedSearch  base64Decoded readStream ]
]

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon >> moleculeIconSelectedSearch [
	^"'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAEvSURBVDhPY6AUMEJpFBBUMNNobcOVs1AuTuDfpGXEODsgwJjx86czjP//Mvzi5nN+aWx8oL7g7d+//L+hynAD5o+sDEycv76vVuXjYVDh42Pg+/FtU0NDjzBUnijAxPj/HxPD//9Q7n+gl76oQjlEAaZPnJzRtz58ZLj38RPDLxHxCIeGhlNQOaIAU+a6TUf/CQrm/xIUrEtcvnwzVJxowDjb1WmlEidXGIhz4+OnW9kHD6n//5D7n+hA5GFhdWdmYmQAYVF2NmWg+DKINHGA6dOfv+t+//3L8PffP4Z3//7fBIpFQaSIA+CE1OPsEM34n4G1eN+BBcBAZNlf8PY3sV7ASImkGsAEZZMNMAxwYGD4B2USBbBmpsTqebLzSs8/gnJxgtrFrkpQJrmAgQEADgBtJjrNR2oAAAAASUVORK5CYII='"
	'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAE0SURBVDhPY6AUMEJpFBBUMNNorfHKs1AuTuB/PtSIcXZAgDHj509nGP//ZfjFzef80tj4QL3yob8MWppQZXjAtesMTJy/vq9W5eNhUOHjY+D78W1TQ0OPMFSaKMDE+P8fE8P//1Duf6CXvqhCOUQBpk+cnNG3PnxkuPfxE8MvEfEIh4aGU1A5ogBT5rpNR/8JCub/EhSsS1y+fDNUnGjAONvVaaUSJ1cYiHPj46db2QcPqf9f7PSf6EDkYWF1Z2ZiZABhUXY2ZaDwMogscYDp05+/637//cvw998/hnf//t8EikVBpIgDTOm79yRd/PYt5sKXr4kZe/ZqAwORBSpHFMBIiSAD9isf+k10GECZZAMMAxwYGP5BmUQBrJkpsXqe7DyNJY+gXJyg9kOBEpRJLmBgAABMZmgnybtEbAAAAABJRU5ErkJggg=='
]

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon >> moleculeIconSelectedSearchStream [
	^moleculeIconSelectedSearch 
]
