import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  final Widget child;
  final double height;
  final VoidCallback onSwipe;
  final double swipePercentage;

  SwipeableWidget({
    @required this.child,
    @required this.height,
    @required this.onSwipe,
    this.swipePercentage = 0.75,
  });

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  double _startPosition = 0.0;
  double _endsPosition = 0.0;

  bool clicked = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });

    _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!clicked) {
      iddleAnimation();
    }

    return GestureDetector(
        onTap: () {
          _controller.animateTo(1.0,
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          setState(() {
            clicked = true;
          });
        },
        onPanStart: (details) {
          setState(() {
            clicked = true;

            _startPosition = details.localPosition.dx;
          });
        },
        onPanUpdate: (details) {
          final widgetSize = context.size.width;
          final minimumXToStartSwiping = widgetSize * .25;
          if (_startPosition <= minimumXToStartSwiping) {
            setState(() {
              clicked = true;

              _endsPosition = details.localPosition.dx;
            });
            final widgetSize = context.size.width;
            _controller.value = 1 - ((details.localPosition.dx) / widgetSize);
          }
        },
        onPanEnd: (details) {
          final delta = _endsPosition - _startPosition;
          final widgetSize = context.size.width;
          final deltaNeededToBeSwiped = widgetSize * widget.swipePercentage;
          if (delta > deltaNeededToBeSwiped) {
            _controller.animateTo(0.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn);
            widget.onSwipe();
            Future.delayed(Duration(milliseconds: 500), () {
              _controller.animateTo(1.0,
                  duration: Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn);
            });
          } else {
            _controller.animateTo(1.0, duration: Duration(milliseconds: 300));
          }
        },
        child: Container(
            height: widget.height,
            child: Align(
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                    widthFactor: _controller.value,
                    heightFactor: 1.0,
                    child: widget.child))));
  }

  void iddleAnimation() {
    if (_controller.value == 1.0) {
      _controller.animateTo(.9,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
    if (_controller.value == .9) {
      _controller.animateTo(1.0,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
