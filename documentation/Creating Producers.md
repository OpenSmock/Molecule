Producers are used to specify the sender of the Events created by components.
Producers are created using the following syntax:
`self forEvents: [componentName]Events useProducer: #[instanceName]`
with [instanceName] being the name you chose for starting a component (see the last part of [Create a new Molecule component](https://github.com/OpenSmock/Molecule/blob/main/documentation/Create%20a%20new%20Molecule%20component.md)), `default` if no name was used.
Producers are created in the `componentInitialize` method.

For multiple Producers (multiple named launched components of the same Type), the syntax is
`self forEvents: [componentName]Events useAllProducers: [componentNameCollection]`

**to review, not enough detail**

**add img**
