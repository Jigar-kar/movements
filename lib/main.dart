import 'package:flutter/material.dart';
import 'package:moments/pages/checkuser.dart';
import 'package:moments/pages/checkuser.dart';
import 'package:moments/pages/navigationBarPages/home.dart';
import 'package:moments/pages/signup.dart';
import 'package:moments/pages/splash.dart';
import 'package:moments/utilis/routes.dart';

import 'pages/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckUser(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          canvasColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.white))),
       initialRoute: MyRoute.loginRoute,
       routes: {
         "/": (context) => LoginPage(),
         MyRoute.homeRoute: (context) => HomePage(),
         MyRoute.loginRoute: (context) => LoginPage(),
         MyRoute.signupRoute: (context) => SignupPage()
       },
    );
  }
}
