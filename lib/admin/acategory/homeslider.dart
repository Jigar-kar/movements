import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:moments/admin/acategory/addslider.dart';
import 'package:moments/admin/acategory/homeaddslider.dart';
import 'package:moments/utilis/design.dart';

class HomeSlider extends StatefulWidget {
  final String collectionName;
  final String appbarTitle;
  HomeSlider({required this.collectionName, required this.appbarTitle});
  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
          title: Text(widget.appbarTitle),
          actions: [
            IconButton(
              onPressed: () => _showSliderDialog(),
              icon: Icon(Icons.add),
              tooltip: 'Add',
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('HomeSlider').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                var data = snapshot.data!.docs
                    .map((doc) => SliderItem(
                          imageUrl: doc['imageUrl'],
                          imageName: doc['imageName'],
                          photographerName: doc['photographerName'],
                          videographerName: doc['videographerName'],
                          editorName: doc['editorName'],
                          showcase: List<String>.from(doc['showcase']),
                          // documentId: doc.id,
                          sliderDataId:
                              "", // Ensure 'showcase' is treated as List<String>
                        ))
                    .toList();
                return MySliderData(
                  items: data,
                );
                // Display your data here, for example:
              }
              // If no data available, display a message
              return Center(
                child: Text('No data available'),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showSliderDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return HomeAddSliderDialog(collectionName: widget.collectionName);
      },
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return LoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (context) {
            return MyLoding(
              name: 'Uploading...',
            );
          },
          overlayColor: Colors.black.withOpacity(0.8),
          child: AlertDialog(
            title: Text('Add Slider'),
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
                onPressed: () async {
                  await _addDocument(context);
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addDocument(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      // Ensure that the title is not empty
      if (_titleController.text.isEmpty) {
        throw Exception('Title cannot be empty');
      }

      // Prepare data to store in Firestore
      var data = {
        'title': _titleController.text,
        'description': _descriptionController.text,
      };

      // Add document to Firestore
      await _firestore
          .collection(widget.collectionName)
          .doc(_titleController.text)
          .set(data);

      // Clear text fields after successful addition
      _titleController.clear();
      _descriptionController.clear();

      print('Document added successfully!');
    } catch (e) {
      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error adding document: $e');
    } finally {
      context.loaderOverlay.hide();
    }
  }
}
