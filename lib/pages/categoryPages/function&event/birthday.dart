import 'package:flutter/material.dart';
// import 'package:moments/utilis/design.dart';
import 'package:moments/utilis/getdata.dart';

class BirthdayShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Birthday'),
        ),
        body: GetData(collectionName: 'Birthday')
        // SingleChildScrollView(
        //   child: (Column(
        //     children: [
        //       MySlider(
        //         title: 'Carousel Example',
        //         description: 'Description goes here',
        //         items: [
        //           SliderItem(
        //             imageUrl: 'URL',
        //             imageName: 'Image Name 1',
        //             photographerName: 'Photographer Name 1',
        //             videographerName: 'Videographer Name 1',
        //             editorName: 'Editor Name 1',
        //             showcase: [],
        //           ),
        //           SliderItem(
        //             imageUrl: 'URL',
        //             imageName: 'Image Name 2',
        //             photographerName: 'Photographer Name 2',
        //             videographerName: 'Videographer Name 2',
        //             editorName: 'Editor Name 2',
        //             showcase: [],
        //           ),
        //           // Add more SliderItem objects as needed
        //         ],
        //       ),
        //       // MySlider(
        //       //   title: "Basic Shoot",
        //       //   description:
        //       //       "Capture the joy of your birthday with our Basic Package, ensuring delightful photos that freeze the magic of your celebration.",
        //       //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //       //   //credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //       //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //       //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //       //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //       //   images: [
        //       //     'https://firebasestorage.googleapis.com/v0/b/moment-3456f.appspot.com/o/Modeling%2Fb%2Fimage_0.jpg?alt=media&token=fdfe0b95-6e3d-4e9b-9225-5fe2ab98b317',
        //       //     'asset/imges/categoryimg/modeling.jpg',
        //       //     'asset/imges/categoryimg/cinematic.jpg',
        //       //     'asset/imges/categoryimg/advertising.jpg',
        //       //   ],
        //       //   onPressed: () {}, mainimage: '',
        //       // ),
        //       // MySlider(
        //       //   title: "Standard Shoot",
        //       //   description:
        //       //       "Upgrade your birthday experience with our Standard Package, providing superior photos to immortalize the essence of your special day.",
        //       //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //       //   // credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //       //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //       //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //       //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //       //   images: [
        //       //     'asset/imges/categoryimg/product.jpg',
        //       //     'asset/imges/categoryimg/modeling.jpg',
        //       //     'asset/imges/categoryimg/cinematic.jpg',
        //       //     'asset/imges/categoryimg/advertising.jpg',
        //       //   ],
        //       //   onPressed: () {}, mainimage: '',
        //       // ),
        //       // MySlider(
        //       //   title: "Premium Shoot",
        //       //   description:
        //       //       "Transform your birthday into a spectacle with our Premium Package, featuring top-notch equipment for stunning photos and an unforgettable visual experience.",
        //       //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //       //   //credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //       //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //       //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //       //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //       //   images: [
        //       //     'asset/imges/categoryimg/product.jpg',
        //       //     'asset/imges/categoryimg/modeling.jpg',
        //       //     'asset/imges/categoryimg/cinematic.jpg',
        //       //     'asset/imges/categoryimg/advertising.jpg',
        //       //   ],
        //       //   onPressed: () {}, mainimage: '',
        //       // ),
        //     ],
        //   )),
        // ),
        );
  }
}
