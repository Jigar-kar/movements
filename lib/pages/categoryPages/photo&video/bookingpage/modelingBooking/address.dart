import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/upi.dart';

class AddressPage extends StatefulWidget {
  final String selectedPackage;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final int selectedPrice;
  final String description;

  AddressPage(
      {required this.selectedPackage,
      required this.selectedDate,
      required this.selectedTimeSlot,
      required this.description,
      required this.selectedPrice});
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String name = '';
  String phoneNumber = '';
  String address = '';
  String pincode = '';
  String country = '';
  String? selectedState;
  String? selectedCity;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Address page")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(57, 158, 158, 158),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(57, 158, 158, 158),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length != 10) {
                    return 'Phone number should be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(57, 158, 158, 158),
                ),
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Pincode',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: const Color.fromARGB(57, 158, 158, 158),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  setState(() {
                    pincode = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pincode';
                  } else if (value.length != 6) {
                    return 'Pincode should be 6 digits';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CSCPicker(
                defaultCountry: CscCountry.India,
                disabledDropdownDecoration: BoxDecoration(
                    color: const Color.fromARGB(57, 158, 158, 158),
                    border: Border.all(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                dropdownDecoration: BoxDecoration(
                    color: const Color.fromARGB(57, 158, 158, 158),
                    border: Border.all(width: 1.0, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                disableCountry: true,
                onCountryChanged: (country) {
                  setState(() {
                    this.country = country;
                  });
                },
                onStateChanged: (state) {
                  if (state != null) {
                    setState(() {
                      selectedState = state;
                    });
                  }
                },
                onCityChanged: (city) {
                  if (city != null) {
                    setState(() {
                      selectedCity = city;
                    });
                  }
                },
              ),
              SizedBox(height: 180),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)), backgroundColor: Color.fromRGBO(220, 26, 26, 1),
                    foregroundColor: Colors.white,
                    fixedSize: Size(290, 54)),
                onPressed: () async {
                  // Get current user
                  User? user = _auth.currentUser;
                  if (user != null) {
                    // Create a map of data to be added
                    Map<String, dynamic> orderData = {
                      'name': name,
                      'phoneNumber': phoneNumber,
                      'address': address,
                      'pincode': pincode,
                      'country': country,
                      'state': selectedState ?? '',
                      'city': selectedCity,
                    };

                    try {
                      // Create a reference to the document with the current user's email as the document ID
                      DocumentReference userDocRef =
                          _firestore.collection('orderlist').doc(user.email);

                      // Check if the document already exists
                      bool docExists =
                          await userDocRef.get().then((doc) => doc.exists);

                      if (!docExists) {
                        // If the document doesn't exist, create it with the 'email' field
                        await userDocRef.set({
                          'email': user.email,
                          'name': user.displayName,
                          'profile': user.photoURL
                        });
                      }

                      // Add the order data to the 'orders' subcollection
                      await userDocRef.collection('Address').add(orderData);

                      print("Order added successfully!");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            selectedPackage: widget.selectedPackage,
                            selectedDate: widget.selectedDate,
                            selectedTimeSlot: widget.selectedTimeSlot,
                            description: widget.description,
                            selectedPrice: widget.selectedPrice,
                          ),
                        ),
                      );
                    } catch (error) {
                      print("Failed to add order: $error");
                    }
                  } else {
                    print("User not logged in.");
                  }
                },
                child: Text("Done"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void addOrder(String userEmail) async {
  try {
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Create a document with the current user's email as the document ID
    DocumentReference userDocRef =
        firestore.collection('orderlist').doc(userEmail);

    // Add a collection named 'order' inside the document
    CollectionReference orderCollectionRef = userDocRef.collection('order');

    // Add a document inside the 'order' collection
    await orderCollectionRef.add({
      'name': 'John Doe',
      'phoneNumber': '+1234567890',
      'address': '123 Main St, City, Country',
    });

    print('Order added successfully.');
  } catch (e) {
    print('Error adding order: $e');
  }
}
