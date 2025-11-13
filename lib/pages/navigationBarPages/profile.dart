import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future call() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: "123456789",
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      // body: Center(
      //   child: IconButton(
      //       onPressed: () {
      //         call();
      //       },
      //       icon: const Icon(Icons.call)),
      // ),
      body: StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            User? user = snapshot.data;
            return StreamBuilder(
              stream: _firestore
                  .collection('orderlist')
                  .doc(user!.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(userData['profile'] ?? ''),
                        ),
                        SizedBox(height: 20),
                        Text(
                          userData['name'] ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          userData['email'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        ProfileInfoItem(
                          icon: Icons.phone,
                          label: 'Phone',
                          value: userData['phone'] ?? '',
                        ),
                        ProfileInfoItem(
                          icon: Icons.location_on,
                          label: 'Location',
                          value: userData['location'] ?? '',
                        ),
                        // Add more ProfileInfoItems as needed for additional information
                      ],
                    ),
                  );
                } else {
                  return Text('No data found');
                }
              },
            );
          } else {
            return Text('User not logged in');
          }
        },
      ),
    );
  }

  // Widget buildProfile(Map<String, dynamic> userData) {

  // }
}

class ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Text(
            '$label: $value',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
