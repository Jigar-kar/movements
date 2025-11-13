import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/booking.dart';
import 'package:moments/utilis/design.dart';

class GetData extends StatefulWidget {
  final String collectionName;
  GetData({required this.collectionName});

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(widget.collectionName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData && snapshot.data != null) {
            var engagementDocs = snapshot.data!.docs;
            return Column(
              children: engagementDocs.map((engagementDoc) {
                var title = engagementDoc['title'];
                var description = engagementDoc['description'];
                var itemsSnapshot = engagementDoc.reference
                    .collection('sliderdata')
                    .snapshots();
                var documentId = engagementDoc.id;
                return StreamBuilder<QuerySnapshot>(
                  stream: itemsSnapshot,
                  builder: (context, itemsSnapshot) {
                    if (itemsSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (itemsSnapshot.hasError) {
                      return Text('Error: ${itemsSnapshot.error}');
                    }
                    var items = itemsSnapshot.data!.docs
                        .map((doc) => SliderItem(
                              imageUrl: doc['imageUrl'],
                              imageName: doc['imageName'],
                              photographerName: doc['photographerName'],
                              videographerName: doc['videographerName'],
                              editorName: doc['editorName'],
                              showcase: List<String>.from(doc['showcase']),
                              // documentId: '',
                              sliderDataId: '',
                            ))
                        .toList();
                    return MySlider(
                      title: title,
                      description: description,
                      items: items,
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
              }).toList(),
            );
          }
          return Text('No data available');
        },
      ),
    );
  }
}
