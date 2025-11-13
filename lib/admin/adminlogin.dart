// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moments/admin/amain.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Material(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 23),
                Container(
                  height: 250,
                  width: 250,
                  child: Image.asset("asset/imges/logo.png"),
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Please Login to Admin account",
                  style: TextStyle(fontWeight: FontWeight.w100),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          hintText: "example@gmail.com",
                          labelText: "Username or email id",
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor: Color.fromRGBO(220, 26, 26, 1),
                          foregroundColor: Colors.white,
                          fixedSize: Size(290, 54),
                        ),
                        onPressed: () {
                          if (_usernameController.text == 'admin1234' &&
                              _passwordController.text == '12345') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Amain(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid username and password'),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
