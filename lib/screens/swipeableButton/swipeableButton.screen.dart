import 'package:awesome_widgets/screens/swipeableButton/swipeable.button.dart';
import 'package:awesome_widgets/sharedWidgets/fullScreenLoading/fullScreenLoading.dart';
import 'package:flutter/material.dart';

class SwipeableButtonScreen extends StatefulWidget {
  @override
  _SwipeableButtonScreenState createState() => _SwipeableButtonScreenState();
}

class _SwipeableButtonScreenState extends State<SwipeableButtonScreen> {
  final Color backgroundColor = Color(0xFFD9B68B);
  final Color primaryColor = Color(0xFF8C77D9);
  final Color secondaryColor = Color(0xFF7263A6);

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return FullScreenLoading(
      "assets/animations/payment_loading.flr",
      animationName: "loading",
      loading: loading,
          child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: backgroundColor,
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: SizedBox()),
            SwipeableButton(
              text: "Slide to Pay",
              primaryColor: primaryColor,
              borderRadius: 32.0,
              secondaryColor: secondaryColor,
              onSwipe: () async {
                setState(() {
                  loading = true;
                });

                await Future.delayed(Duration(seconds: 5), (){
                  setState(() {
                    loading = false;
                  });
                });
                
              },
            ),
          ],
        ),
        
      ),
    );
  }

  
}