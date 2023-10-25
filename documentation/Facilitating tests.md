To create quick tests for your components, you can create a package named [yourPackageName]-Examples or [yourPackageName]-Tests, then create an Object subclass named [yourPackageName]Examples, then display the class side and creating methods to have different test cases.

One practical thing that you can do is putting a `<script>` tag at the start of your methods. This will create a small icon next to your method in order to launch it without the use of a Do It in a Playground. \
**img icon**

A script could look like \
**insert img (component start without name)** \
and another script used to delete active components could be structured like \
**insert "cleanUp" (MolComponentManager cleanUp) method img**

You also need to verify the order of components starting since a component that listens to another needs to be started before the latter one. Otherwise, the event will be sent wthout any component listening to it, rendering it meaningless.

This test space can be useful for switching components on the fly, stopping a component to start another having a different Type (make sure that they have a different name or that the current launched component is stopped before the other of the same Type is launched).

To call another script, you simply have to call it like a regular function with `self [script]` since the `self` here represents the current class (for methods located in the class side).
