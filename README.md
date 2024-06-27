[![License](https://img.shields.io/github/license/openSmock/Molecule.svg)](./LICENSE)
[![Pharo 11 CI](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo11CI.yml/badge.svg)](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo11CI.yml)
[![Pharo 12 CI](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo12CI.yml/badge.svg)](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo12CI.yml)
[![Pharo 13 CI](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo13CI.yml/badge.svg)](https://github.com/OpenSmock/Molecule/actions/workflows/Pharo13CI.yml)

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

## <img src="/resources/puce.svg" width="32" height="32" align="bottom"> Molecule developer menus

Molecule tries to offer a maximum number of Pharo user interface extensions to create and exploit components.

### Library menu

A Molecule Component system can be monitored and inspected from the dedicated `Molecule library menu`.
![image](https://github.com/OpenSmock/Molecule/assets/49183340/28380e1b-37be-4456-a376-bb8dac70fd3f)

This menu also includes a special section for `Debug and Tools`, providing access to advanced features.
### Contextual menus

There are mutiple accesses to Molecule features from contextual menus.

#### Packages contextual menu:
![image](https://github.com/OpenSmock/Molecule/assets/49183340/1c4f9885-03e0-41dd-90db-eac077b34dcf)

This menu provides `metrics` to have statistics on the Molecule code in selected packages.
![image](https://github.com/OpenSmock/Molecule/assets/49183340/d083047b-ad95-42cf-a7f4-76242d2f6eec)

#### Classes contextual menu:
![image](https://github.com/OpenSmock/Molecule/assets/49183340/ac545c7b-9004-4728-a398-7cca42b0ed54)

This menu provides actions and tools depending on the selected classes.
With this menu you can force to `define` a Component, specially if you have deactivated the Molecule dynamic update or if you have a bug when a Component contract changed.

### See Component implementations
![contextual menu see component implementations](https://github.com/Eliott-Guevel/Molecule-various-fixes/assets/76944457/a4221985-0578-4e95-a133-831548e0f5ef)
When right-clicking a Trait that uses the `MolComponentType` Trait, a new option appears in the `Molecule` sub-menu (as shown above):

![see component implementations github](https://github.com/Eliott-Guevel/Molecule-various-fixes/assets/76944457/68a94948-d6a0-4dce-9c67-2d1974b78fdf)
Clicking this option opens this window, showing all the Component implementations of a Type Trait. \
The title of the window indicates the name of the Type Trait. \
Clicking an implementation activates the Browse button, which is used to open it in the **System Browser** of Pharo (double-clicking also works). \
Typing in the filtering list (above the two window buttons) filters the list of implementations.

### See Component users
![contextual menu see component users](https://github.com/Eliott-Guevel/Molecule-various-fixes/assets/76944457/8a9aaa63-33f8-46ea-a638-fc896fc2a60c)
When right-clicking a interface (that is, a Trait that uses the `MolComponentEvents`, `MolComponentParameters` or `MolComponentServices` Traits), a new option appears in the `Molecule` sub-menu (as shown above):

![See component users github](https://github.com/Eliott-Guevel/Molecule-various-fixes/assets/76944457/682f388b-78a6-41d4-a3c4-2377fb7e9cf5)
The title of the window indicates the name of the Type Trait as well as the type of interfaces it is about (events, parameters or services). \
In columns are shown the Type Trait requiring and offering this interface. \
Clicking a Type Trait activates the Browse button, which is used to open it in the **System Browser** of Pharo (double-clicking also works). \
Typing in a filtering list (below the columns) filters the relevant list of Type Traits.

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
