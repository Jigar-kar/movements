import 'package:flutter/material.dart';
import 'package:moments/utilis/getdata.dart';

class AlbumDesignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Album Design'),
        ),
        body: GetData(collectionName: 'Album Design')
        // Center(
        //   child: Text("this is my page"),
        // ),
        );
  }
}
