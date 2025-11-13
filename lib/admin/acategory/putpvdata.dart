import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moments/admin/acategory/apackage.dart';
import 'dart:math';

import 'package:moments/utilis/design.dart';

class PutPVdata extends StatefulWidget {
  final String collectionName;
  final String appbarTitle;

  PutPVdata({required this.collectionName, required this.appbarTitle});

  @override
  State<PutPVdata> createState() => _PutPVdataState();
}

class _PutPVdataState extends State<PutPVdata> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<File> _selectedImages = [];
  bool _isUploading = false;

  Future<void> _showAddDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Document'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _selectImages();
                      setState(() {}); // Update the state to reflect changes
                    },
                    child: Text('Select Images'),
                  ),
                  SizedBox(height: 16),
                  Text('Selected Images: ${_selectedImages.length}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _addDocument();
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _selectImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(imageQuality: 50);

    setState(() {
      _selectedImages.clear();
      _selectedImages
          .addAll(pickedImages.map((pickedImage) => File(pickedImage.path)));
    });
  }

  Future<void> _uploadImages(String title) async {
    try {
      for (int i = 0; i < _selectedImages.length; i++) {
        File image = _selectedImages[i];
        String fileName = 'image_$i.jpg';

        firebase_storage.Reference storageRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child(widget.collectionName)
            .child('/$title/$fileName');

        firebase_storage.UploadTask uploadTask = storageRef.putFile(image);

        // Update the uploaded bytes
        setState(() {});

        await uploadTask;
      }

      // After all uploads are completed, update the state

      print('All images uploaded successfully!');
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  Future<void> _addDocument() async {
    context.loaderOverlay.show();

    try {
      await _uploadImages(_titleController.text);

      List<String> urls = [];

      for (int i = 0; i < _selectedImages.length; i++) {
        final imageRef = firebase_storage.FirebaseStorage.instance.ref(
            '${widget.collectionName}/${_titleController.text}/image_$i.jpg');
        String downloadUrl = await imageRef.getDownloadURL();
        urls.add(downloadUrl);
      }

      await _firestore
          .collection(widget.collectionName)
          .doc(_titleController.text)
          .set({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'urls': urls,
      });

      _titleController.clear();
      _descriptionController.clear();
      _selectedImages.clear();

      print('Document added successfully!');
    } catch (e) {
      print('Error adding document: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (context) {
        return MyLoding(
          name: 'Uploading...',
        );
      },
      overlayColor: Colors.black.withOpacity(0.8),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.appbarTitle),
          actions: [
            IconButton(
              onPressed: _showAddDialog,
              icon: Icon(Icons.add),
              tooltip: 'Add',
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection(widget.collectionName).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var title = doc['title'] as String;
                var description = doc['description'] as String;
                var imageUrls = List<String>.from(doc['urls']);
                var documentId = doc.id;

                return MyAdminCard(
                  title: title,
                  description: description,
                  imagePaths: imageUrls,
                  onPressedDel: () {
                    deleteDocument(documentId, imageUrls);
                  },
                  onPressedUpdate: () {
                    _showUpdateDialog(
                        documentId, title, description, imageUrls);
                  },
                  onPressedPackage: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminPackageList(
                          documentId: documentId,
                          collectionName: widget.collectionName,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteDocument(String documentId, List<String> imageUrls) async {
    try {
      // Delete document from Firestore
      await _firestore
          .collection(widget.collectionName)
          .doc(documentId)
          .delete();
      print('Document deleted successfully!');

      // Delete images from Firebase Storage
      for (String imageUrl in imageUrls) {
        await firebase_storage.FirebaseStorage.instance
            .refFromURL(imageUrl)
            .delete();
        print('Image deleted successfully: $imageUrl');
      }
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> _showUpdateDialog(String documentId, String title,
      String description, List<String> imageUrls) async {
    final TextEditingController newTitleController =
        TextEditingController(text: title);
    final TextEditingController newDescriptionController =
        TextEditingController(text: description);
    final List<File> newSelectedImages = [];

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Update Document'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: newTitleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: newDescriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    SizedBox(height: 16),
                    if (imageUrls.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: imageUrls.map((imageUrl) {
                            return GestureDetector(
                              onLongPress: () {
                                _showDeleteImageDialog(imageUrl);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  imageUrl,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await _selectNewImages(newSelectedImages);
                        setState(() {}); // Update the state to reflect changes
                      },
                      child: Text('Select New Images'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _updateDocument(
                        documentId,
                        newTitleController.text,
                        newDescriptionController.text,
                        imageUrls,
                        newSelectedImages);
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updateDocument(
      String documentId,
      String newTitle,
      String newDescription,
      List<String> existingImageUrls,
      List<File> newImages) async {
    context.loaderOverlay.show();
    try {
      if (newImages.isNotEmpty) {
        // Upload new images and update document with existing and new image URLs
        await _uploadNewImages(newTitle, newImages, existingImageUrls);
      } else {
        // If no new images, update only title and description
        await _firestore
            .collection(widget.collectionName)
            .doc(documentId)
            .update({
          'title': newTitle,
          'description': newDescription,
        });
      }

      print('Document updated successfully!');
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      print('Error updating document: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }

  Future<void> _showDeleteImageDialog(String imageUrl) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteImage(imageUrl);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadNewImages(
      String title, List<File> newImages, List<String> existingUrls) async {
    final firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(widget.collectionName)
        .child('/$title');

    List<String> newUrls = [];

    for (int i = 0; i < newImages.length; i++) {
      File image = newImages[i];
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String random = '${Random().nextInt(10000)}';
      String fileName = 'image_$timestamp$random.jpg';

      firebase_storage.UploadTask uploadTask =
          storageRef.child(fileName).putFile(image);
      await uploadTask;

      // Retrieve download URL for the uploaded image
      String downloadUrl = await storageRef.child(fileName).getDownloadURL();
      newUrls.add(downloadUrl);
    }

    // Combine existing URLs with new URLs
    List<String> allUrls = [...existingUrls, ...newUrls];

    // Update document in Firestore with combined list of image URLs
    await _firestore.collection(widget.collectionName).doc(title).update({
      'urls': allUrls,
    });
  }

  void _deleteImage(String imageUrl) async {
    try {
      // Delete the image from Firebase Storage
      await firebase_storage.FirebaseStorage.instance
          .refFromURL(imageUrl)
          .delete();

      // Remove the image URL from Firestore
      await _removeImageUrlFromFirestore(imageUrl);

      print('Image deleted successfully: $imageUrl');
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  Future<void> _removeImageUrlFromFirestore(String imageUrl) async {
    try {
      // Query Firestore to find documents containing the image URL
      QuerySnapshot querySnapshot = await _firestore
          .collection(widget.collectionName)
          .where("urls", arrayContains: imageUrl)
          .get();

      // Iterate through documents and remove the URL from the array field
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await _firestore.collection(widget.collectionName).doc(doc.id).update({
          'urls': FieldValue.arrayRemove([imageUrl]),
        });
      }
    } catch (e) {
      print('Error removing image URL from Firestore: $e');
    }
  }

  Future<void> _selectNewImages(List<File> newSelectedImages) async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(imageQuality: 50);

    if (pickedImages != null) {
      newSelectedImages.clear();
      newSelectedImages
          .addAll(pickedImages.map((pickedImage) => File(pickedImage.path)));
    }
  }
}
