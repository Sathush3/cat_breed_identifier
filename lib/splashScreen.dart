import 'package:cat_breed_identifier/homepage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class MySpashScreen extends StatefulWidget {
  const MySpashScreen({Key? key}) : super(key: key);

  @override
  State<MySpashScreen> createState() => _MySpashScreenState();
}

class _MySpashScreenState extends State<MySpashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'images/2.1 icon.jpg',
      splashIconSize: 200,
      nextScreen: MyHomepage(),
      splashTransition: SplashTransition.decoratedBoxTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 3000,
      backgroundColor: Colors.blueAccent,
    );
  }
}
