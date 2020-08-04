import 'package:awesome_widgets/screens/rating/rating.form.content.dart';
import 'package:awesome_widgets/screens/rating/rating.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RatingForm {
  RatingModel rate;

  Future<RatingModel> showForm(BuildContext context) async {
    final result = showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  elevation: 5.0,
                  backgroundColor: Theme.of(context).cardColor,
                  child: RatingFormContent((rateFilled) {
                    rate = rateFilled;
                  })));
        });

    await result.whenComplete(() => null);
    return rate;
  }
}
