import 'package:flutter/material.dart';
// import 'package:moments/utilis/design.dart';
import 'package:moments/utilis/getdata.dart';

class AniversaryShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Anniversary'),
        ),
        body: GetData(collectionName: "Anniversary")
        //SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         // Adjust the height as needed
        //         child: MySlider(
        //           title: 'Carousel Example',
        //           description: 'Description goes here',
        //           items: [
        //             SliderItem(
        //               imageUrl:
        //                   'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_2.jpg?alt=media&token=dfd59c07-c5a0-4b58-aefa-4ed58a423eca',
        //               imageName: 'Image Name 1',
        //               photographerName: 'Photographer Name 1',
        //               videographerName: 'Videographer Name 1',
        //               editorName: 'Editor Name 1',
        //               showcase: [
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_2.jpg?alt=media&token=dfd59c07-c5a0-4b58-aefa-4ed58a423eca',
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_1.jpg?alt=media&token=3de372e6-ba98-418d-843a-66ccdd77b24d',
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_2.jpg?alt=media&token=dfd59c07-c5a0-4b58-aefa-4ed58a423eca',
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_1.jpg?alt=media&token=3de372e6-ba98-418d-843a-66ccdd77b24d'
        //               ],
        //             ),
        //             SliderItem(
        //               imageUrl:
        //                   'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_1.jpg?alt=media&token=3de372e6-ba98-418d-843a-66ccdd77b24d',
        //               imageName: 'Image Name 2',
        //               photographerName: 'Photographer Name 2',
        //               videographerName: 'Videographer Name 2',
        //               editorName: 'Editor Name 2',
        //               showcase: [
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_2.jpg?alt=media&token=dfd59c07-c5a0-4b58-aefa-4ed58a423eca',
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_1.jpg?alt=media&token=3de372e6-ba98-418d-843a-66ccdd77b24d',
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_2.jpg?alt=media&token=dfd59c07-c5a0-4b58-aefa-4ed58a423eca',
        //                 'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Ftuu%2Fimage_1.jpg?alt=media&token=3de372e6-ba98-418d-843a-66ccdd77b24d'
        //               ],
        //             ),
        //             // Add more SliderItem objects as needed
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
