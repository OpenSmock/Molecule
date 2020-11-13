# Molecule

![Molecule Logo](MoleculeBanner.jpg)

Pharo 9 branch - uses sloted Traits, dynamic component update and fix some legacy molecule bugs. 
This branch will become the master branch of Molecule when pharo 9 is in release.

### Installing Molecule

```smalltalk
Metacello new
  githubUser: 'labordep' project: 'Molecule' commitish: 'pharo9' path: 'src';
  baseline: 'Molecule';
  load.
```
