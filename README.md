# Molecule

Molecule is a component oriented framework for Pharo. 
His Component architecture approach provide an adapted structuration to graphic user interface (GUI) or another software application wich need Component features.

Molecule provide a way to describe a software application as a components group. Components communicate by use of services, parameters and events propagation. It is a Pharo implementation of the Lightweight Corba Component Model (Lightweight CCM).

Molecule is working on Pharo 6 and Pharo 7.

## Getting Started

### Prerequisites

Molecule has no dependencies.

### Installing Molecule

```smalltalk
Metacello new
   baseline: 'Molecule';
   repository: 'github://labordep/molecule/src';
   load.
```

### Example

An example is available in the package 'Molecule-Examples'.
Before running the example open the Transcript, the example results is showed on the Transcript window.

```smalltalk
MolMyClockSystem startAlarmExample.
```

This system uses 4 components: a server time send global hour to a clock. The clock send local hour to alarms and to final user (which could be an UI). The final user can change the parameters of the system as alarm time or set manual time for the clock. The alarm is subscribed to clock time, and sounds when it is time.

This system provides a global example of the use of components. 

## Credits

Authors: Pierre Laborde, Eric Le Pors, Nolwenn Fournier, Alain Plantec. 

* **Pierre Laborde** - *Initial work* - [labordep](https://github.com/labordep)
* **Eric Le Pors** - *Initial work*
* **Nolwenn Fournier** - *Initial work* - [nolwennfournier](https://github.com/nolwennfournier)
* **Alain Plantec** - *Initial work* - [plantec](https://github.com/plantec)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
