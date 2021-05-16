import 'package:flutter/material.dart';
import 'package:flutter_expandable/expandable.dart';
import 'package:flutter_expandable/expander.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
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
            Expander(
              rotateArrow: true,
              rotatingArrowSize: 40,
              arrowRotationDuration: const Duration(milliseconds: 300),
              triggerWidgets: [
                Container(
                  width: 300,
                  color: Colors.red,
                  child: Text(
                    'This is the widget that will trigger the expansion of the other widgets',
                    maxLines: 2,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
              controller: controller,
            ),
            SizedBox(
              height: 30,
            ),
            Expandable(
              height: 200,
              controller: controller,
              duration: const Duration(seconds: 1),
              child: Container(
                height: 250,
                color: Colors.green,
                child: Text(
                  'This should only expand vertically',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expandable(
              height: 100,
              animateWidth: true,
              animateHeight: false,
              width: 200,
              duration: const Duration(seconds: 3),
              controller: controller,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.purple,
                child: Text(
                  'This should expand horizontally',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expandable(
              height: 150,
              animateWidth: true,
              animateHeight: true,
              width: 200,
              duration: const Duration(seconds: 2),
              controller: controller,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Text(
                  'This should expand vertical and horizontally',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expander.builder(
              controller: controller,
              rotatingArrowColor: Colors.white,
              rotatingArrowSize: 40,
              builder: (context, arrow) => Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        'This is the widget that will trigger the expansion of the other widgets',
                        maxLines: 2,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    arrow,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
