import 'package:flutter/material.dart';

class PaymentCardFrontSide extends StatefulWidget {
  final String name;
  final String number;
  final String date;
  final String bin;
  PaymentCardFrontSide(
      {@required this.name,
      @required this.number,
      @required this.date,
      this.bin});

  @override
  _PaymentCardFrontSideState createState() => _PaymentCardFrontSideState();
}

class _PaymentCardFrontSideState extends State<PaymentCardFrontSide> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/paymentCard/blue_payment_card_front.png",
            fit: BoxFit.contain,
          ),
          Positioned(
              bottom: size.height * .06,
              right: size.width * .05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    widget.name.isNotEmpty ? widget.name : "Holder Name",
                    style: TextStyle(
                        color: widget.name.isNotEmpty
                            ? Colors.white
                            : Colors.white.withOpacity(.35),
                        fontSize: 18,
                        fontFamily: "OCRA"),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  ),
                  Text(
                    widget.number.isNotEmpty
                        ? widget.number
                        : "9999 9999 9999 9999",
                    style: TextStyle(
                        color: widget.number.isNotEmpty
                            ? Colors.white
                            : Colors.white.withOpacity(.35),
                        fontSize: 18,
                        fontFamily: "OCRA"),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  ),
                  Text(
                    widget.date.isNotEmpty ? widget.date : "08/2020",
                    style: TextStyle(
                        color: widget.date.isNotEmpty
                            ? Colors.white
                            : Colors.white.withOpacity(.35),
                        fontSize: 18,
                        fontFamily: "OCRA"),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                widget.bin == null
                    ? Container()
                    : Image.asset("assets/paymentCard/${widget.bin}.png", height: 48.0)
              ],
            ),
          )
        ],
      ),
    );
  }
}
