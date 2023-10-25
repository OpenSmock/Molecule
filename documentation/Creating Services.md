Now that we've created our first component, we will need to connect it to one or multiple Services which are used for transmitting data.
Services host variables (they don't necessarily have the same name as the variables) and need their own Trait.
A Service Trait is typically named after the Type it's used by, in the form of [Type]Services.
It uses the `MolComponentsServices` Trait in its class definition (`uses: MolComponentServices`).
After that, a method is created for every variable that will be transmitted from one component to another.
These methods are typically left empty apart from an eventual comment clarifying their use.
It's in the implementations of these services (classes using a Type Trait linked to a Service Trait) that code execution will be taking place.

To link Services to a component, you first need to place yourself in the class side of a Type Trait then look for the methods that make its contract.
For Services, they're 
- `usedComponentServices`: received by the Trait, for a Component listening for Services
- `providedComponentServices`: created by the Trait, for emitting data

Once you're in these methods, add between the already present curly brackets `{}` the name of the Services Trait that you want to use.
In the case of multiple services, you just need to separate the different Service Traits by a dot.
This will in return add other methods in the implementations of a Type, namely every service in the added Service Trait(s).
The Service Trait added in `usedComponentServices` will in return add a `get[componentName]ServicesProvider` method which will be used for getting all the Services' values.
If you're not getting all the methods you should have, you can click on the **Library** tab of Pharo, then select **Molecule** -> **Debug and Tools**, then click on **Define All Components**. If you're still not getting what you expected, you will need to verify what is put in your component's contract (no empty instance variable for example). Methods related to the Services as well as `get[componentName]ServicesProvider` are automatically generated, there is no need to manually type them.

Since services are not directly linked to a variable, you can edit their name independently from the variables (and execute operations on them).
For example, if you want a service to be sent by `ComponentA`, received through `ComponentB` (with or without modifications) then sent to `ComponentC` (so that only `ComponentB` communicates with `ComponentC`), you can create a method in `ComponentAServices` named `name`, assign it a value in `componentActivate`, then get it in `ComponentB `with this line of code (a variable stocks the service named `name`):
`firstName := self getComponentAServicesProvider name`
Then, `ComponentBServices` needs to have a service named `firstName` (which is an empty method).
`ComponentC` can then call
`name := self getComponentBServicesProvider firstName`
to get this Service's value.
In this example, `ComponentAServices` is written in the `providedComponentServices` method of the `ComponentA` Type Trait and in the `usedComponentServices` of the `ComponentB` Type Trait,
`ComponentBServices` is written in the `providedComponentServices` method of the `ComponentB` Type Trait and in the `usedComponentServices` of the `ComponentC` Type Trait.

The global syntax to get a Service's value is
`self get[componentName]ServicesProvider [serviceName]`

**add img**
