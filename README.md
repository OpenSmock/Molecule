# Molecule
Molecule is a component oriented framework for Pharo

It is a Pharo implementation of the Lightweight Corba Component Model (Lightweight CCM).
Molecule provide a way to describe a software application as a components group. Components communicate by use of services, parameters and events propagation.

## Installing Molecule

```smalltalk
Metacello new
   baseline: 'Molecule';
   repository: 'github://labordep/molecule/src';
   load.
```
