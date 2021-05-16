import 'package:flutter/material.dart';

class Expander extends StatefulWidget {
  const Expander._({
    Key? key,
    this.triggerWidgets,
    required this.controller,
    this.onHide,
    this.onShow,
    this.arrowRotationDuration,
    this.showRotatingArrow = true,
    this.rotateArrow = true,
    this.rotatingArrowColor = Colors.green,
    this.rotatingArrowSize = 20,
    this.builder,
  })  : assert(builder == null || triggerWidgets == null),
        super(key: key);

  final VoidCallback? onHide;

  final VoidCallback? onShow;

  final List<Widget>? triggerWidgets;

  final Duration? arrowRotationDuration;

  final AnimationController controller;

  final bool showRotatingArrow;

  final bool rotateArrow;

  final Color rotatingArrowColor;

  final double rotatingArrowSize;

  final Widget Function(BuildContext context, Widget arrow)? builder;

  /// [controller] Controls which expander triggers which expandable. Must not be null and should be the same as its Expandable's controller
  ///
  /// [triggerWidgets] Widgets that will trigger the expansion animation
  ///

  /// [onHide] This callback will be callend every time the animation controller is reversed (the expanded widget hides)
  ///
  /// [onShow] This callback will be callend every time the animation controller is forwarded (the expanded widget shows)
  ///
  /// [arrowRotationDuration] How long will it take to the arrow to rotate
  ///

  /// [showRotatingArrow] Defaults to true
  ///
  /// [rotateArrow] Defaults to true
  ///
  /// [rotatingArrowColor] You may change the color of the rotating arrow
  ///
  /// [rotatingArrowSize] You may change the size of the rotating arrow
  ///
  factory Expander({
    required AnimationController controller,
    required List<Widget> triggerWidgets,
    VoidCallback? onHide,
    VoidCallback? onShow,
    Duration? arrowRotationDuration,
    bool showRotatingArrow = true,
    bool rotateArrow = true,
    Color rotatingArrowColor = Colors.green,
    double rotatingArrowSize = 20,
  }) {
    return Expander._(
      onHide: onHide,
      onShow: onShow,
      triggerWidgets: triggerWidgets,
      arrowRotationDuration: arrowRotationDuration,
      controller: controller,
      showRotatingArrow: showRotatingArrow,
      rotateArrow: rotateArrow,
      rotatingArrowColor: rotatingArrowColor,
      rotatingArrowSize: rotatingArrowSize,
      builder: null,
    );
  }

  /// Provides a BuildContext and the rotating arrow so you can place it wherever you need to
  ///
  ///
  /// [controller] Controls which expander triggers which expandable. Must not be null and should be the same as its Expandable's controller
  ///
  /// [triggerWidgets] Widgets that will trigger the expansion animation
  ///

  /// [onHide] This callback will be callend every time the animation controller is reversed (the expanded widget hides)
  ///
  /// [onShow] This callback will be callend every time the animation controller is forwarded (the expanded widget shows)
  ///
  /// [arrowRotationDuration] How long will it take to the arrow to rotate
  ///

  /// [showRotatingArrow] Defaults to true
  ///
  /// [rotateArrow] Defaults to true
  ///
  /// [rotatingArrowColor] You may change the color of the rotating arrow
  ///
  /// [rotatingArrowSize] You may change the size of the rotating arrow
  ///
  factory Expander.builder({
    required Widget Function(BuildContext context, Widget arrow) builder,
    required AnimationController controller,
    VoidCallback? onHide,
    VoidCallback? onShow,
    Duration? arrowRotationDuration,
    bool rotateArrow = true,
    Color rotatingArrowColor = Colors.green,
    double rotatingArrowSize = 20,
  }) {
    return Expander._(
      onHide: onHide,
      onShow: onShow,
      builder: builder,
      arrowRotationDuration: arrowRotationDuration,
      controller: controller,
      rotateArrow: rotateArrow,
      rotatingArrowColor: rotatingArrowColor,
      rotatingArrowSize: rotatingArrowSize,
    );
  }
  @override
  _ExpanderState createState() => _ExpanderState();
}

class _ExpanderState extends State<Expander>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
          if (widget.onHide != null) widget.onHide!();
          if (widget.rotateArrow) _controller.reverse();
        } else {
          if (widget.rotateArrow) _controller.forward();
          if (widget.onShow != null) widget.onShow!();
          widget.controller.forward();
        }
      },
      child: widget.builder == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...widget.triggerWidgets ?? [Container()],
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
            )
          : widget.builder!(
              context,
              RotationTransition(
                turns: _controller,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: widget.rotatingArrowSize,
                  color: widget.rotatingArrowColor,
                ),
              ),
            ),
    );
  }
}
