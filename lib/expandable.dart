import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  const Expandable({
    Key key,
    //Controls which expandable belongs to which expander. Must not be null and should be the same as its Expander's controller
    @required this.controller,
    //Widgets that will be expanded
    @required this.child,
    //Maxheight for the expandable widgets.
    @required this.height,
    //MaxWidth for the expandable widgets.
    this.width,
    //Set to true if you want to expand horizontally. Defaults to false.
    this.animateWidth = false,
    //Set to true if you want to expand vertically. Defaults to true.
    this.animateHeight = true,
    //Curve for expansion and folding animations
    this.curve,
    //Duration for expansion and folding animations
    this.duration,
  })  : assert((animateWidth && width != null) ||
            (!animateWidth && width == null)),
        assert((animateHeight && height != null) ||
            (!animateHeight && height == null)),
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
      constraints: BoxConstraints(
          maxHeight: widget.animateHeight ? tween.value : widget.height),
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
