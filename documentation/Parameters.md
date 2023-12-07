# Parameters
Parameters are made of data only used at the initialization of a Component which impact its heart, its essential data.
Parameters are not commonly used, instead opting for Services.
Parameters are created in the `componentInitialize` method, which is executed during the **Initialize** state of a component's life-cycle.
Parameters use the `MolComponentParameters` Trait

```smalltalk
Trait named: #MolGNSSDataParameters
	uses: MolComponentParameters
	instanceVariableNames: ''
	package: 'MoleculeTutorial'
```

**add img**
