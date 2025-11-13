import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditingPage extends StatefulWidget {
  @override
  _EditingPageState createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final TextEditingController _editingTypeController = TextEditingController();
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final String? currentUserEmail = user!.email;
      if (_imageFile != null) {
        final String fileName =
            DateTime.now().millisecondsSinceEpoch.toString();
        final Reference storageReference =
            FirebaseStorage.instance.ref().child('editing_images/$fileName');
        final UploadTask uploadTask = storageReference.putFile(_imageFile!);
        await uploadTask.whenComplete(() => null);
        final String imageUrl = await storageReference.getDownloadURL();

        final String editingType = _editingTypeController.text.trim();

        // Store imageUrl and editingType in Firestore
        await FirebaseFirestore.instance
            .collection('orderlist')
            .doc(currentUserEmail)
            .collection('Editing')
            .add({
          'imageUrl': imageUrl,
          'editingType': editingType,
        });

        // Clear fields after uploading
        setState(() {
          _imageFile = null;
          _editingTypeController.clear();
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image uploaded successfully.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an image.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error uploading image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editing'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : Placeholder(fallbackHeight: 200.0),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                ),
                SizedBox(width: 20.0),
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _editingTypeController,
              decoration: InputDecoration(
                labelText: 'Editing Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
