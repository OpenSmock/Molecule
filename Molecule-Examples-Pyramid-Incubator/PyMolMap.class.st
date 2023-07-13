Class {
	#name : #PyMolMap,
	#superclass : #BlElement,
	#traits : 'MolGPSMap + MolGPSDataEvents + MolComponentImpl',
	#classTraits : 'MolGPSMap classTrait + MolGPSDataEvents classTrait + MolComponentImpl classTrait',
	#instVars : [
		'pointerV',
		'pointerH',
		'pointer'
	],
	#category : #'Molecule-Examples-Pyramid-Incubator'
}

{ #category : #'pyramid-serialized-bloc' }
PyMolMap class >> pystonSpec [
	"This class has been generated using Pyramid.

	By: YannLEGOFF
	2023-06-26 10:39:49"

	<pySTON>
	^ '[
	BlElement {
		#children : BlChildrenArray [
			BlElement {
				#children : BlChildrenArray [ ],
				#constraints : BlLayoutCommonConstraints {
					#vertical : BlLayoutCommonConstraintsAxis {
						#resizer : BlLayoutExactResizer {
							#size : 50.0
						}
					},
					#horizontal : BlLayoutCommonConstraintsAxis {
						#resizer : @8
					},
					#position : Point [ 80, 0.0 ],
					#margin : BlInsets {
						#top : 0.0,
						#left : 0.0,
						#bottom : 0.0,
						#right : 0.0
					},
					#padding : @11,
					#minHeight : 0.0,
					#minWidth : 0.0,
					#maxHeight : Float [ #infinity ],
					#maxWidth : @12,
					#ignoredByLayout : false,
					#accountTransformation : false
				},
				#visuals : BlCustomVisuals {
					#geometry : BlPolygonGeometry {
						#extent : Point [ 50.0, 50.0 ],
						#pathCache : BlPathCache {
							#geometry : @14
						},
						#vertices : [
							Point [ 129.0, 165.0 ],
							Point [ 126.0, 138.0 ],
							Point [ 132.0, 108.0 ],
							Point [ 151.5, 97.5 ],
							Point [ 190.5, 79.5 ],
							Point [ 228.0, 75.0 ],
							Point [ 240.0, 85.5 ],
							Point [ 247.5, 75.0 ],
							Point [ 265.5, 75.0 ],
							Point [ 277.5, 64.5 ],
							Point [ 295.5, 75.0 ],
							Point [ 322.5, 88.5 ],
							Point [ 322.5, 343.5 ],
							Point [ 295.5, 327.0 ],
							Point [ 276.0, 306.0 ],
							Point [ 250.5, 313.5 ],
							Point [ 237.0, 327.0 ],
							Point [ 213.0, 328.5 ],
							Point [ 193.5, 327.0 ],
							Point [ 192.0, 288.0 ],
							Point [ 180.0, 277.5 ],
							Point [ 163.5, 267.0 ],
							Point [ 151.5, 262.5 ],
							Point [ 132.0, 256.5 ],
							Point [ 139.5, 247.5 ],
							Point [ 166.5, 247.5 ],
							Point [ 192.0, 241.5 ],
							Point [ 219.0, 238.5 ],
							Point [ 216.0, 223.5 ],
							Point [ 210.0, 211.5 ],
							Point [ 201.0, 207.0 ],
							Point [ 181.5, 201.0 ],
							Point [ 172.5, 208.5 ],
							Point [ 169.5, 217.5 ],
							Point [ 169.5, 199.5 ],
							Point [ 165.0, 192.0 ],
							Point [ 157.5, 193.5 ],
							Point [ 159.0, 189.0 ],
							Point [ 165.0, 187.5 ],
							Point [ 166.5, 178.5 ],
							Point [ 177.0, 186.0 ],
							Point [ 198.0, 183.0 ],
							Point [ 210.0, 186.0 ],
							Point [ 223.5, 190.5 ],
							Point [ 220.5, 181.5 ],
							Point [ 214.5, 175.5 ],
							Point [ 195.0, 166.5 ],
							Point [ 178.5, 165.0 ],
							Point [ 172.5, 163.5 ],
							Point [ 144.0, 171.0 ]
						]
					},
					#border : BlBorder {
						#paint : BlColorPaint {
							#color : Color {
								#red : 0.0801564027370479,
								#green : 0.07917888563049853,
								#blue : 0.07917888563049853,
								#alpha : 1.0
							}
						},
						#width : 1,
						#style : BlStrokeStyle {
							#lineCap : BlStrokeLineButtCap { },
							#lineJoin : BlStrokeLineMiterJoin { },
							#miterLimit : 4.0,
							#dashArray : [ ],
							#dashOffset : 0.0
						},
						#opacity : 1.0
					},
					#background : BlPaintBackground {
						#paint : BlColorPaint {
							#color : Color {
								#red : 0.83088954056696,
								#green : 0.83088954056696,
								#blue : 0.83088954056696,
								#alpha : 1.0
							}
						}
					}
				},
				#userData : IdentityDictionary {
					#elementId : BlElementNamedId {
						#identifier : #shore
					}
				},
				#layout : BlBasicLayout { },
				#eventDispatcher : BlElementEventDispatcher {
					#owner : @4,
					#handlers : [ ]
				}
			}
		],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 400.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 400.0
				}
			},
			#position : Point [ 0.0, 0.0 ],
			#margin : @11,
			#padding : @11,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @12,
			#maxWidth : @12,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#background : BlPaintBackground {
				#paint : BlRadialGradientPaint {
					#stops : [
						0 : Color {
							#red : 0.30498533724340177,
							#green : 0.6021505376344086,
							#blue : 0.9931573802541545,
							#alpha : 1.0
						},
						1/2 : Color {
							#red : 0.0,
							#green : 0.3597262952101662,
							#blue : 0.83088954056696,
							#alpha : 1.0
						},
						1 : Color {
							#red : 0.0,
							#green : 0.22482893450635386,
							#blue : 0.520039100684262,
							#alpha : 1.0
						}
					],
					#center : Point [ 300.0, 200.0 ],
					#radius : 200.0
				}
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #map
			}
		},
		#layout : @80,
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
					#size : 400.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 2.0
				}
			},
			#position : Point [ 0.0, 0.0 ],
			#margin : BlInsets {
				#top : 0.0,
				#left : 0.0,
				#bottom : 0.0,
				#right : 0.0
			},
			#padding : @109,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @12,
			#maxWidth : @12,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#background : BlPaintBackground {
				#paint : BlColorPaint {
					#color : Color {
						#red : 0.2404692082111437,
						#green : 1.0,
						#blue : 0.2404692082111437,
						#alpha : 1.0
					}
				}
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #pointerV
			}
		},
		#layout : BlBasicLayout { },
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @101,
			#handlers : [ ]
		}
	},
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 2.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 400.0
				}
			},
			#position : Point [ 0.0, 0.0 ],
			#margin : @109,
			#padding : @109,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @12,
			#maxWidth : @12,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#background : @111
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #pointerH
			}
		},
		#layout : @116,
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @119,
			#handlers : [ ]
		}
	},
	BlElement {
		#children : BlChildrenArray [ ],
		#constraints : BlLayoutCommonConstraints {
			#vertical : BlLayoutCommonConstraintsAxis {
				#resizer : BlLayoutExactResizer {
					#size : 50.0
				}
			},
			#horizontal : BlLayoutCommonConstraintsAxis {
				#resizer : @136
			},
			#position : Point [ 0.0, 0.0 ],
			#margin : @109,
			#padding : @109,
			#minHeight : 0.0,
			#minWidth : 0.0,
			#maxHeight : @12,
			#maxWidth : @12,
			#ignoredByLayout : false,
			#accountTransformation : false
		},
		#visuals : BlCustomVisuals {
			#geometry : BlEllipseGeometry {
				#extent : Point [ 50.0, 50.0 ],
				#pathCache : BlPathCache {
					#geometry : @140
				}
			},
			#border : BlBorder {
				#paint : BlColorPaint {
					#color : Color [ #green ]
				},
				#width : 2,
				#style : BlStrokeStyle {
					#lineCap : @72,
					#lineJoin : @73,
					#miterLimit : 4.0,
					#dashArray : @74,
					#dashOffset : 0.0
				},
				#opacity : 1.0
			},
			#background : BlPaintBackground {
				#paint : BlColorPaint {
					#color : Color {
						#red : 0.552297165200391,
						#green : 1.0,
						#blue : 0.5268817204301075,
						#alpha : 0.5764705882352941
					}
				}
			}
		},
		#userData : IdentityDictionary {
			#elementId : BlElementNamedId {
				#identifier : #pointer
			}
		},
		#layout : @116,
		#eventDispatcher : BlElementEventDispatcher {
			#owner : @132,
			#handlers : [ ]
		}
	}
]'
]

{ #category : #'as yet unclassified' }
PyMolMap >> buildElements [

	self hasChildren ifTrue: [ self removeChildren ].
	self addChildren: self class pystonSpec materializeAsBlElement
]

{ #category : #'life cycle' }
PyMolMap >> componentActivate [

	self getMolGPSDataEventsSubscriber subscribe: self
]

{ #category : #'life cycle' }
PyMolMap >> componentPassivate [

	self space ifNotNil: [ :s | s close ].
	self getMolGPSDataEventsSubscriber unsubscribe: self
]

{ #category : #events }
PyMolMap >> currentPositionChanged: aGeoPosition [

	| adjustedPosition radius |
	adjustedPosition := aGeoPosition * 50 asPoint + 150 asPoint.
	radius := self getMolGPSDataServicesProvider getAccuracyRadiusInMeters asPoint.

	pointerV position: adjustedPosition x @ 0.
	pointerH position: 0 @ adjustedPosition y.
	pointer position: adjustedPosition - (radius / 2) asPoint.
	pointer size: radius
		
]

{ #category : #'component accessing' }
PyMolMap >> getMolGPSDataEventsSubscriber [
	| eventsSymbol eventsSubscriber itf |
	itf := MolGPSDataEvents.
	eventsSymbol := self eventsSubscribers at: itf ifAbsent: [^MolNotFoundEventsSubscriber new interface: itf name: nil].
	eventsSymbol isCollection
	 	ifTrue: 
			[eventsSubscriber := MolComponentManager default locatorServices 
						searchEventsSubscriberFor: MolGPSDataEvents named: eventsSymbol ]. 
	^eventsSubscriber
]

{ #category : #'component accessing' }
PyMolMap >> getMolGPSDataServicesProvider [
	| servicesSymbol servicesProvider itf |

	itf := MolGPSDataServices.
	servicesSymbol := self servicesProviders at: itf ifAbsent: [nil].
	(servicesSymbol isNil or:[servicesSymbol isSymbol not]) ifTrue: [ ^ MolNotFoundServicesProvider new interface: itf name: nil ].

	servicesProvider := MolComponentManager default locatorServices searchServicesProviderFor: MolGPSDataServices named: servicesSymbol.
	^servicesProvider
]

{ #category : #'life cycle' }
PyMolMap >> initialize [

	super initialize.
	self buildElements.
	pointerV := self childNamed: #pointerV.
	pointerH := self childNamed: #pointerH.
	pointer := self childNamed: #pointer.
	self clipChildren: true.
	self size: 400 asPoint.
]
