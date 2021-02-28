import 'package:flutter/material.dart';

class ExpanderWidget extends StatefulWidget {
  const ExpanderWidget({
    Key key,
    @required this.triggerWidgets,
    @required this.controller,
    this.onHide,
    this.onShow,
    this.arrowRotationDuration,
    this.showRotatingArrow = true,
    this.rotateArrow = true,
    this.rotatingArrowColor = Colors.green,
    this.rotatingArrowSize = 20,
  })  : assert(controller != null),
        assert(triggerWidgets != null),
        super(key: key);
  final VoidCallback onHide;
  final VoidCallback onShow;
  final List<Widget> triggerWidgets;
  final Duration arrowRotationDuration;
  final AnimationController controller;
  final bool showRotatingArrow;
  final bool rotateArrow;
  final Color rotatingArrowColor;
  final double rotatingArrowSize;
  @override
  _ExpanderWidgetState createState() => _ExpanderWidgetState();
}

class _ExpanderWidgetState extends State<ExpanderWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration:
          widget.arrowRotationDuration ?? const Duration(milliseconds: 400),
      vsync: this,
      value: 00,
      lowerBound: 0,
      upperBound: 0.5,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.rotateArrow) _controller.forward();

        if (widget.controller.status == AnimationStatus.completed ||
            widget.controller.status == AnimationStatus.forward) {
          widget.controller.reverse();
          if (widget.onHide != null) widget.onHide();
          if (widget.rotateArrow) _controller.reverse();
        } else {
          if (widget.rotateArrow) _controller.forward();
          if (widget.onShow != null) widget.onShow();
          widget.controller.forward();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...widget.triggerWidgets,
          if (widget.showRotatingArrow)
            RotationTransition(
              turns: _controller,
              child: Icon(
                Icons.keyboard_arrow_down,
                size: widget.rotatingArrowSize,
                color: widget.rotatingArrowColor,
              ),
            ),
        ],
      ),
    );
  }
}
