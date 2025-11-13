import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AFream extends StatefulWidget {
  const AFream({Key? key}) : super(key: key);

  @override
  State<AFream> createState() => _AFreamState();
}

class _AFreamState extends State<AFream> {
  final picker = ImagePicker();
  late String imageUrl = '';

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageRef =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();

      // Store image URL in Firestore under 'frame' collection
      await FirebaseFirestore.instance
          .collection('frame')
          .add({'imageUrl': url});

      setState(() {
        imageUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frame'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _uploadImage,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('frame').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else {
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final imageUrl = documents[index]['imageUrl'] as String?;
                return imageUrl != null
                    ? Image.network(imageUrl)
                    : const SizedBox(); // Or any placeholder widget
              },
            );
          }
        },
      ),
    );
  }
}
