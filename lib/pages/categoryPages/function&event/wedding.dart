import 'package:flutter/material.dart';
// import 'package:moments/utilis/design.dart';
import 'package:moments/utilis/getdata.dart';

class WeddingShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wedding'),
        ),
        body: GetData(collectionName: 'Wedding')
        // SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: (Column(
        //       children: [
        //         MySlider(
        //           title: 'Carousel Example',
        //           description: 'Description goes here',
        //           items: [
        //             SliderItem(
        //               imageUrl: 'URL',
        //               imageName: 'Image Name 1',
        //               photographerName: 'Photographer Name 1',
        //               videographerName: 'Videographer Name 1',
        //               editorName: 'Editor Name 1',
        //               showcase: [],
        //             ),
        //             SliderItem(
        //               imageUrl: 'URL',
        //               imageName: 'Image Name 2',
        //               photographerName: 'Photographer Name 2',
        //               videographerName: 'Videographer Name 2',
        //               editorName: 'Editor Name 2',
        //               showcase: [],
        //             ),
        //             // Add more SliderItem objects as needed
        //           ],
        //         ),
        //         // MySlider(
        //         //   title: "Basic Shoot",
        //         //   description:
        //         //       "Start your journey with heartwarming photos and cinematic videos, capturing the pure essence of your love story in our Basic Package.",
        //         //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //         //   //credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //         //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //         //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //         //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //         //   images: [
        //         //     'asset/imges/categoryimg/product.jpg',
        //         //     'asset/imges/categoryimg/modeling.jpg',
        //         //     'asset/imges/categoryimg/cinematic.jpg',
        //         //     'asset/imges/categoryimg/advertising.jpg',
        //         //   ],
        //         //   onPressed: () {}, mainimage: '',
        //         // ),
        //         // MySlider(
        //         //   title: "Standard Shoot",
        //         //   description:
        //         //       "Elevate your wedding day with superior quality photos and videos, encapsulating the timeless romance of your union in our Standard Package.",
        //         //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //         //   //credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //         //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //         //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //         //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //         //   images: [
        //         //     'asset/imges/categoryimg/product.jpg',
        //         //     'asset/imges/categoryimg/modeling.jpg',
        //         //     'asset/imges/categoryimg/cinematic.jpg',
        //         //     'asset/imges/categoryimg/advertising.jpg',
        //         //   ],
        //         //   onPressed: () {}, mainimage: '',
        //         // ),
        //         // MySlider(
        //         //   title: "Premium Shoot",
        //         //   description:
        //         //       "Create an unforgettable spectacle of your love story with breathtaking photos and cinematic videos using top-notch equipment in our Premium Package.",
        //         //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //         //   //credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //         //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //         //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //         //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //         //   images: [
        //         //     'asset/imges/categoryimg/product.jpg',
        //         //     'asset/imges/categoryimg/modeling.jpg',
        //         //     'asset/imges/categoryimg/cinematic.jpg',
        //         //     'asset/imges/categoryimg/advertising.jpg',
        //         //   ],
        //         //   onPressed: () {}, mainimage: '',
        //         // ),
        //       ],
        //     )),
        //   ),
        // ),
        );
  }
}
