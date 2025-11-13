import 'package:flutter/material.dart';
import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/booking.dart';
import 'package:moments/utilis/design.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPVdata extends StatefulWidget {
  final String collectionName;
  final String appbarTitle;

  GetPVdata({required this.collectionName, required this.appbarTitle});

  @override
  State<GetPVdata> createState() => _GetPVdataState();
}

class _GetPVdataState extends State<GetPVdata> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.appbarTitle),
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

              return MyItemCard(
                title: title,
                description: description,
                imagePaths: imageUrls,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => BookingPage(
                                documentId: documentId,
                                collectionName: widget.collectionName,
                              ))));
                  // Navigate or do something else when the butto is pressed
                },
              );
            },
          );
        },
      ),
    );
  }
}

// class ModelingType extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             MyItemCard(
//                 title: 'Portrait Photography',
//                 description: 'Ideal for model portfolios or comp cards.',
//                 imagePaths: [
//                   'asset/imges/categoryimg/product.jpg',
//                   'asset/imges/categoryimg/modeling.jpg',
//                   'asset/imges/categoryimg/cinematic.jpg',
//                   'asset/imges/categoryimg/advertising.jpg',
//                   'asset/imges/categoryimg/engagement.jpg'
//                   // Add more image paths here
//                 ],
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => PortraitBookingPage()));
//                 }),
//             MyItemCard(
//                 title: 'Commercial Photography',
//                 description: 'Showcasing products or services with models.',
//                 imagePaths: [
//                   'asset/imges/categoryimg/modeling.jpg',
//                   'asset/imges/categoryimg/product.jpg',
//                   'asset/imges/categoryimg/cinematic.jpg',
//                   'asset/imges/categoryimg/advertising.jpg',
//                   'asset/imges/categoryimg/engagement.jpg'

//                   // Add more image paths here
//                 ],
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => CommercialBookingPage()));
//                 }),

//             // Add more ModelingItems here for other options
//           ],
//         ),
//       ),
//     );
//   }
// }
