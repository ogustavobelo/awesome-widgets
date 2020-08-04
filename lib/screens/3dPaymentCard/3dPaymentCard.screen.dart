import 'package:awesome_widgets/screens/3dPaymentCard/custom3dTextInput.dart';
import 'package:awesome_widgets/screens/3dPaymentCard/paymentCardBackSide.dart';
import 'package:awesome_widgets/screens/3dPaymentCard/paymentCardFrontSide.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PaymentCardScreen extends StatefulWidget {
  @override
  _PaymentCardScreenState createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final numberController = MaskedTextController(mask: "0000 0000 0000 0000");
  final FocusNode numberFocus = FocusNode();
  final TextEditingController dateController =
      MaskedTextController(mask: "00/0000");
  final FocusNode dateFocus = FocusNode();
  final TextEditingController cvvController = MaskedTextController(mask: "000");
  final FocusNode cvvFocus = FocusNode();

  int formStep = 0;
  String bin;
  bool backSide = false;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.ease))
        .animate(controller)
          ..addListener(() {
            setState(() {});
          })
          ..addListener(() {
            if (animation.value > 0.5) {
              setState(() {
                backSide = true;
              });
            } else {
              setState(() {
                backSide = false;
              });
            }
          });

    
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    dateController.dispose();
    cvvController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(formStep==3) {
      controller.forward();
    } else {
      controller.reverse();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orange[50],
      ),
      backgroundColor: Colors.orange[50],
      body: Column(
        children: <Widget>[
          Visibility(
            visible: !backSide,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(animation.value * 3.14)
                ..setEntry(3, 2, .003),
              child: PaymentCardFrontSide(
                  name: nameController.text,
                  number: numberController.text,
                  date: dateController.text,
                  bin: bin),
            ),
            replacement: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(animation.value * 3.14)
                  ..setEntry(3, 2, .003),
                child: PaymentCardBackSide(cvvController.text)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: formStep == 0,
                    child: Custom3dTextInput(
                      controller: nameController,
                      focus: nameFocus,
                      hint: "Holder Name",
                      onFieldSubmitted: (value) => nextStep(),
                      onChanged: (value) => setState(
                          () {}), //only necessary without any state management
                    ),
                  ),
                  Visibility(
                    visible: formStep == 1,
                    child: Custom3dTextInput(
                      controller: numberController,
                      focus: numberFocus,
                      hint: "Card Number",
                      isNumber: true,
                      onFieldSubmitted: (value) => nextStep(),
                      onChanged: (value) => setState(() {
                        setBinImage(detectCCType(value));
                      }), //only necessary without any state management
                    ),
                  ),
                  Visibility(
                    visible: formStep == 2,
                    child: Custom3dTextInput(
                      controller: dateController,
                      focus: dateFocus,
                      hint: "Expiration Date",
                      isNumber: true,
                      onFieldSubmitted: (value) => nextStep(),
                      onChanged: (value) => setState(
                          () {}), //only necessary without any state management
                    ),
                  ),
                  Visibility(
                    visible: formStep == 3,
                    child: Custom3dTextInput(
                      controller: cvvController,
                      focus: cvvFocus,
                      hint: "Verification Code",
                      isNumber: true,
                      lastField: true,
                      onChanged: (value) => setState(
                          () {}), //only necessary without any state management
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                onPressed: formStep == 0
                    ? null
                    : () {
                        previousStep();
                      },
                child: Text("Previous"),
              )),
              Expanded(
                  child: FlatButton(
                onPressed: formStep > 3
                    ? null
                    : () {
                        nextStep();
                      },
                child: Text(formStep == 3 ? "Finish" : "Next"),
              )),
            ],
          )),
        ],
      ),
    );
  }

  void nextStep() {
    if (formStep < 3) {
      setState(() {
        formStep++;
      });
    }
  }

  void previousStep() {
    setState(() {
      formStep--;
    });
  }

  void setBinImage(CreditCardType type) {
    List<CreditCardType> validCards = [
      CreditCardType.visa,
      CreditCardType.mastercard,
      CreditCardType.hipercard,
      CreditCardType.amex,
      CreditCardType.elo,
      // if add more bins, it is needed add more images in assets
    ];

    if (validCards.contains(type)) {
      final String binType = type.toString().split(".").last;
      bin = binType;
    } else {
      bin = null;
    }
  }
}
