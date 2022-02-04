"
Class for the icon of a component
--
To encode icons :
(Base64MimeConverter mimeEncode: 'moleculeIcon.png' asFileReference binaryReadStream) contents.
"
Class {
	#name : #MolIcon,
	#superclass : #Object,
	#classInstVars : [
		'moleculeIcon',
		'moleculeComponentIcon',
		'icons'
	],
	#category : #'Molecule-IDE-Assets'
}

{ #category : #tools }
MolIcon class >> cleanIcons [
	<script>

	icons := Dictionary new.
]

{ #category : #accessing }
MolIcon class >> icons [
	<script: 'self icons inspect'>

	icons ifNil: [ icons := Dictionary new ].
	^ icons
]

{ #category : #accessing }
MolIcon class >> moleculeComponentIcon [
	<script: 'self moleculeComponentIcon inspect'>

	^ self icons at: #component ifAbsentPut: [ Form fromBinaryStream: self moleculeComponentIconEncoding base64Decoded readStream ]
]

{ #category : #encoding }
MolIcon class >> moleculeComponentIconEncoding [

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAPCAYAAADtc08vAAAACXBIWXMAAAKxAAACsQFSNozK
AAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAmpJREFUKJFjZMAC/v//
z7R8+fI5Z8+etVRRUbnv7+8fJyUl9QabWqzg8OHDiZKSkn8YGBj+MzEx/V+8ePEMXGqZzczM
qnh4eL6/ffv2Ga+IiBoHL081Oxt7+qEDB4T+/v3L8P//fwZpWVn5O48fajKxsX/5/f37fRQD
Kisrl6SlpaW/fP3a/MnLF30hAQEWOtrawrbW1gzXr19niIiMZDAyMeFWVFA0uHj1SiQXN88/
H0/PAGlpaYN79+6dYkhISLj348eP/5cvX/6bV1T49z8S+PTp0/8/f/7A+QcPH/6fmJT079+/
f//fvXv3LzIycjbzhQsXFkhJSYV6e3sL3755k9Hc3BzuPHZ2dgYmJiY4//27dwyWlpaMEhIS
DJycnIwPHjxgYgoLC9seFBQk//z5cwYBAQG8gauqqsqwYcOG/9CYYrhz585DFjs7O2lWVlbm
2Pj4/1MmT2bEZwA3NzfDynXrfj169Ojk79+/7x86dKiCwdTU9JKTk1MJj6jI34ePHv0nBJS0
tL7yiorawgxlsrOz4+Xh4VHA63Y0oKWs7K+vr2/IwMDAwCImJvY7KysrJSQ8nOHPnz8ENXNz
cLC0tbamnDt3zouBgSGUwcbGpvft27f/Tp069bessgKv87dt3/5/5qyZcH5iYuJZFisrKydu
bm7Gnt7ei7uPHNaSkpZh09XWZmBkRA3P5y9eMDS0tX6XEBa67+frp3bnzp1PT548mcXY09Nz
5/r168/nzp3rySUqasfLzVXD8P+/ErrTmZiZ3nz/9m3+hxevJgYFBc378uXL8V27dk1n0NbW
PsLAwMBLSiAiAwC1tUwQC5xQzwAAAABJRU5ErkJggg=='
]

{ #category : #accessing }
MolIcon class >> moleculeIcon [
	<script: 'self moleculeIcon inspect'>
	
	^ self icons at: #molecule ifAbsentPut: [ Form fromBinaryStream: self moleculeIconEncoding base64Decoded readStream ]
]

{ #category : #encoding }
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
