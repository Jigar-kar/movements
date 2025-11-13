import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:moments/pages/categoryPages/function&event/birthday.dart';
import 'package:moments/pages/categoryPages/function&event/pre-wedding.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:moments/pages/categoryPages/function&event/birthday.dart';
import 'package:moments/pages/categoryPages/function&event/wedding.dart';
import 'package:moments/pages/categoryPages/other/editing.dart';
import 'package:moments/pages/categoryPages/other/personalizegift.dart';
import 'package:moments/pages/categoryPages/photo&video/modeling.dart';
import 'package:moments/pages/categoryPages/photo&video/passport/passport.dart';
import 'package:moments/pages/categoryPages/photo&video/productshoot.dart';
import 'package:moments/pages/login.dart';
import 'package:moments/utilis/Auth.dart';
import 'package:moments/utilis/design.dart';
// import 'package:moments/utilis/getdata.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:moments/utilis/slide.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> buttonData = [
    {
      "icon": Icons.photo,
      "text": "Passport",
      "navigatepage": PassportShootPage()
    },
    {"icon": Icons.mode_edit, "text": "Edit", "navigatepage": EditingPage()},
    {
      "image": AssetImage("asset/imges/weddingicon.jpg"),
      "text": "Wedding",
      "navigatepage": WeddingShootPage()
    },
    {
      "image": AssetImage('asset/imges/categoryimg/pgift.jpg'),
      "text": "Customize",
      "navigatepage": PersonalizeGiftPage()
    },
  ];
  late User _user;
  late String _userName = '';
  late String _userProfileURL = '';

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;

    _userName = _user.displayName ?? 'User';
    _userProfileURL = _user.photoURL ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capture Moments"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: const Color.fromARGB(255, 46, 46, 46)),
              accountName: Text(_userName),
              accountEmail: Text(_user.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(_userProfileURL),
              ),
            ),
            ListTile(title: Text("My Order")),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => signOutUser().whenComplete(() =>
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('HomeSlider')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.hasData && snapshot.data != null) {
                  var data = snapshot.data!.docs
                      .map((doc) => SliderItem(
                            imageUrl: doc['imageUrl'],
                            imageName: doc['imageName'],
                            photographerName: doc['photographerName'],
                            videographerName: doc['videographerName'],
                            editorName: doc['editorName'],
                            showcase: List<String>.from(doc['showcase']),
                            // documentId: '',
                            sliderDataId:
                                '', // Ensure 'showcase' is treated as List<String>
                          ))
                      .toList();
                  return MySliderHome(items: data);
                  // Display your data here, for example:
                }
                // If no data available, display a message
                return Center(
                  child: Text('No data available'),
                );
              },
            ),
            // GetSliderData(collectionName: "Engagement"),
            // StreamBuilder(stream: FirebaseFirestore.instance.collection('Engagemnet'), builder: builder),
            //MySliderData(items: ),
            SizedBox(height: 20),
            GridView.builder(
              itemCount: buttonData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final data = buttonData[index];
                if (data.containsKey('icon')) {
                  return MyButton(
                    icon: data['icon'],
                    text: data['text'],
                    navigatepage: data['navigatepage'],
                  );
                } else if (data.containsKey('image')) {
                  return MyImgButton(
                    image: data['image'],
                    text: data['text'],
                    navigatepage: data['navigatepage'],
                  );
                }
                return Container(); // Return an empty container if data is invalid
              },
            ),
            SizedBox(height: 20),
            buildProductSection("Most Used"),
            SizedBox(height: 20),
            buildProductSection("Festival Special"),
          ],
        ),
      ),
    );
  }

  Widget buildProductSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              MyCard(
                image: AssetImage("asset/imges/Slider3.jpg"),
                text: "Birthday",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BirthdayShootPage()));
                },
              ),
              MyCard(
                image: AssetImage("asset/imges/Slider2.jpg"),
                text: "Pre-Wedding",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreWeddingShootPage()));
                },
              ),
              MyCard(
                image: AssetImage("asset/imges/categoryimg/product.jpg"),
                text: "Product Shoot",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GetPVdata(
                              collectionName: "ProductShoot",
                              appbarTitle: "Product Shoot")));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//carsoul img slider class
class HeroCarsoul extends StatelessWidget {
  final Slide catgory;
  const HeroCarsoul({
    super.key,
    required this.catgory,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
          child: Container(
        child: Stack(
          children: <Widget>[
            Image.asset(catgory.img, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 50.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                child: Text(
                  catgory.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  catgory.credit,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 35.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  catgory.photo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 25.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  catgory.video,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  catgory.edit,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 360,
              right: 15,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(106, 0, 0, 0)),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset("asset/imges/iconeIMG.png"),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class MyCard extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final VoidCallback? onTap;

  MyCard({required this.image, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 15, right: 8, left: 8),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(139, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget navigatepage;

  MyButton(
      {required this.icon, required this.text, required this.navigatepage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => navigatepage));
          // Add your button action here
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white, // Background color for the icon
                shape: BoxShape
                    .circle, // Shape of the container (circle for rounded)
              ),
              child: Icon(
                icon,
                color: Colors.black, // Icon color
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class MyImgButton extends StatelessWidget {
  final ImageProvider<Object> image;
  final String text;
  final Widget navigatepage;

  MyImgButton({
    required this.image,
    required this.text,
    required this.navigatepage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigatepage),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
