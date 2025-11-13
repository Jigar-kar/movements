import 'package:flutter/material.dart';
// import 'package:moments/utilis/design.dart';
import 'package:moments/utilis/getdata.dart';

class PreWeddingShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pre-Wedding'),
        ),
        body: GetData(collectionName: 'Pre-Wedding')
        // SingleChildScrollView(
        //   child: (Column(
        //     children: [
        //       // MySlider(
        //       //   title: "Basic Shoot",
        //       //   description:
        //       //       "Capture the essence of your pre-wedding journey with simple yet beautiful photos and videos.",
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
        //       //   title: "Standard Shoot",
        //       //   description:
        //       //       "Elevate your pre-wedding memories with enhanced visuals – superior quality photos and videos for cherished moments.",
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
        //       //       "Indulge in a luxurious pre-wedding experience, featuring stunning photos and videos captured with top-notch equipment for unforgettable moments.",
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
        //     ],
        //   )),

        );
  }
}
