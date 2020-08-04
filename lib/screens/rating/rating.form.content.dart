import 'package:awesome_widgets/screens/rating/rating.model.dart';
import 'package:awesome_widgets/sharedWidgets/animatedRoundedButton/rounded.button.dart';
import 'package:flutter/material.dart';

class RatingFormContent extends StatefulWidget {
  final Function(RatingModel) setRate;
  RatingFormContent(this.setRate);

  @override
  _RatingFormContentState createState() => _RatingFormContentState();
}

class _RatingFormContentState extends State<RatingFormContent> {
  final TextEditingController reviewController = TextEditingController();
  int stars;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "How was your order?",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Text(
            "Rate this with stars",
            textAlign: TextAlign.center,
          ),
          Container(
            height: 40.0,
            alignment: Alignment.center,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          stars = index + 1;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        child: Icon(
                            stars == null || stars < index + 1
                                ? Icons.star_border
                                : Icons.star,
                            size: 32,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: reviewController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "Did you like this order?",
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColorDark)),
              ),
            ),
          ),
          Visibility(
            visible: stars != null,
                      child: AnimatedRoundedButton(
              text: "Save",
              onPressed: () {
                widget.setRate(
                    RatingModel(stars: stars, review: reviewController.text));
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
