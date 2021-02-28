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
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Column(
          children: [
            ExpanderWidget(
              rotateArrow: true,
              showRotatingArrow: false,
              rotatingArrowSize: 40,
              arrowRotationDuration: const Duration(milliseconds: 300),
              triggerWidgets: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                )
              ],
              controller: controller,
            ),
            ExpandableWidget(
              height: 20,
              controller: controller,
              child: Text('asdasdasdsa'),
            ),
            Container(
              width: 100,
              height: 50,
              color: Colors.purple,
            ),
            ExpandableWidget(
              height: 30,
              animateWidth: true,
              animateHeight: true,
              width: 200,
              controller: controller,
              child: Text('asdasdasdasd'),
            ),
          ],
        ),
      ),
    );
  }
}
