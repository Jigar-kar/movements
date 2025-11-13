import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:moments/utilis/design.dart';

class HomeAddSliderDialog extends StatefulWidget {
  final String collectionName;

  HomeAddSliderDialog({required this.collectionName});

  @override
  _HomeAddSliderDialogState createState() => _HomeAddSliderDialogState();
}

class _HomeAddSliderDialogState extends State<HomeAddSliderDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _photographerController = TextEditingController();
  final TextEditingController _videographerController = TextEditingController();
  final TextEditingController _editorController = TextEditingController();

  File? _backgroundImage;
  List<File> _showcaseImages = [];

  final picker = ImagePicker();

  Future<void> _selectBackgroundImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _backgroundImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _selectShowcaseImages() async {
    final pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _showcaseImages.clear();
        _showcaseImages
            .addAll(pickedImages.map((pickedImage) => File(pickedImage.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading:
          false, // Use default loading indicator provided by loader_overlay
      overlayColor: Colors.black.withOpacity(0.8),
      overlayWidgetBuilder: (context) {
        return MyLoding(
          name: 'Uploading...',
        );
      }, // Customize overlay color if needed
      child: AlertDialog(
        title: Text('Add Slider for home'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: _photographerController,
                decoration: InputDecoration(labelText: 'Photographer Name'),
              ),
              TextFormField(
                controller: _videographerController,
                decoration: InputDecoration(labelText: 'Videographer Name'),
              ),
              TextFormField(
                controller: _editorController,
                decoration: InputDecoration(labelText: 'Editor Name'),
              ),
              SizedBox(height: 16),
              Text('Select Background Image:'),
              ElevatedButton(
                onPressed: _selectBackgroundImage,
                child: Text('Choose Image'),
              ),
              SizedBox(height: 16),
              Text('Select Showcase Images:'),
              ElevatedButton(
                onPressed: _selectShowcaseImages,
                child: Text('Choose Images'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cancel button
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Upload data and images to Firestore and Firebase Storage
              _uploadDataAndImages(context);
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _uploadDataAndImages(BuildContext context) async {
    context.loaderOverlay.show(); // Show loading indicator

    try {
      // Ensure that the title is not empty
      if (_titleController.text.isEmpty) {
        throw Exception('Title cannot be empty');
      }

      // Generate folder names based on the document ID and title
      String documentFolderName = _titleController.text;
      String imageNameFolderName = _titleController.text;

      // Upload background image to Firebase Storage
      String backgroundImageUrl = '';
      if (_backgroundImage != null) {
        // Upload background image to Firebase Storage
        String backgroundImageFileName = 'background.jpg';
        final backgroundImageRef = FirebaseStorage.instance
            .ref()
            .child(widget.collectionName)
            .child(documentFolderName)
            .child(imageNameFolderName)
            .child('Background')
            .child(backgroundImageFileName);
        await backgroundImageRef.putFile(_backgroundImage!);
        // Get download URL of the uploaded background image
        backgroundImageUrl = await backgroundImageRef.getDownloadURL();
      }

      // Upload showcase images to Firebase Storage
      List<String> showcaseImageUrls = [];
      for (var showcaseImage in _showcaseImages) {
        // Upload showcase image to Firebase Storage
        String showcaseImageFileName =
            'showcase_${_showcaseImages.indexOf(showcaseImage)}.jpg';
        final showcaseImageRef = FirebaseStorage.instance
            .ref()
            .child(widget.collectionName)
            .child(documentFolderName)
            .child(imageNameFolderName)
            .child('Showcase')
            .child(showcaseImageFileName);
        await showcaseImageRef.putFile(showcaseImage);
        // Get download URL of the uploaded showcase image
        String showcaseImageUrl = await showcaseImageRef.getDownloadURL();
        showcaseImageUrls.add(showcaseImageUrl);
      }

      // Store data and image URLs in Firestore
      await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(_titleController.text)
          .set({
        'imageName': _titleController.text,
        'photographerName': _photographerController.text,
        'videographerName': _videographerController.text,
        'editorName': _editorController.text,
        'imageUrl': backgroundImageUrl,
        'showcase': showcaseImageUrls,
      });

      print('Data and images uploaded successfully!');
      Navigator.of(context).pop();
    } catch (e) {
      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error uploading data and images: $e');
    } finally {
      context.loaderOverlay.hide(); // Hide loading indicator
    }
  }
}
