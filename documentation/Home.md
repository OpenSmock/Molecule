Welcome to the Molecule wiki!

# Principles
This section briefly presents what is a Molecule component and how it's dynamically managed.

# A Component and his Contract
![Molecule component](https://user-images.githubusercontent.com/49183340/162572734-774a7065-9772-433e-8f0a-9dc538978c92.png) \
Similarly to the LCCM, a component’s business contract is exposed through its component Type. The Type specifies what a component has to offer to other components (namely, provided services and produced events) and what that component requires from other components (namely, used services and consumed events).
![Component application](https://user-images.githubusercontent.com/49183340/162572946-8cd11257-65bb-4ed3-a13a-0fe6dd6f83d1.png)

Thus, the main role of the Type is to implement the services that the component provides (Provided Services) and that are callable by other components. Other components use this interface through their Used Services interface. Produced Events represent the receivable events interface of the component. Other components listen to this interface through their Consumed Events interface. They subscribe and unsubscribe to their event interface to start and stop receiving notifications. Parameters are used to control the component’s state. Parameters can only be used once at the component’s initialization. The light-weight CCM model does not define Parameters, but instead allows direct access to public attributes. We introduced the Provided Parameters as an interface to explicitly define how the state of a component can be initialized. Other components use this interface through their Used Parameters interface.
![Component contract](https://user-images.githubusercontent.com/49183340/162573113-d347a649-b84e-4b0f-bb75-f3f1380b43f2.png)

A Molecule component definition is based on Traits. The Type, as well as the services, the events and the parameters are all defined as Traits. A Molecule component is an instance of a standard class which uses Molecule traits.

# Two ways to implement a Component
![Two ways to implement a component](https://user-images.githubusercontent.com/49183340/162573288-4d7fc513-5d98-420e-a309-e98f1e42fc6d.png) \
In Molecule, we define the elements of a component's contract (services, events, parameters) as a set of Traits. A component Type aggregates theses traits and is itself defined as a Trait. Molecule provides a dedicated Trait `MolComponentImpl`, which implements cross-cutting behavior shared by all components (e.g., components' life-cycle management). Implementing a component consists in defining a class that uses the `MolComponentImpl` Trait to obtain component shared behavior and uses a Type Trait (`MolComponentType`) implementing the component's business behavior.
![Component application and other](https://user-images.githubusercontent.com/49183340/162573410-9543b74f-af2f-4ad9-a156-aa4759916773.png)

The direct benefit of this approach is that it's possible for any existing class to become a component. This existing class is then turned as (or augmented as) a component, and becomes usable in a Molecule component application while remaining fully compatible with non-component applications.

# Run-time management of Components
![ComponentManager](https://user-images.githubusercontent.com/49183340/162572598-0219f49d-8975-4dbb-8764-e3f379c58d69.png)
All components are managed by the ComponentManager object. It maintains the list of component instances currently alive in the system. It's currently handled as a singleton. The ComponentManager class implements an API to instantiate and to remove each component, to associate them, to connect events, etc. This API is used to manage each component's life-cycle programmatically.

# Components' life-cycle and states
The activity of a component depends on contextual constraints such as the availability of a resource, the physical state of hardware elements, etc. To manage consumed resources accordingly, the life-cycle of a component has four possible states: Initialized, Activated, Passivated and Removed. \
![Components lifecycle and states](https://user-images.githubusercontent.com/49183340/162570154-b39fc041-03f3-40d2-ad3f-30aac027a4b0.png)

After its initialization, a component can switch from an Activated state to a Passivated state and conversely. When the life-cycle of a component is over, then it switches to the Removed state.
![ComponentManager states](https://user-images.githubusercontent.com/49183340/162572394-03d8bdda-e447-4095-864e-2793b913616c.png)

Let us detail every state of a component's life-cycle.

When a component is switched to the Initialized state, it's configured through its provided parameters. If a component depends on another component through its interfaces (used services, consumed events or used parameters), these components are associated during this state.

The Activated state is the nominal state of a component. When a component is switched to this state, it subscribes to each consumed event that is produced by the components that have been associated with it during the Initialized state. After this subscription step, the component is able to receive and react accordingly to any of its consumed events.

When a component is paused, it switches to the Passivated state. Then, the component unsubscribes to its subscribed events and all its required resources are set in waiting mode. As an example, a hardware can be set in its sleeping mode, it can also be asked to free its Graphics Processing Unit memory. The idea behind this state is to avoid consuming resources if not needed, and to be able to switch back as quickly as possible to the Activated state.

The terminal state of a component is the Removed state. When a component switches to this state, all of its resources are released. The ComponentManager removes that component from its list of alive components.

Let us illustrate the use of these states with the example of a GUI window handled as a component. First, the window is instantiated by the component. Then the component state switches to Initialized. When the window is displayed on the desktop, the component’s state switches to Activated. When the window is reduced and its icon is stored into a task-bar, then the component switches to the Passivated state. As the window is only reduced, it can be re-opened very quickly. Finally, when the user closes the window, the component is first switched to Passivated, then to the Removed state.

# Tutorial section
[Connecting two components](https://github.com/OpenSmock/Molecule/blob/main/documentation/Connecting%20two%20components.md) \
[Create a new Molecule Component](https://github.com/OpenSmock/Molecule/blob/main/documentation/Create%20a%20new%20Molecule%20component.md) \
[Creating Events](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Events.md) \
[Creating Notifiers](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Notifiers.md) \
[Creating Parameters](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Parameters.md) \
[Creating Producers](https://github.com/OpenSmock/Molecule/blob/main/documentation/Creating%20Producers.md) \
[Facilitating tests](https://github.com/OpenSmock/Molecule/blob/main/documentation/Facilitating%20tests.md)

# External links
## Publications
[Molecule: live prototyping with component-oriented programming](https://inria.hal.science/hal-02966704/)
[15 years of reuse experience in evolutionary prototyping for the defense industry](https://inria.hal.science/hal-02966691/preview/ICSR_15years.pdf)
## Videos
[Molecule: live prototyping with component-oriented programming](https://www.youtube.com/watch?v=Zfo3VkH2bVw)
[15 years of reuse experience in evolutionary prototyping for the defense industry](https://www.youtube.com/watch?v=Zfo3VkH2bVw)
## Specifications
[Learn more about CCM specifications](https://www.omg.org/spec/CCM/About-CCM/)
