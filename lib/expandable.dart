import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  const Expandable({
    Key? key,
    required this.controller,
    required this.child,
    required this.height,
    this.width,
    this.animateWidth = false,
    this.animateHeight = true,
    this.curve,
    this.duration,
  })  : assert((animateWidth && width != null) ||
            (!animateWidth && width == null)),
        assert(animateHeight || animateWidth),
        super(key: key);

  ///Controls which expandable belongs to which expander. Must not be null and should be the same as its Expander's controller
  ///
  final AnimationController controller;

  ///Widgets that will be expanded
  ///
  final Widget child;

  ///Maxheight for the expandable widgets.
  ///
  final double height;

  ///MaxWidth for the expandable widgets.
  ///
  final double? width;

  ///Set to true if you want to expand horizontally. Defaults to false.
  ///
  final bool animateWidth;

  ///Set to true if you want to expand vertically. Defaults to true.
  ///
  final bool animateHeight;

  ///Curve for expansion and folding animations
  ///
  final Curve? curve;

  ///Duration for expansion and folding animations
  ///
  final Duration? duration;

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> tween;
  late Animation<double> tweenWidth;
  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    _controller = widget.controller;
    _controller.addListener(
      () {
        setState(() {});
      },
    );
    tween = Tween<double>(
      begin: 0,
      end: widget.height,
    ).animate(_controller);

    tweenWidth = Tween<double>(
      begin: 0,
      end: widget.width ?? 0,
    ).animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      constraints: BoxConstraints(
        maxHeight: widget.animateHeight ? tween.value : widget.height,
      ),
      width: widget.animateWidth ? tweenWidth.value : widget.width,
      curve: widget.curve ?? Curves.linear,
      duration: widget.duration ?? widget.controller.duration!,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}
