import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class FramePage extends StatefulWidget {
  const FramePage({Key? key}) : super(key: key);

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String selectedInch = '1'; // Variable to store the selected inch value
  late String imageUrl = ''; // Initialize imageUrl with an empty string
  List<String> imageUrls =
      []; // List to store image URLs fetched from Firestore
  String? selectedImageUrl; // Variable to store the URL of the selected image

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageRef =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
      await storageRef.putFile(file);
      final url = await storageRef.getDownloadURL();

      // Store image URL in Firestore
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('orderlist').doc(user.email);
        final frameCollection = userDoc.collection('frame');
        await frameCollection.add({'imageUrl': url});
      }

      setState(() {
        imageUrl = url;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch image URLs from Firestore when the widget initializes
    _fetchImageUrls();
  }

  Future<void> _fetchImageUrls() async {
    final snapshot = await FirebaseFirestore.instance.collection('frame').get();
    final urls = snapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
    setState(() {
      imageUrls = urls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frame"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text(
              "Select frame size",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widthController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Width',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text("X"),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Height',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Select inch of frame",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: DropdownButton<String>(
                  value: selectedInch,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedInch = newValue!;
                    });
                  },
                  items: <String>['1', '2', '3'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('$value inch'),
                    );
                  }).toList(),
                  underline: SizedBox(), // Remove default underline
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Select image for frame",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _uploadImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Icon(Icons.add, size: 50, color: Colors.grey),
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Select frame",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: imageUrls.map((url) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImageUrl = url;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: url == selectedImageUrl
                            ? Colors.red
                            : Colors.transparent,
                        width: 2, // Adjust border width as needed
                      ),
                    ),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 130,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)), backgroundColor: Color.fromRGBO(220, 26, 26, 1),
                    foregroundColor: Colors.white,
                    fixedSize: Size(290, 54)),
                onPressed: () {
                  // Gather all the necessary data
                  String width = widthController.text;
                  String height = heightController.text;
                  String inch = selectedInch;
                  String frameImageUrl = selectedImageUrl ??
                      ''; // Selected frame URL or empty string if not selected

                  // Validate if all fields are filled
                  if (width.isEmpty ||
                      height.isEmpty ||
                      frameImageUrl.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content:
                              Text("Please fill in all the required fields."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                    return; // Stop execution if fields are not filled
                  }

                  print(
                      "Width: $width, Height: $height, Inch: $inch, Frame URL: $frameImageUrl");

                  // Insert data into Firestore
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    final userDoc = FirebaseFirestore.instance
                        .collection('orderlist')
                        .doc(user.email);
                    final ordersCollection = userDoc.collection('orders');

                    // Create a map with the data
                    Map<String, dynamic> orderData = {
                      'width': width,
                      'height': height,
                      'inch': inch,
                      'imageUrl': imageUrl,
                      'frameUrl': frameImageUrl,
                    };

                    print("Adding order data to Firestore: $orderData");

// Add the data to Firestore
                    ordersCollection.add(orderData).then((value) {
                      print("Order added to Firestore with ID: ${value.id}");

                      // Show success message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Success"),
                            content: Text("Order placed successfully."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }).catchError((error) {
                      // Show error message if insertion fails
                      print("Error adding order to Firestore: $error");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(
                                "Failed to place order. Please try again later."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }).catchError((error) {
                      // Show error message if insertion fails
                      print("Error adding order to Firestore: $error");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(
                                "Failed to place order. Please try again later."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  }
                },
                child: Text("Book"))
          ],
        ),
      ),
    );
  }
}
