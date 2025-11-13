import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PassportAddpackage extends StatefulWidget {
  @override
  _AdminPackageListState createState() => _AdminPackageListState();
}

class _AdminPackageListState extends State<PassportAddpackage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  void _showAddPackageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Package Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Package Name',
                ),
              ),
              Text(
                'Once added, the package name cannot be changed.',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                    fontSize: 10),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Add package details logic here
                String packageName = _nameController.text;
                String description = _descriptionController.text;
                double price = double.tryParse(_priceController.text) ?? 0.0;
                print('Package Name: $packageName');
                print('Description: $description');
                print('Price: $price');

                // Add package details to Firestore document
                await FirebaseFirestore.instance
                    .collection('passportprice')
                    .doc(packageName)
                    .set({
                  'name': packageName,
                  'description': description,
                  'price': price,
                });

                // Reset text controllers
                _nameController.clear();
                _descriptionController.clear();
                _priceController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Add Package'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddPackageDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('passportprice')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No passportprice available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var packageData = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10), // Adjust margin as needed
                          padding:
                              EdgeInsets.all(10), // Adjust padding as needed
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(72, 158, 158,
                                158), // Background color of the container
                            border:
                                Border.all(color: Colors.grey), // Add border
                            borderRadius:
                                BorderRadius.circular(10), // Add border radius
                          ),
                          child: ListTile(
                            title: Text(
                              packageData['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  packageData['description'],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '\₹${packageData['price']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      size: 20), // Set the size of the icon
                                  onPressed: () {
                                    // Implement update logic here
                                    _nameController.text = packageData['name'];
                                    _descriptionController.text =
                                        packageData['description'];
                                    _priceController.text =
                                        packageData['price'].toString();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Update Package Details'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                enabled: false,
                                                controller: _nameController,
                                                decoration: InputDecoration(
                                                  labelText: 'Package Name',
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              TextFormField(
                                                controller:
                                                    _descriptionController,
                                                decoration: InputDecoration(
                                                  labelText: 'Description',
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              TextFormField(
                                                controller: _priceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Price',
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                // Update package details logic here
                                                String packageName =
                                                    _nameController.text;
                                                String description =
                                                    _descriptionController.text;
                                                double price = double.tryParse(
                                                        _priceController
                                                            .text) ??
                                                    0.0;

                                                // Update package details in Firestore document
                                                await FirebaseFirestore.instance
                                                    .collection('passportprice')
                                                    .doc(packageData['name'])
                                                    .update({
                                                  'name': packageName,
                                                  'description': description,
                                                  'price': price,
                                                });

                                                // Reset text controllers
                                                _nameController.clear();
                                                _descriptionController.clear();
                                                _priceController.clear();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Update'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 20), // Set the size of the icon
                                  onPressed: () {
                                    // Implement delete logic here
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirm Deletion'),
                                          content: Text(
                                              'Are you sure you want to delete this package?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // Delete package logic here
                                                await FirebaseFirestore.instance
                                                    .collection('passportprice')
                                                    .doc(packageData['name'])
                                                    .delete();

                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
