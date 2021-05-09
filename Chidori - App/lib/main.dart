
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import './pages/home.dart';

void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new HomePage(),
      backgroundColor: Colors.black,
      image:Image(image: AssetImage("lib/img/LOGO.png")),
      photoSize: 100.0,
      loaderColor: Color(0xFF04FFB4),
    );
  }
}
