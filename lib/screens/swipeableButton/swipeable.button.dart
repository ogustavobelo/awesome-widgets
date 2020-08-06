import 'package:awesome_widgets/screens/swipeableButton/swipeable.widget.dart';
import 'package:flutter/material.dart';

class SwipeableButton extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final String text;
  final VoidCallback onSwipe;
  final double borderRadius;
  final Color textColor;
  SwipeableButton({
    @required this.text,
    @required this.onSwipe,
    this.primaryColor,
    this.secondaryColor,
    this.borderRadius = 0.0,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * .08,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: secondaryColor,
            ),
          ),
          SwipeableWidget(
              height: size.height * .08,
              onSwipe: onSwipe,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: secondaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Center(
                              child: Icon(Icons.chevron_right,
                                  color: Colors.white, size: 42),
                            ),
                          )),
                      Flexible(
                          flex: 3,
                          child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                text.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: textColor ?? Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ],
                  )))
        ],
      ),
    );
  }

  
}
