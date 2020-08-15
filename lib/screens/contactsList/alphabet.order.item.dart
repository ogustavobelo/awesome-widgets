import 'package:flutter/material.dart';

class AlphabetOrderItem extends StatelessWidget {
  final String letter;
  final Function onPressed;
  final bool clickable;
  final Color color;
  AlphabetOrderItem({
    this.letter, this.onPressed, this.clickable, this.color
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.purple,
        focusColor: Colors.blue,
        highlightColor: Colors.pinkAccent,
        child: Text(
          letter,
          style: TextStyle(
            color: clickable ? color : color.withOpacity(.3),
            fontWeight: FontWeight.w100,
            fontSize: 16,
            height: 1.5
          ),
          textAlign: TextAlign.center,
        ),
      )
      
    );
  }
}