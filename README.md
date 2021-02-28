# flutter_expandable

This is a package that allows widget expansion no matter where the trigger and the expandable widget are in the UI.
This package was born when a ExpansionTile was not enough for our requeriments.

## Getting Started

Import the package to _pubspec.yaml_ file, and you're ready to go.
Just wrap the widgets that will trigger expansion with _ExpanderWidget_ (they should be given as _triggerWidgets_ property) and provide an _AnimationController_.

Then, wrap the widget that will be expanded with _ExpandableWidget_ and provide the same controller that you provided to the Expander, provide a height and you're done! Once you tap the expander, the expandable will animate vertically or horizontally (depending on the properties you've set).

Check out our _example_ for more information
