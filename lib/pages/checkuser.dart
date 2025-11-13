import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moments/pages/login.dart';
import 'package:moments/pages/mainhome.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({Key? key}) : super(key: key);

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    Widget nextPage;
    if (user == null) {
      nextPage = LoginPage();
    } else {
      nextPage = MainHomePage();
    }

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => nextPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
