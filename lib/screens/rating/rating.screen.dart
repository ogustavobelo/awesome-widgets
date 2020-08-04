import 'package:awesome_widgets/screens/rating/rating.form.dart';
import 'package:awesome_widgets/screens/rating/rating.model.dart';
import 'package:awesome_widgets/sharedWidgets/animatedRoundedButton/rounded.button.dart';
import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  RatingModel currentRating;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          color: Colors.teal[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                  visible: currentRating != null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${currentRating?.stars?.toStringAsFixed(0)}",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          )),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 32,
                      )
                    ],
                  ),
                  replacement: AnimatedRoundedButton(
                    text: "Rate Order",
                    color: Colors.orange,
                    onPressed: () async {
                      currentRating = await RatingForm().showForm(context);
                      setState(() {});
                    },
                  )),
            ],
          )),
    );
  }
}
