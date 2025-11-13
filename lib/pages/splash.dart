import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moments/pages/checkuser.dart';
//import 'package:moments/pages/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to display the splash screen for 3 seconds
    Timer(Duration(seconds: 3), () {
      // Navigate to the next screen after 3 seconds
      // Replace 'NextScreen()' with your desired screen/widget
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => CheckUser()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a container to display the image as a splash screen
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/imges/001.png"),
          ),
        ),
      ),
    );
  }
}
