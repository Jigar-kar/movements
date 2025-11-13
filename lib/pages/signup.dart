import "package:firebase_auth/firebase_auth.dart";
//import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import 'package:moments/pages/navigationBarPages/home.dart';
import "package:moments/pages/login.dart";

TextEditingController _userNameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Create new account",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              "Please fill in the form to continue",
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 60),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        labelText: "Enter your full name"),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        labelText: "Email id"),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        labelText: "Number"),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        labelText: "Password"),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14)),
                        labelText: "Confirm Password"),
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "   Password and confirm password will be same*",
                      style: TextStyle(
                          color: Color.fromARGB(128, 255, 255, 255),
                          fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    // ignore: sort_child_properties_last
                    child: const Text('Sign up'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        backgroundColor: const Color.fromRGBO(220, 26, 26, 1),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(290, 54)),
                    onPressed: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _userNameController.text,
                              password: _passwordController.text)
                          .then((value) {
                        print("Created New Account");
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()))
                            .onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 70,
                      ),
                      const Text(
                        "Have an account? ",
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
