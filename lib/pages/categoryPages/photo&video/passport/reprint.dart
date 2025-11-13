import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReprintPage extends StatefulWidget {
  @override
  _ReprintPageState createState() => _ReprintPageState();
}

class _ReprintPageState extends State<ReprintPage> {
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reprint Images'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orderlist')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('softcopy')
            .doc('passpoordata')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!.data();
          if (data == null ||
              !(data as Map<String, dynamic>).containsKey('images')) {
            return Center(child: Text('No images found'));
          }

          final List<String> imageUrls =
              List<String>.from((data as Map<String, dynamic>)['images']);

          return ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              final imageUrl = imageUrls[index];
              final isSelected = selectedImages.contains(imageUrl);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedImages.remove(imageUrl);
                    } else {
                      selectedImages.add(imageUrl);
                    }
                  });
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Image.network(imageUrl),
                    ),
                    if (isSelected)
                      ElevatedButton(
                        onPressed: () {
                          // Handle print booking
                          print('Print booking for $imageUrl');
                        },
                        child: Text('Print Booking'),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
