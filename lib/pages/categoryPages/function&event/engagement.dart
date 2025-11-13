import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:moments/utilis/design.dart';
import 'package:moments/utilis/getdata.dart';

class EngagementShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Engagement'),
        ),
        body: GetData(collectionName: 'Engagement'));
  }
}
