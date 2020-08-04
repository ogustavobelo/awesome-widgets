import 'package:flutter/material.dart';

class PaymentCardBackSide extends StatefulWidget {
  final String cvv;
  PaymentCardBackSide(this.cvv);

  @override
  _PaymentCardBackSideState createState() => _PaymentCardBackSideState();
}

class _PaymentCardBackSideState extends State<PaymentCardBackSide> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.14),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Image.asset("assets/paymentCard/blue_payment_card_back.png",
                fit: BoxFit.contain),
            Positioned(
                top: 90,
                right: 48,
                child: Text(
                  widget.cvv.isNotEmpty ? widget.cvv : "123",
                  style: TextStyle(
                      color: widget.cvv.isNotEmpty
                          ? Colors.orange
                          : Colors.orange.withOpacity(.35),
                      fontSize: 20,
                      fontFamily: "OCRA"),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
          ],
        ),
      ),
    );
  }
}
