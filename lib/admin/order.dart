import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moments/admin/sendsoftcopy.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders List"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('orderlist').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Placeholder while waiting for data
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String email = data['email'] ?? 'N/A';
                String name = data['name'] ?? 'N/A';
                String photoURL = data['profile'] ?? 'N/A';
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(123, 255, 255, 255)),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(photoURL),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(name),
                              Text(email),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('orderlist')
                                    .doc(email)
                                    .collection('orders')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }
                                  return Text(
                                      'Number of Orders: ${snapshot.data!.docs.length}');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetails(documentReference: document.reference),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ));
  }
}

class OrderDetails extends StatelessWidget {
  final DocumentReference documentReference;

  const OrderDetails({Key? key, required this.documentReference})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: documentReference.collection('orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Placeholder while waiting for data
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  // Navigate to a different page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (SendSoftcopy()),
                    ),
                  );
                },
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      border: Border.all(
                          width: 2, color: Color.fromARGB(123, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: ListTile(
                    title: Text('Package: ${data['package'] ?? 'N/A'}'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('Date: ${data['date'] ?? 'N/A'}'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Time: ${data['time'] ?? 'N/A'}'),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Price:'),
                            Text(
                              "${data['price'] ?? 'N/A'}",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
