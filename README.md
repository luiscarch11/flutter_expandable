# flutter_expandable

This is a package that allows widget expansion no matter where the trigger and the expandable widget are in the UI.
This package was born when a ExpansionTile was not enough for our requeriments.

## Demo

![Demo](https://i.imgur.com/SOJcN2i.gif)

## Getting Started

Import the package to _pubspec.yaml_ file, and you're ready to go.
Just wrap the widgets that will trigger expansion with _Expander_ (they should be given as _triggerWidgets_ property) and provide an _AnimationController_.

Then, wrap the widget that will be expanded with \_Expandable and provide the same controller that you provided to the Expander, provide a height and you're done! Once you tap the expander, the expandable will animate vertically or horizontally (depending on the properties you've set).

Every _Expandable_ widget which has the same controller as the _Expander_ will perform the expansion animation.

```
Column(
    [
        Expander(
            rotateArrow: true,
            rotatingArrowSize: 40,
            arrowRotationDuration: const Duration(milliseconds: 300),
            triggerWidgets: [
            Container(
                width: 300,
                child: Text(
                'This is the widget that will trigger the expansion of the other widgets',
                maxLines: 2,
                ),
            )
            ],
            controller: controller,
        ),
        Expandable(
            height: 100,//height is mandatory
            controller: controller,//controller is mandatory
            duration: const Duration(seconds: 1),
            child: Container(//this widget will expand vertically (default)
            height: 100,
            color: Colors.green,
            child: Text(
                'This should only expand vertically',
                style: TextStyle(color: Colors.white),
            ),
            ),
        ),
    ]
),
```

Check out our _example_ for more information
