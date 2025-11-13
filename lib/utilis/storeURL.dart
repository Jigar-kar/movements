gimport 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageRefUploader extends StatefulWidget {
  @override
  _ImageRefUploaderState createState() => _ImageRefUploaderState();
}

class _ImageRefUploaderState extends State<ImageRefUploader> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _folderName =
      'fashion'; // Replace with your folder name in Firebase Storage
  List<String> _imageUrls = [];

  Future<void> fetchImageUrlsFromStorage(String folderName) async {
    try {
      ListResult result = await _storage.ref().child(folderName).listAll();
      List<String> downloadUrls = [];

      for (Reference ref in result.items) {
        String downloadUrl = await ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }

      setState(() {
        _imageUrls = downloadUrls;
      });
    } catch (error) {
      print('Error fetching image URLs from Firebase Storage: $error');
    }
  }

  Future<void> updateFirestoreWithImageRefs(List<String> imageUrls) async {
    try {
      // Update Firestore documents with image URLs
      DocumentReference documentRef =
          _firestore.collection('Modeling').doc('portrait');
      await documentRef.update({'urls': imageUrls});

      print('Image URLs added to Firestore document successfully.');
    } catch (error) {
      print('Error updating Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Reference Uploader'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Fetch image URLs from Firebase Storage
            await fetchImageUrlsFromStorage(_folderName);

            // Update Firestore with image URLs
            await updateFirestoreWithImageRefs(_imageUrls);
          },
          child: Text('Update Firestore with Image URLs'),
        ),
      ),
    );
  }
}
