import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendSoftcopy extends StatefulWidget {
  const SendSoftcopy({Key? key}) : super(key: key);

  @override
  State<SendSoftcopy> createState() => _SendSoftcopyState();
}

class _SendSoftcopyState extends State<SendSoftcopy> {
  List<XFile> _imageFiles = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _imageFiles = images;
      });
      // Upload images to Firebase Storage
      await _uploadImages();
    }
  }

  Future<void> _uploadImages() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final String email = currentUser.email!;
        final List<String> imageURLs = [];

        for (var imageFile in _imageFiles) {
          final imageFileName =
              DateTime.now().millisecondsSinceEpoch.toString();
          final firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('softcopies')
              .child(email)
              .child('$imageFileName.jpg');
          final firebase_storage.UploadTask uploadTask =
              ref.putFile(File(imageFile.path));
          final firebase_storage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() => null);
          final downloadURL = await taskSnapshot.ref.getDownloadURL();
          imageURLs.add(downloadURL);
        }

        // Store download URLs in Firestore
        final CollectionReference ordersCollection =
            FirebaseFirestore.instance.collection('orderlist');
        final DocumentReference userDocRef = ordersCollection.doc(email);
        final CollectionReference softcopyCollection =
            userDocRef.collection('softcopy');

        // Create a document named 'passpoordata' and store images
        final DocumentReference passportDocRef =
            softcopyCollection.doc('passpoordata');
        await passportDocRef.set({
          'images': imageURLs,
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Images uploaded successfully!'),
          ),
        );
      }
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading images: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Softcopy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: _getImage,
              iconSize: 50,
            ),
            SizedBox(height: 20),
            if (_imageFiles.isNotEmpty)
              Text(
                '${_imageFiles.length} ${_imageFiles.length == 1 ? 'image' : 'images'} selected',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
