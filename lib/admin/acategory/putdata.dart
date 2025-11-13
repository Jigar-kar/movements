import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:moments/admin/acategory/addslider.dart';
import 'package:moments/utilis/design.dart';

class PutData extends StatefulWidget {
  final String collectionName;
  final String appbarTitle;

  PutData({required this.collectionName, required this.appbarTitle});

  @override
  State<PutData> createState() => _PutDataState();
}

class _PutDataState extends State<PutData> {
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
              onPressed: () => _showAddDialog(context),
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
                var documentId = doc.id;
                var itemsSnapshot =
                    doc.reference.collection('sliderdata').snapshots();

                return StreamBuilder<QuerySnapshot>(
                  stream: itemsSnapshot,
                  builder: (context, itemsSnapshot) {
                    if (itemsSnapshot.hasError) {
                      return Text('Error: ${itemsSnapshot.error}');
                    }
                    if (itemsSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (itemsSnapshot.data!.docs.isEmpty) {
                      // If 'sliderdata' is empty, display AddSlider
                      return AddSlider(
                        documentId: documentId,
                        title: title,
                        description: description,
                        onPressed: () =>
                            _showSliderDialog(context, documentId, title),
                      );
                    } else {
                      // If 'sliderdata' has data, display HaveSlider
                      // Inside the StreamBuilder for displaying HaveSlider widget

                      // Convert QueryDocumentSnapshot objects to SliderItem objects
                      var sliderItems = itemsSnapshot.data!.docs.map((doc) {
                        return SliderItem(
                          imageUrl: doc['imageUrl'],
                          imageName: doc['imageName'],
                          photographerName: doc['photographerName'],
                          videographerName: doc['videographerName'],
                          editorName: doc['editorName'],
                          showcase: List<String>.from(doc['showcase']),
                          sliderDataId: doc.id,
                        );
                      }).toList();

                      return HaveSlider(
                        title: title,
                        description: description,
                        items:
                            sliderItems, // Pass the list of SliderItem objects
                        onDeletePressed: () {
                          _deleteDocument(context, documentId);
                        },
                        onEditPressed: () {
                          _showEditDialog(
                              context, documentId, title, description);
                        },
                        onAddSliderPressed: () =>
                            _showSliderDialog(context, documentId, title),
                        onSliderDelete: (int index) {
                          _deleteSlider(
                            context,
                            documentId,
                            itemsSnapshot.data!.docs[index].id,
                          );
                        },
                        collectioName: widget.collectionName,
                        docid: documentId,
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _deleteSlider(
      BuildContext context, String documentId, String sliderDataId) async {
    try {
      // Get a reference to the specific slider data document
      DocumentReference sliderDataRef = _firestore
          .collection(widget.collectionName)
          .doc(documentId)
          .collection('sliderdata')
          .doc(sliderDataId); // Use sliderDataId here instead of documentId

      // Delete the slider data document
      await sliderDataRef.delete();

      print('Slider data deleted successfully');
    } catch (error) {
      print('Error deleting slider data: $error');
      // Handle error
    }
  }

//  void _deleteSlider(BuildContext context, String documentId, int index) async {
//   try {
//     // Check if the index is within the range of items list
//     if (index >= 0 && index < widget.items.length) {
//       // Get the unique identifier or index for the specific slider data document
//       String sliderDataId = widget.items[index].uniqueIdentifier;

//       // Get a reference to the specific slider data document
//       DocumentReference sliderDataRef = _firestore
//           .collection(widget.collectionName)
//           .doc(documentId)
//           .collection('sliderdata')
//           .doc(sliderDataId);

//       // Delete the slider data document
//       await sliderDataRef.delete();

//       // Optionally, you can update the local items list to reflect the deletion
//       setState(() {
//         widget.items.removeAt(index);
//       });

//       print('Slider data deleted successfully');
//     } else {
//       print('Invalid index');
//     }
//   } catch (error) {
//     print('Error deleting slider data: $error');
//     // Handle error
//   }
// }

  void _deleteDocument(BuildContext context, String documentId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this document?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                try {
                  await _firestore
                      .collection(widget.collectionName)
                      .doc(documentId)
                      .delete();
                  // Delete images from Firebase Storage if necessary
                  Navigator.of(context).pop(); // Close the confirmation dialog
                } catch (e) {
                  print('Error deleting document: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, String documentId,
      String currentTitle, String currentDescription) {
    TextEditingController titleController =
        TextEditingController(text: currentTitle);
    TextEditingController descriptionController =
        TextEditingController(text: currentDescription);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Document'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                String newTitle = titleController.text;
                String newDescription = descriptionController.text;

                try {
                  await _firestore
                      .collection(widget.collectionName)
                      .doc(documentId)
                      .update({
                    'title': newTitle,
                    'description': newDescription,
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error updating document: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSliderDialog(
    BuildContext context,
    String documentId,
    String title,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AddSliderDialog(
            documentId: documentId,
            title: title,
            collectionName: widget.collectionName);
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
