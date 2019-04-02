"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMolecule,
	#superclass : #PackageManifest,
	#category : #'Molecule-Core'
}

{ #category : #'meta-data' }
ManifestMolecule class >> description [ ^ 'Molecule is a component model framework.

It is a Pharo implementation of the Lightweight Corba Component Model.
Molecule provide  a way to describe a software application as a components group. Components communicate by use of services, parameters and events propagation.'
]
