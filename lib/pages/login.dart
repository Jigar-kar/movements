import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moments/admin/adminlogin.dart';
import 'package:moments/pages/mainhome.dart';
import 'package:moments/pages/signup.dart';
import 'package:moments/utilis/auth.dart';
import 'package:moments/utilis/design.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (context) {
          return MyLoding(
            name: 'Login...',
          ); // Custom loading widget
        },
        overlayColor: Colors.black.withOpacity(0.8),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 23),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        child: Image.asset("asset/imges/logo.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminLogin(),
                              ),
                            );
                          },
                          child: Text('Admin'),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "Please Login to your account",
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
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          hintText: "example@gmail.com",
                          labelText: "Username or email id",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (value.length < 6) {
                            return "Password length should be at least 6";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: Color.fromARGB(128, 255, 255, 255),
                            fontSize: 12,
                          ),
                        ),
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
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          )
                              .then((value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainHomePage(),
                              ),
                            );
                          });
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Or",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // Call googleSignIn function when button is pressed and pass the context
                                bool success = await googleSignIn(context);
                                if (success) {
                                  // Navigate to another screen if sign-in is successful
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainHomePage(),
                                    ),
                                  );
                                } else {
                                  // Navigate to the login screen or pop if authentication was canceled
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                }
                              },
                              child: Image.asset(
                                'asset/imges/google.png',
                                height: 24,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor:
                                    const Color.fromRGBO(255, 0, 0, 0),
                                side: BorderSide(
                                  color: Color.fromARGB(57, 255, 255, 255),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Image.asset(
                                'asset/imges/fb.png',
                                height: 24,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor:
                                    const Color.fromRGBO(255, 0, 0, 0),
                                side: BorderSide(
                                  color: Color.fromARGB(57, 255, 255, 255),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
