import 'package:flutter/material.dart';
import 'package:moments/pages/categoryPages/other/Tishrt.dart';
import 'package:moments/pages/categoryPages/other/cup.dart';
import 'package:moments/pages/categoryPages/other/frame.dart';

class PersonalizeGiftPage extends StatelessWidget {
  // Sample list of products
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Customize Cap',
      'price': '\₹250',
      'image': 'asset/imges/cap.jpg', // Provide the path to your image asset
      'page': FramePage(), // Define the page to navigate to
    },
    {
      'name': 'Printed Cup',
      'price': '\₹10',
      'image': 'asset/imges/cup.jpeg', // Provide the path to your image asset
      'page': CupPage(), // Define the page to navigate to
    },
    {
      'name': 'Printed T-shirt',
      'price': '\₹20',
      'image':
          'asset/imges/tishart.jpg', // Provide the path to your image asset
      'page': TishartPage(), // Define the page to navigate to
    },
    {
      'name': 'Printed Pillow',
      'price': '\₹15',
      'image': 'asset/imges/pilow.jpeg', // Provide the path to your image asset
      'page': CupPage(), // Define the page to navigate to
    },
    {
      'name': 'Photo Frame',
      'price': '\₹25',
      'image': 'asset/imges/frame.png', // Provide the path to your image asset
      'page': FramePage(), // Define the page to navigate to
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalize Gift'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: products.map((product) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => product['page']),
                  );
                },
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 1.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Image.asset(
                              product['image'],
                              height: 100,
                              width: 350, // Adjust the height of the image
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Divider(), // Add a divider after the image
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              product['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 14.0),
                            // Text(
                            //   'Price: ${product['price']}',
                            //   style: TextStyle(
                            //     fontSize: 12.0,
                            //     color: Colors.green,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
