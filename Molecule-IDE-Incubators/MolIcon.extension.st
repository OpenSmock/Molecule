Extension { #name : #MolIcon }

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon class >> moleculeIncubatorIcon [
	<script: 'self moleculeIncubatorIcon inspect'>
	
	^ self icons at: #incubator ifAbsentPut: [ Form fromBinaryStream: self moleculeIncubatorIconEncoding base64Decoded readStream ]
]

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon class >> moleculeIncubatorIconEncoding [

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAKRAAACkQHAHq1e
AAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAXBJREFUOI2Vkc1KAlEY
hl8H00ls1OJkqGfQNLyGVu66ChFqobsWXUKoORbiLmjlHQht26v7SmmhzC4NkgmLUWbwa1FT
ig7qC9/uPM/5foDVyUIQagCENd4u5ATAFAC5POLjxhI3kxJuj0cHQADIJYrttSXbgYDMOH+9
vCoamUyGZiQvKyUWnFdKBhGRaZq0tkQM+mJMjgws2MoSyeI4dvCsJJ1O/0kgCHe2bdulXKmY
v4udAjhfgHVdp+FwOFej0YiIiG6qVZPxyJubsSP8nBjw+/1+xnk/r5QMVVUpGo3+twiQJEnU
bDYpr5QMJkcGYtAXm5v7ICrXznI5vdvtEud8AW40GvYwAOzL/L3d6VAqlVoKF8qKaQsDwF4k
/NlTVYrH45v9bCV0GHsoXpeNer1OjDFKJpPUarXWgwFAYiyxGw59FcqK0VNVemo/02kuqzPO
+ythAA5L4t3x3o4nk+Mtp3MMh+N+on1caJqmrRJ8A/FKHKvGjPlEAAAAAElFTkSuQmCC'
]

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon class >> moleculeSelectedSearchIcon [
	<script: 'self moleculeSelectedSearchIcon inspect'>

	^ self icons at: #selectedSearch ifAbsentPut: [ Form fromBinaryStream: self moleculeSelectedSearchIconEncoding base64Decoded readStream ]
]

{ #category : #'*Molecule-IDE-Incubators' }
MolIcon class >> moleculeSelectedSearchIconEncoding [

	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAE0SURBVDhPY6AUMEJpFBBUMNNorfHKs1AuTuB/PtSIcXZAgDHj509nGP//ZfjFzef80tj4QL3yob8MWppQZXjAtesMTJy/vq9W5eNhUOHjY+D78W1TQ0OPMFSaKMDE+P8fE8P//1Duf6CXvqhCOUQBpk+cnNG3PnxkuPfxE8MvEfEIh4aGU1A5ogBT5rpNR/8JCub/EhSsS1y+fDNUnGjAONvVaaUSJ1cYiHPj46db2QcPqf9f7PSf6EDkYWF1Z2ZiZABhUXY2ZaDwMogscYDp05+/637//cvw998/hnf//t8EikVBpIgDTOm79yRd/PYt5sKXr4kZe/ZqAwORBSpHFMBIiSAD9isf+k10GECZZAMMAxwYGP5BmUQBrJkpsXqe7DyNJY+gXJyg9kOBEpRJLmBgAABMZmgnybtEbAAAAABJRU5ErkJggg=='
]
