import 'dart:async';

import 'package:awesome_widgets/core/routes/routes.dart';
import 'package:awesome_widgets/screens/3dPaymentCard/3dPaymentCard.screen.dart';
import 'package:awesome_widgets/screens/contactsList/contactsList.screen.dart';
import 'package:awesome_widgets/screens/home/home.screen.dart';
import 'package:awesome_widgets/screens/rating/rating.screen.dart';
import 'package:awesome_widgets/screens/swipeableButton/swipeableButton.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/parallaxForm/parallaxForm.screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runZoned(() {
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Widgets',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initial,
      routes: {
        Routes.initial: (context) => HomeScreen(),
        Routes.reviewModal: (context) => RatingScreen(),
        Routes.paymentCard3d: (context) => PaymentCardScreen(),
        Routes.swipeableButton: (context) => SwipeableButtonScreen(),
        Routes.contactsList: (context) => ContactsListScreen(),
        Routes.parallaxForm: (context) => ParallaxFormScreen(),
      },
    );
  }
}
