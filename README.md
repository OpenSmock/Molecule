# Molecule

![Molecule Logo](MoleculeBanner.jpg)

Molecule is a component oriented framework for Pharo. 
His Component architecture approach provide an adapted structuration to graphic user interface (GUI) or another software application wich need Component features.

Molecule provide a way to describe a software application as a components group. Components communicate by use of services, parameters and events propagation. It is a Pharo implementation of the Lightweight Corba Component Model (Lightweight CCM).
Molecule support completely transparent class augmentation into component (not necessary to add code manually), based on Traits.

## Getting Started

### Prerequisites

Molecule Core has no dependencies.
Package 'Molecule-Benchmarks' requires SMark (https://github.com/smarr/SMark), this package contains benchmarks for working on performances.

### Installing Molecule

Pharo 8 and Pharo 9 : 

```smalltalk
Metacello new
   baseline: 'Molecule';
   repository: 'github://OpenSmock/Molecule/src';
   load.
```
Deprecated version of Molecule (1.1.x) for Pharo 6 and 7 is also available [here](https://github.com/OpenSmock/Molecule/tree/Molecule1.1.x).

### Examples

Examples are available in the package 'Molecule-Examples'.
Before running examples open the Transcript, some results are showed on the Transcript window.

#### Clock System example

```smalltalk
MolMyClockSystem startAlarmExample.
```

This system uses 4 components: a server time send global hour to a clock. The clock send local hour to alarms and to final user (which could be an UI). The final user can change the parameters of the system as alarm time or set manual time for the clock. The alarm is subscribed to clock time, and sounds when it is time.

This system provides a global example of the use of components. 

#### GPS example

```smalltalk
MolGPSExampleLauncher start.
```
More details about examples in the comment of MolGPSExampleLauncher.

First we program a component application that connects to a Global Positioning System (GPS) hardware and displays the GPS data on a view map (just fictitious).
The GPS data and view map are implemented as Molecule components.
In a second way, we reuse an existing non-component class in our Molecule application (MolGPSHardware).
To do so, we augment this class with component behavior.

## Test coverage

DrTest coverage results :
* Pharo 9 build 904 : 80,79%
* Pharo 8.0 : 82.16%

## Credits

* **Pierre Laborde** - *Initial work* - [labordep](https://github.com/labordep)
* **Eric Le Pors** - *Initial work* - [ELePors](https://github.com/ELePors)
* **Nolwenn Fournier** - *Initial work* - [nolwennfournier](https://github.com/nolwennfournier)
* **Alain Plantec** - *Initial work* - [plantec](https://github.com/plantec)

![Molecule Logo](MoleculeLogotype.svg)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
