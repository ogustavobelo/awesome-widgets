import 'package:awesome_widgets/core/routes/routes.dart';
import 'package:awesome_widgets/sharedWidgets/animatedRoundedButton/rounded.button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252759),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 24.0),
            child: Image.asset("assets/logo/awesome_widgets_logo.png"),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 8.0),
                child: AnimatedRoundedButton(
                      text: "Rating Modal",
                      color: Colors.orange,
                      onPressed: ()  {
                        Navigator.pushNamed(context, Routes.reviewModal);
                      },
                    ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 8.0),
                child: AnimatedRoundedButton(
                      text: "3D Payment Card",
                      color: Colors.orange,
                      onPressed: ()  {
                        Navigator.pushNamed(context, Routes.paymentCard3d);
                      },
                    ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 8.0),
                child: AnimatedRoundedButton(
                      text: "Swipeable Button",
                      color: Colors.orange,
                      onPressed: ()  {
                        Navigator.pushNamed(context, Routes.swipeableButton);
                      },
                    ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 8.0),
                child: AnimatedRoundedButton(
                      text: "Contacts List",
                      color: Colors.orange,
                      onPressed: ()  {
                        Navigator.pushNamed(context, Routes.contactsList);
                      },
                    ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 8.0),
                child: AnimatedRoundedButton(
                      text: "Parallax Form",
                      color: Colors.orange,
                      onPressed: ()  {
                        Navigator.pushNamed(context, Routes.parallaxForm);
                      },
                    ),
              ),
              
            ],
          )

        ],
      ),
      
    );
  }
}