import 'package:flutter/material.dart';
import 'package:moments/pages/categoryPages/function&event/aniversary.dart';
import 'package:moments/pages/categoryPages/function&event/babyshower.dart';
import 'package:moments/pages/categoryPages/function&event/birthday.dart';
import 'package:moments/pages/categoryPages/function&event/engagement.dart';
import 'package:moments/pages/categoryPages/function&event/function.dart';
import 'package:moments/pages/categoryPages/function&event/party.dart';
import 'package:moments/pages/categoryPages/function&event/pre-wedding.dart';
import 'package:moments/pages/categoryPages/function&event/wedding.dart';
import 'package:moments/pages/categoryPages/other/albumdesign.dart';
import 'package:moments/pages/categoryPages/other/editing.dart';
import 'package:moments/pages/categoryPages/other/personalizegift.dart';
import 'package:moments/pages/categoryPages/photo&video/modeling.dart';
import 'package:moments/pages/categoryPages/photo&video/passport/passport.dart';
import 'package:moments/pages/categoryPages/photo&video/productshoot.dart';
import 'package:moments/pages/categoryPages/photo&video/shortfilm_reels.dart';
import 'package:moments/pages/categoryPages/photo&video/travel_buddy.dart';

class AcategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Photography & Videography',
      'items': [
        {'name': 'Modeling', 'image': 'asset/imges/categoryimg/modeling.jpg'},
        {'name': 'Passport', 'image': 'asset/imges/categoryimg/passport.jpg'},
        {
          'name': 'Product Shoot',
          'image': 'asset/imges/categoryimg/product.jpg'
        },
        {
          'name': 'Travel Buddy',
          'image': 'asset/imges/categoryimg/travelbuddy.jpg'
        },

        {
          'name': 'ShortFilm/Reels',
          'image': 'asset/imges/categoryimg/reels.jpg'
        },

        // Add more items with names and image paths as needed
      ]
    },
    {
      'title': 'Function & Event',
      'items': [
        {
          'name': 'Engagement',
          'image': 'asset/imges/categoryimg/engagement.jpg'
        },
        {
          'name': 'Pre-Wedding',
          'image': 'asset/imges/categoryimg/pre-wedding.jpg'
        },
        {'name': 'Wedding', 'image': 'asset/imges/categoryimg/wedding.jpg'},
        {'name': 'Baby Shower', 'image': 'asset/imges/categoryimg/baby.jpg'},
        {'name': 'Birthday', 'image': 'asset/imges/categoryimg/birthday.JPG'},
        {
          'name': 'Anniversary',
          'image': 'asset/imges/categoryimg/anniversary.JPG'
        },
        {'name': 'Party', 'image': 'asset/imges/categoryimg/event.jpg'},
        {'name': 'Fastival', 'image': 'asset/imges/categoryimg/Festival.jpeg'},
        // Add more items with names and image paths as needed
      ]
    },
    {
      'title': 'Other',
      'items': [
        {
          'name': 'Personalize Gift',
          'image': 'asset/imges/categoryimg/pgift.jpg'
        },
        {'name': 'Album Design', 'image': 'asset/imges/categoryimg/album.jpg'},
        {'name': 'Editing', 'image': 'asset/imges/categoryimg/editing.jpg'},
        // Add more items with names and image paths as needed
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                   Capture Moments'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  categories[index]['title'],
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories[index]['items'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  // crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int itemIndex) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to different pages based on index
                      switch (index) {
                        case 0:
                          _navigateToPage(context, itemIndex);
                          break;
                        case 1:
                          _navigateToPage(context, itemIndex + 5);
                          break;
                        case 2:
                          _navigateToPage(context, itemIndex + 13);
                          break;
                        // Add more cases for additional categories/pages
                        default:
                          break;
                      }
                    },
                    child: GridTile(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: AssetImage(categories[index]['items']
                                        [itemIndex]['image']),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(height: 10),
                          Text(
                            categories[index]['items'][itemIndex]['name'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Divider(thickness: 3, color: Colors.transparent),
            ],
          );
        },
      ),
    );
  }
}

void _navigateToPage(BuildContext context, int pageIndex) {
  switch (pageIndex) {
    case 0:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GetPVdata(
                    appbarTitle: "Modeling Photo Shoot",
                    collectionName: "Modeling",
                  )));
      break;
    case 1:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PassportShootPage()));
      break;
    case 2:
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GetPVdata(
                  collectionName: "ProductShoot",
                  appbarTitle: "Product Shoot")));
      break;
    case 3:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TravelBuddyShootPage()));
      break;

    case 4:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ReelsShootPage()));
      break;

    case 5:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EngagementShootPage()));
      break;
    case 6:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PreWeddingShootPage()));
      break;
    case 7:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WeddingShootPage()));
      break;
    case 8:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BabyShowerShootPage()));
      break;

    case 9:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BirthdayShootPage()));
      break;
    case 10:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AniversaryShootPage()));
      break;
    case 11:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PartyShootPage()));
      break;
    case 12:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FestivalShootPage()));
      break;
    case 13:
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PersonalizeGiftPage()));
      break;
    case 14:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AlbumDesignPage()));
      break;
    case 15:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditingPage()));
      break;

    // Add more cases for additional pages as needed
    default:
      break;
  }
}
