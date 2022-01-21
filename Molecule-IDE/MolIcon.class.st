"
Class for the icon of a component
--
To encode icons :
(Base64MimeConverter mimeEncode: 'moleculeIcon.png' asFileReference binaryReadStream) contents.
"
Class {
	#name : #MolIcon,
	#superclass : #Object,
	#instVars : [
		'moleculeIconSelectedSearch'
	],
	#classInstVars : [
		'moleculeIcon'
	],
	#category : #'Molecule-IDE-Assets'
}

{ #category : #accessing }
MolIcon class >> moleculeIcon [
	<script: 'self moleculeIcon inspect'>
	"moleculeIcon := nil"

	^ moleculeIcon ifNil: [ moleculeIcon := Form fromBinaryStream: self moleculeIconEncoding base64Decoded readStream ]
]

{ #category : #accessing }
MolIcon class >> moleculeIconEncoding [

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAACXBIWXMAAAMnAAADJwEZpzWL
AAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAo5JREFUOI2Nk01PE1EU
hg+XaaftOC0dZqZlOq2gcYVoUtc2JIJsIC50a0gwMRoMAdEEEyPRBUEIYAiEjwai0YSVir/B
lXGDKK3soRFkXFDKcOfjHhemhJYPeXY3uc+5uXnPWwlHoWkBgfd0BsPS60BQ7CQ+D2dXhb9D
Pm+XX60oOxNBkdo9nHeQ4zjpbkcHBwAwMzfnuK5r2I71pPD7zxsAYIceFSLhBkmr+Sqqivug
p5ttbG6iYRiIiGgYBj598ZyFohG3Khr5FpDlZKksy49FVXEaW1rsTDaL67kc3u/qwrBWgwfJ
ZLOYam62RFVxBFl+BAAAwajaH4qoznQ6jZRSHB0fRyWu48UrSXy3sICMsZIhruviVHoWQxHV
CUbVflDi+tLA8BDuFArYdusmynoMh8fGkFKKx+G6Lg4MD6ES15c423HqEnochEAA7rS3w/jI
CNQmzh4ZDgBAV+9DaEylIK7rYNtOLccY8/n9PgAAuNHadqxYZGl5GWKxGJyvOwcMGU8YY5zX
y/9XLMJxHNA9CjzPA2PMQ05tHgMhhNiWRU8tmKYJvI8HSikQQmxCCKG7pgkAAB8+LcLP1dUT
B1xuuAQxTQNzzwRSQeh+jPl8Hq+3tWJ1TMOXoyO4d0KMjuPsx7i/SJMz00gpxVcTE6gm4lif
TOL7xY9H7sDkzHRxkZ4BAIAgy72iqtip5iZrJZPB9VwOO7u7UU3ES+QfmRW82nTNElXFFmSp
p+RvQUW5ENZqPhfL9GtjA7e3txERccvYwt6+PiaqihuKRr+ckaT6one4ztXVt71ezyCprJSL
dZ6dn3eY625Zlt1XMIy3cKDO5QP+oet+ge7e9Xl99wAAqEWndnh/GtbWzPKrfwGEP5aMMZQO
3wAAAABJRU5ErkJggg=='
]
