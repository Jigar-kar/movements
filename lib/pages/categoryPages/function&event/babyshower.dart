import 'package:flutter/material.dart';
// import 'package:moments/utilis/design.dart';
import 'package:moments/utilis/getdata.dart';

class BabyShowerShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Baby Shower'),
        ),
        body: GetData(collectionName: "BabyShower")
        // MySlider(
        //   title: "Basic Shoot",
        //   description:
        //       "Capture the joy of your baby shower with heartwarming photos and delightful videos in our Basic Package.",
        //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //   images: [
        //     'asset/imges/categoryimg/product.jpg',
        //     'asset/imges/categoryimg/modeling.jpg',
        //     'asset/imges/categoryimg/cinematic.jpg',
        //     'asset/imges/categoryimg/advertising.jpg',
        //   ],
        //   onPressed: () {},
        //   mainimage: '',
        // ),
        // MySlider(
        //   title: "Standard Shoot",
        //   description:
        //       "Elevate your baby shower memories with superior quality photos and videos in our Standard Package.",
        //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //   //credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //   images: [
        //     'asset/imges/categoryimg/product.jpg',
        //     'asset/imges/categoryimg/modeling.jpg',
        //     'asset/imges/categoryimg/cinematic.jpg',
        //     'asset/imges/categoryimg/advertising.jpg',
        //   ],
        //   onPressed: () {}, mainimage: '',
        // ),
        // MySlider(
        //   title: "Premium Shoot",
        //   description:
        //       "Create magic at your baby shower with enchanting photos and cinematic videos using top-notch equipment in our Premium Package.",
        //   names: ["akshay", "jack", "wcjcksdbxci", "iuack"],
        //   //credits: ["dasclcc", "icbscdsc", "wcjcksdbxci", "iuack"],
        //   photos: ["cisdcbsdc", "dcjbccwv", "wcjcksdbxci", "iuack"],
        //   videos: ["cdwsycjbwd", "wcjakbsdmzc", "wcjcksdbxci", "iuack"],
        //   edits: ["wcjcksdbxci", "iuack", "wcjcksdbxci", "iuack"],
        //   images: [
        //     'asset/imges/categoryimg/product.jpg',
        //     'asset/imges/categoryimg/modeling.jpg',
        //     'asset/imges/categoryimg/cinematic.jpg',
        //     'asset/imges/categoryimg/advertising.jpg',
        //   ],
        //   onPressed: () {}, mainimage: '',
        // ),

        );
  }
}
