import 'package:flutter/material.dart';

class AnimatedRoundedButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color color;
  AnimatedRoundedButton({
    @required this.text,
    @required this.onPressed,
    this.color,
  });
  @override
  _AnimatedRoundedButtonState createState() => _AnimatedRoundedButtonState();
}

class _AnimatedRoundedButtonState extends State<AnimatedRoundedButton> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
        padding: EdgeInsets.symmetric(
            horizontal: _animate ? 16.0 : 24.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(24)),
        child: GestureDetector(
            onTap: () async {
              setAnimate();
              Future.delayed(Duration(milliseconds: 200), () {
                widget.onPressed();
              });
            },
            child: Text(widget.text)));
  }

  void setAnimate() {
    setState(() {
      _animate = !_animate;
    });
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _animate = !_animate;
      });
    });
  }
}
