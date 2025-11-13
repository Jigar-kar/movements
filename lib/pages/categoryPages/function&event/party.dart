import 'package:flutter/material.dart';
// import 'package:moments/utilis/design.dart';
import 'package:moments/utilis/getdata.dart';

class PartyShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Party'),
        ),
        body: GetData(collectionName: 'Party')
        // SingleChildScrollView(
        //   child: (Column(
        //     children: [
        //       // MySlider(
        //       //   title: "Basic Shoot",
        //       //   description:
        //       //       "Capture the energy of your party with our Basic Package, ensuring dynamic photos that tell the story of your lively celebration.",
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
        //       //       "Enhance your party experience with our Standard Package, offering superior quality photos to freeze the vibrant moments of your festive event",
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
        //       //       "Turn your party into a visual spectacle with our Premium Package, featuring top-notch equipment for stunning photos and an immersive visual journey.",
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
        // ),
        );
  }
}
