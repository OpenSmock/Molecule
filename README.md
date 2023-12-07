[![License](https://img.shields.io/github/license/openSmock/Molecule.svg)](./LICENSE)
[![Pharo 11 CI](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo11CI.yml/badge.svg)](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo11CI.yml)
[![Pharo 12 CI](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo12CI.yml/badge.svg)](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo12CI.yml)

# Molecule

![Molecule Logo](resources/MoleculeBanner.jpg)

Molecule is a component oriented framework for Pharo.
His Component architecture approach provides an adapted structuration to User Interface (UI) or another software application which need Component features.

Molecule provides a way to describe a software application as a component group. Components communicate by use of services, parameters and event propagation. It is a Pharo implementation of the Lightweight Corba Component Model (Lightweight CCM).
Molecule supports completely transparent class augmentation into component (not necessary to add code manually), based on Traits.

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> Documentation

Molecule documentation is available here: [Molecule Documentation Home](https://github.com/OpenSmock/Molecule/blob/main/documentation/Table%20of%20contents.md)

The documentation includes some tutorials, pattern description and examples. 

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> How to get Molecule

You can load the latest development version of Molecule or load a specific stable release with a tag, for example 1.2.10.

Continuous integration (CI) status badges show status of compatibility for all supported Pharo versions. You can use Molecule with your Pharo version when its badge is green ! 

### Latest version

To install the **latest version of Molecule** in Pharo, you just need to execute the following script:

```smalltalk
Metacello new
   baseline: 'Molecule';
   repository: 'github://OpenSmock/Molecule:main/src';
   load.
```

To add in your project **BaselineOf**:

```smalltalk
spec baseline: 'Molecule' with: [ spec repository: 'github://OpenSmock/Molecule:main/src' ].
```

### Specific release

To install a release in your Pharo image you just need to adapt and execute the following script.
Don't forget to adapt the **x.x.x** tag to your wanted release in your script, for example **1.2.11**.

```smalltalk
Metacello new
   baseline: 'Molecule';
   repository: 'github://OpenSmock/Molecule:x.x.x';
   load.
```

To add in your project **BaselineOf**:

```smalltalk
spec baseline: 'Molecule' with: [ spec repository: 'github://OpenSmock/Molecule:x.x.x' ].
```

### Looking for an older Pharo ?

New releases of Molecule don't support old Pharo versions (< 10), but could work.
Find below some Molecule branches for old Pharo versions. 

[Pharo 9 and 10 - last release is 1.2.8](https://github.com/OpenSmock/Molecule/tree/Pharo9-10).

[Pharo 8 - last release is 1.2.7](https://github.com/OpenSmock/Molecule/tree/Pharo8).

[Pharo 6 and 7 - last release is 1.1.1](https://github.com/OpenSmock/Molecule/tree/Pharo6-7).

### Prerequisites

Molecule Core has no dependencies.

Package 'Molecule-Benchmarks' requires SMark (https://github.com/smarr/SMark), this package contains benchmarks for working on performances.

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> Molecule Menu

![image](https://github.com/OpenSmock/Molecule/assets/49183340/ef29b8f4-941a-45a6-b41e-bf6db9f78ec6)

Molecule system can be monitored and controlled from the dedicated `Molecule` library menu.

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> Using Components

### Start and stop method

Components can be used with the start & stop method.

To start a component:

```smalltalk
component := MyComponentClass start.
```

To stop a component: 

```smalltalk
MyComponentClass stop.
```

Components can be identified with a name. To start a component with a specific name:

```smalltalk
componentA := MyComponentClass start: #componentA.
```

To stop a component identified by a name:

```smalltalk
MyComponentClass stop: #componentA.
```

### Component life-cycle method

Components can be used with the life-cycle method, the two methods (start & stop, life-cycle) can be combined.

Starting a component is equivalent to:

```smalltalk
MyComponentClass deploy.
component := MyComponentClass instantiate.
MyComponentClass activate.
```

With a name:

```smalltalk
MyComponentClass deploy.
componentA := MyComponentClass instantiate: #compA.
MyComponentClass activate: #compA.
```

Stopping a component is equivalent to:

```smalltalk
MyComponentClass passivate.
MyComponentClass remove.
MyComponentClass undeploy.
```

With a name:

```smalltalk
MyComponentClass passivate: #compA.
MyComponentClass remove: #compA.
MyComponentClass undeploy.
```

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> Some examples

Examples are available in the package 'Molecule-Examples'.
Open the Transcript before running examples, some results are showed in the Transcript window.

#### Clock System example

```smalltalk
MolMyClockSystem startAlarmExample.
```

This system uses 4 components: a server time sends global hour to a clock. The clock sends local hour to alarms and to the final user (which could be an UI). The final user can change the parameters of the system as alarm time or set a manual time for the clock. The alarm is subscribed to the clock time, and sounds when it's time.

This system provides a global example of the use of components. 

#### Geographical Position example

Examples are further detailed in the comment of MolGeoPosExampleLauncher.

1 - Start the demo: start a GPS equipment and a Map receiver (displaying result on Transcript)

```smalltalk
MolGeoPosExampleLauncher start.
```

2 - Choose between available geographical position equipments:

Change the started component of MolGeoPosEquipmentType Type on the fly.

```smalltalk
MolGeoPosExampleLauncher swapGPSInaccurate.
MolGeoPosExampleLauncher swapGSM.
MolGeoPosExampleLauncher swapGalileo.
MolGeoPosExampleLauncher swapWiFi.
MolGeoPosExampleLauncher swapGPS.
```

3 - To stop the demo:

```smalltalk
MolGeoPosExampleLauncher stop.
```

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> To know more...

Publications related to Molecule:

[Molecule: live prototyping with component-oriented programming](https://inria.hal.science/hal-02966704/)

[15 Years of Reuse Experience in Evolutionary Prototyping for the Defense Industry](https://inria.hal.science/hal-02966691/preview/ICSR_15years.pdf)

[Reuse in component-based prototyping: an industrial experience report from 15 years of reuse](https://link.springer.com/article/10.1007/s11334-022-00456-4)

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> Credits

* **Pierre Laborde** - *Initial work* - [labordep](https://github.com/labordep)
* **Eric Le Pors** - *Initial work* - [ELePors](https://github.com/ELePors)
* **Nolwenn Fournier** - *Initial work* - [nolwennfournier](https://github.com/nolwennfournier)
* **Alain Plantec** - *Initial work* - [plantec](https://github.com/plantec)
* **Lisa Doyen** - *UI Components Tools* - [lisadoyen](https://github.com/lisadoyen)

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
