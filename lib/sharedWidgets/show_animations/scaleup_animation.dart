import 'dart:async';
import 'package:flutter/material.dart';

class ScaleUp extends StatefulWidget {
  final Widget child;
  final int delay;

  ScaleUp({@required this.child, this.delay});

  @override
  _ScaleUpState createState() => _ScaleUpState();
}

class _ScaleUpState extends State<ScaleUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<double> _animScale;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animScale = Tween<double>(begin: 0.35, end: 1.0).animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: ScaleTransition(
        scale: _animScale,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
