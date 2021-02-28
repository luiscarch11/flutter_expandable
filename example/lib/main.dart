import 'package:flutter/material.dart';
import 'package:flutter_expandable/expandable_widget.dart';
import 'package:flutter_expandable/expander_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expander example'),
        ),
        body: Column(
          children: [
            ExpanderWidget(
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
            SizedBox(
              height: 30,
            ),
            ExpandableWidget(
              height: 20,
              controller: controller,
              child: Text('This should only expand vertically'),
            ),
            ExpandableWidget(
              height: 30,
              animateWidth: true,
              animateHeight: true,
              width: 200,
              controller: controller,
              child: Text('This should expand vertical and horizontally'),
            ),
          ],
        ),
      ),
    );
  }
}
