Class {
	#name : #PyMolSwitch,
	#superclass : #BlElement,
	#traits : 'TPyramidSton',
	#classTraits : 'TPyramidSton classTrait',
	#instVars : [
		'indicator',
		'state',
		'whenOffDo',
		'whenOnDo'
	],
	#category : #'Molecule-Incubator-Pyramid-Examples'
}

{ #category : #'pyramid-serialized-bloc' }
PyMolSwitch class >> pystonSpec [
	"This class has been generated using Pyramid.

	By: YannLEGOFF
	2023-06-20 14:50:06"

	<pySTON>
	^ '[
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 30.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 30.0
				}
			},
			#position : Point [ 32.5, 0.0 ],
			#margin : BlInsets {
				#top : 0.0,
				#left : 0.0,
				#bottom : 0.0,
				#right : 0.0
			},
			#padding : @10,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : Float [ #infinity ],
			#maxWidth : @11,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#geometry : BlEllipseGeometry {
				#extent : Point [ 30.0, 30.0 ],
				#pathCache : BlPathCache {
					#geometry : @13,
					#strokedBounds : BlBounds {
						#left : 0.0,
						#top : 0.0,
						#right : 30.0,
						#bottom : 30.0
					}
				}
			},
			#background : BlPaintBackground {
				#paint : BlRadialGradientPaint {
					#stops : [
						0 : Color [ #black ],
						1 : Color {
							#red : 0.8914956011730205,
							#green : 0.8914956011730205,
							#blue : 0.8914956011730205,
							#alpha : 1.0
						}
					],
					#center : Point [ 15.0, 15.0 ],
					#radius : 17.0
				}
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #base
			}
		},
		#layout : BlBasicLayout { },
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @2,
			#handlers : [ ]
		}
	},
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 15.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 50.0
				}
			},
			#position : Point [ 40, 7.5 ],
			#margin : @10,
			#padding : @10,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @11,
			#maxWidth : @11,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#geometry : BlRoundedRectangleGeometry {
				#extent : Point [ 50.0, 15.0 ],
				#pathCache : BlPathCache {
					#geometry : @37,
					#strokedBounds : BlBounds {
						#left : 0.0,
						#top : 0.0,
						#right : 50.0,
						#bottom : 15.0
					}
				},
				#cornerRadii : BlCornerRadii {
					#topLeft : 20,
					#topRight : 20,
					#bottomLeft : 20,
					#bottomRight : 20
				},
				#center : Point [ 25.0, 7.5 ]
			},
			#background : BlPaintBackground {
				#paint : BlColorPaint {
					#color : Color {
						#red : 0.5884652981427175,
						#green : 0.5454545454545454,
						#blue : 0.42717497556207235,
						#alpha : 1.0
					}
				}
			},
			#visibility : BlVisibilityHidden { }
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #stickTrue
			}
		},
		#layout : @25,
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @28,
			#handlers : [ ]
		}
	},
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 25.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 25.0
				}
			},
			#position : Point [ 70, 2.5 ],
			#margin : @10,
			#padding : @10,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @11,
			#maxWidth : @11,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#geometry : BlEllipseGeometry {
				#extent : Point [ 25.0, 25.0 ],
				#pathCache : BlPathCache {
					#geometry : @60,
					#strokedBounds : BlBounds {
						#left : 0.0,
						#top : 0.0,
						#right : 25.0,
						#bottom : 25.0
					}
				}
			},
			#background : BlPaintBackground {
				#paint : BlRadialGradientPaint {
					#stops : [
						0 : @20,
						1 : @21
					],
					#center : Point [ 12.5, 12.5 ],
					#radius : 17.0
				}
			},
			#visibility : @46
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #topTrue
			}
		},
		#layout : @25,
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @51,
			#handlers : [ ]
		}
	},
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 15.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 50.0
				}
			},
			#position : Point [ 5, 7.5 ],
			#margin : BlInsets {
				#top : 0.0,
				#left : 0.0,
				#bottom : 0.0,
				#right : 0.0
			},
			#padding : @80,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @11,
			#maxWidth : @11,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#geometry : BlRoundedRectangleGeometry {
				#extent : Point [ 50.0, 15.0 ],
				#pathCache : BlPathCache {
					#geometry : @82,
					#strokedBounds : BlBounds {
						#left : 0.0,
						#top : 0.0,
						#right : 50.0,
						#bottom : 15.0
					}
				},
				#cornerRadii : BlCornerRadii {
					#topLeft : 20,
					#topRight : 20,
					#bottomLeft : 20,
					#bottomRight : 20
				},
				#center : Point [ 25.0, 7.5 ]
			},
			#background : @43,
			#visibility : BlVisibilityVisible { }
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #stickFalse
			}
		},
		#layout : BlBasicLayout { },
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @72,
			#handlers : [ ]
		}
	},
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 25.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 25.0
				}
			},
			#position : Point [ 0.0, 2.5 ],
			#margin : @80,
			#padding : @80,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @11,
			#maxWidth : @11,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#geometry : BlEllipseGeometry {
				#extent : Point [ 25.0, 25.0 ],
				#pathCache : BlPathCache {
					#geometry : @103,
					#strokedBounds : BlBounds {
						#left : 0.0,
						#top : 0.0,
						#right : 25.0,
						#bottom : 25.0
					}
				}
			},
			#background : @64
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #topFalse
			}
		},
		#layout : @91,
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @94,
			#handlers : [ ]
		}
	}
]'
]

{ #category : #initialization }
PyMolSwitch >> initialize [

	super initialize.
	self buildElements.
	self size: 125 @ 30.
	self when: BlClickEvent do: [ :evt | self state: self state not ].
	state := false.
	whenOffDo := [  ].
	whenOnDo := [  ].
]

{ #category : #accessing }
PyMolSwitch >> state [

	^ state
]

{ #category : #accessing }
PyMolSwitch >> state: aBoolean [

	state = aBoolean ifTrue: [ ^ self ].
	state := aBoolean.
	aBoolean
		ifTrue: [
			(self childNamed: #topFalse) visibility: BlVisibility hidden.
			(self childNamed: #stickFalse) visibility: BlVisibility hidden.
			(self childNamed: #topTrue) visibility: BlVisibility visible.
			(self childNamed: #stickTrue) visibility: BlVisibility visible.
			self whenOnDo value ]
		ifFalse: [
			(self childNamed: #topTrue) visibility: BlVisibility hidden.
			(self childNamed: #stickTrue) visibility: BlVisibility hidden.
			(self childNamed: #topFalse) visibility: BlVisibility visible.
			(self childNamed: #stickFalse) visibility: BlVisibility visible.
			self whenOffDo value ]
]

{ #category : #accessing }
PyMolSwitch >> whenOffDo [

	^ whenOffDo
]

{ #category : #accessing }
PyMolSwitch >> whenOffDo: aBlock [

	whenOffDo:= aBlock
]

{ #category : #accessing }
PyMolSwitch >> whenOnDo [

	^ whenOnDo
]

{ #category : #accessing }
PyMolSwitch >> whenOnDo: aBlock [

	whenOnDo := aBlock
]
