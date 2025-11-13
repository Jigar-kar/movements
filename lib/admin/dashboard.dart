// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moments/admin/acategory/PutPVdata.dart';
import 'package:moments/admin/acategory/adminpgift.dart';
import 'package:moments/admin/acategory/apackage.dart';
import 'package:moments/admin/acategory/homeslider.dart';
import 'package:moments/admin/acategory/passpor_add_package.dart';
import 'package:moments/admin/acategory/putdata.dart';
// import 'package:moments/pages/categoryPages/photo&video/productshoot.dart';
import 'package:moments/pages/navigationBarPages/home.dart';
// import 'package:moments/utilis/slide.dart';

class AdminDashBorad extends StatefulWidget {
  const AdminDashBorad({super.key});

  @override
  State<AdminDashBorad> createState() => _AdminDashBoradState();
}

class _AdminDashBoradState extends State<AdminDashBorad> {
  final List<Map<String, dynamic>> AcategoryData = [
    {
      'name': 'Modeling',
      'image': AssetImage('asset/imges/categoryimg/modeling.jpg'),
      'navigatepage':
          PutPVdata(collectionName: 'Modeling', appbarTitle: 'Modeling')
    },
    {
      'name': 'Passport',
      'image': AssetImage('asset/imges/categoryimg/passport.jpg'),
      'navigatepage': PassportAddpackage()
    },
    {
      'name': 'Product Shoot',
      'image': AssetImage('asset/imges/categoryimg/product.jpg'),
      'navigatepage': PutPVdata(
          collectionName: 'ProductShoot', appbarTitle: 'Product Shoot')
    },
    {
      'name': 'Travel Buddy',
      'image': AssetImage('asset/imges/categoryimg/travelbuddy.jpg'),
      'navigatepage':
          PutPVdata(collectionName: 'TravelBuddy', appbarTitle: 'Travel Buddy')
    },
    {
      'name': 'ShortFilm/Reels',
      'image': AssetImage('asset/imges/categoryimg/reels.jpg'),
      'navigatepage': PutPVdata(
          collectionName: 'collectionName', appbarTitle: 'appbarTitle')
    },
    {
      'name': 'Engagement',
      'image': AssetImage('asset/imges/categoryimg/engagement.jpg'),
      'navigatepage':
          PutData(collectionName: 'Engagement', appbarTitle: 'Engagement')
    },
    {
      'name': 'Pre-Wedding',
      'image': AssetImage('asset/imges/categoryimg/pre-wedding.jpg'),
      'navigatepage':
          PutData(collectionName: 'Pre-Wedding', appbarTitle: 'Pre-Wedding')
    },
    {
      'name': 'Wedding',
      'image': AssetImage('asset/imges/categoryimg/wedding.jpg'),
      'navigatepage': PutData(
        collectionName: 'Wedding',
        appbarTitle: 'Wedding',
      )
    },
    {
      'name': 'Baby Shower',
      'image': AssetImage('asset/imges/categoryimg/baby.jpg'),
      'navigatepage':
          PutData(collectionName: "BabyShower", appbarTitle: "Baby Shower")
    },
    {
      'name': 'Birthday',
      'image': AssetImage('asset/imges/categoryimg/birthday.JPG'),
      'navigatepage': PutData(
        collectionName: 'Birthday',
        appbarTitle: 'Birthday',
      )
    },
    {
      'name': 'Anniversary',
      'image': AssetImage('asset/imges/categoryimg/anniversary.JPG'),
      'navigatepage': PutData(
        collectionName: 'Anniversary',
        appbarTitle: 'Anniversary',
      )
    },
    {
      'name': 'Party',
      'image': AssetImage('asset/imges/categoryimg/event.jpg'),
      'navigatepage': PutData(collectionName: 'Party', appbarTitle: 'Party')
    },
    {
      'name': 'Festival',
      'image': AssetImage('asset/imges/categoryimg/Festival.jpeg'),
      'navigatepage':
          PutData(collectionName: 'Festival', appbarTitle: 'Festival')
    },
    {
      'name': 'Personalize Gift',
      'image': AssetImage('asset/imges/categoryimg/pgift.jpg'),
      'navigatepage': AddFrameData()
    },
    {
      'name': 'Album Design',
      'image': AssetImage('asset/imges/categoryimg/album.jpg'),
      'navigatepage':
          PutPVdata(collectionName: 'Album Design', appbarTitle: 'Album Design')
    },
    {
      'name': 'Editing',
      'image': AssetImage('asset/imges/categoryimg/editing.jpg'),
      'navigatepage':
          PutPVdata(collectionName: 'Editing', appbarTitle: 'Editing')
    },
  ];

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        drawer: Drawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                height: 100,
                child: MyButton(
                    icon: Icons.add_a_photo,
                    text: "Add or Update Slider",
                    navigatepage: HomeSlider(
                      collectionName: 'HomeSlider',
                      appbarTitle: 'Slider',
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              GridView.builder(
                  itemCount: AcategoryData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 100,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final data = AcategoryData[index];

                    return MyImgButton(
                        image: data['image'],
                        text: data['name'],
                        navigatepage: data['navigatepage']);
                  }
                  // Return an empty container if data is invalid

                  ),

              //recent prodcut container
            ],
          ),
        ));
  }
}
