# Molecule

![Molecule Logo](MoleculeBanner.jpg)

Pharo 9 branch - uses sloted Traits, dynamic component update and fix some legacy molecule bugs. 
This branch will become the master branch of Molecule when pharo 9 is in release.

## Getting Started

### Prerequisites

Molecule has no dependencies, excepting package 'Molecule-Benchmarks' which requires SMark (https://github.com/smarr/SMark).

### Installing Molecule Pharo9 branch

```smalltalk
Metacello new
  githubUser: 'labordep' project: 'Molecule' commitish: 'pharo9' path: 'src';
  baseline: 'Molecule';
  load.
```


## Test coverage

81,68% of Molecule Pharo9 branch is coverage by unit tests, result with DrTest.
