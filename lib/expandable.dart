import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  const Expandable({
    Key key,
    @required this.controller,
    @required this.child,
    @required this.height,
    this.width,
    this.animateWidth = false,
    this.animateHeight = true,
    this.curve,
    this.duration,
  })  : assert((animateWidth && width != null) ||
            (!animateWidth && width == null)),
        assert(controller != null),
        assert(child != null),
        assert(animateHeight || animateWidth),
        super(key: key);
  final AnimationController controller;
  final double height;
  final double width;
  final bool animateWidth;
  final Curve curve;
  final Duration duration;
  final bool animateHeight;
  final Widget child;

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> tween;
  Animation<double> tweenWidth;
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
      end: widget.height ?? 0,
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
      height: widget.animateHeight ? tween.value : widget.height,
      width: widget.animateWidth ? tweenWidth.value : widget.width,
      curve: widget.curve ?? Curves.linear,
      duration: widget.duration ?? widget.controller.duration,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}
