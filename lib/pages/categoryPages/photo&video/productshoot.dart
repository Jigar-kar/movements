import 'package:flutter/material.dart';

// import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/booking.dart';
import 'package:moments/utilis/abs.dart';
import 'package:moments/utilis/storeURL.dart';

class ProductShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Product Shoot'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              MyItemCard(
                  title: "Flat Lay Shots",
                  description:
                      "Products arranged aesthetically on a flat surface and photographed from a bird's eye view. Ideal for showcasing multiple items together",
                  imagePaths: [
                    'asset/imges/fashionimg/flat1.jpg',
                    'asset/imges/fashionimg/flat2.jpg',
                    'asset/imges/fashionimg/flat3.jpg',
                    'asset/imges/fashionimg/flat4.jpg',
                    'asset/imges/fashionimg/flat5.jpg'
                    // Add more image paths here
                  ],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageRefUploader()));
                  }),
              // MyItemCard(
              //     title: "White Background / Cut-Out Shots",
              //     description:
              //         "Products photographed against a plain white background to highlight the item without distractions.",
              //     imagePaths: [
              //       'asset/imges/fashionimg/white.jpeg',
              //       'asset/imges/fashionimg/white2.jpg',
              //       'asset/imges/fashionimg/white3.jpg',
              //       'asset/imges/fashionimg/white4.jpeg',
              //       'asset/imges/fashionimg/white5.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => FashionBookingPage()));
              //     }),
              // MyItemCard(
              //     title: "Group  Shots",
              //     description:
              //         "Multiple products from the same line or category arranged together in a single image. Useful for showcasing product variations or collections.",
              //     imagePaths: [
              //       'asset/imges/fashionimg/group1.jpg',
              //       'asset/imges/fashionimg/group2.jpg',
              //       'asset/imges/fashionimg/group3.jpeg',
              //       'asset/imges/fashionimg/group4.jpeg',
              //       'asset/imges/fashionimg/group5.jpg',
              //       'asset/imges/fashionimg/group6.jpeg'
              //       // Add more ifashionimg paths here
              //     ],
              //     onPressed: () {
              //     //   Navigator.push(
              //     //       context,
              //     //       MaterialPageRoute(
              //     //           builder: (context) => FashionBookingPage()));
              //     // }),
              // MyItemCard(
              //     title: "Packaging  Shots",
              //     description:
              //         "Emphasizes the packaging of the product, showcasing design, logos, and special features of the packaging itself. Important for products where packaging is a key selling point.",
              //     imagePaths: [
              //       'asset/imges/fashionimg/pack1.jpg',
              //       'asset/imges/fashionimg/pack2.jpeg',
              //       'asset/imges/fashionimg/pack3.jpeg',
              //       'asset/imges/fashionimg/pack4.jpg',
              //       'asset/imges/fashionimg/pack5.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //     //   Navigator.push(
              //     //       context,
              //     //       MaterialPageRoute(
              //     //           builder: (context) => FashionBookingPage()));
              //     // }),
              // MyItemCard(
              //     title: "Lifestyle Shots",
              //     description:
              //         "Products captured in real-life settings or scenarios, showing how they are used in everyday life. This type of shot helps customers envision themselves using the product.",
              //     imagePaths: [
              //       'asset/imges/categoryimg/product.jpg',
              //       'asset/imges/categoryimg/modeling.jpg',
              //       'asset/imges/categoryimg/cinematic.jpg',
              //       'asset/imges/categoryimg/advertising.jpg',
              //       'asset/imges/categoryimg/engagement.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //     //   Navigator.push(
              //     //       context,
              //     //       MaterialPageRoute(
              //     //           builder: (context) => FashionBookingPage()));
              //      ;
              // MyItemCard(
              //     title: "360-Degree Product Shots",
              //     description:
              //         "Series of images taken from all angles, allowing viewers to rotate and view the product from various perspectives. Commonly used for online stores to offer an interactive viewing experience.",
              //     imagePaths: [
              //       'asset/imges/categoryimg/product.jpg',
              //       'asset/imges/categoryimg/modeling.jpg',
              //       'asset/imges/categoryimg/cinematic.jpg',
              //       'asset/imges/categoryimg/advertising.jpg',
              //       'asset/imges/categoryimg/engagement.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => FashionBookingPage()));
              //     }),
              // MyItemCard(
              //     title: "Detail Shots",
              //     description:
              //         "Close-up shots focusing on specific details or features of a product. This type of shot highlights intricate details, textures, or unique selling points.",
              //     imagePaths: [
              //       'asset/imges/categoryimg/product.jpg',
              //       'asset/imges/categoryimg/modeling.jpg',
              //       'asset/imges/categoryimg/cinematic.jpg',
              //       'asset/imges/categoryimg/advertising.jpg',
              //       'asset/imges/categoryimg/engagement.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => FashionBookingPage()));
              //     }),
              // MyItemCard(
              //     title: "Product in Use/Action Shots",
              //     description:
              //         "Shows the product being actively used or in action, demonstrating its functionality. This type of shot is effective for conveying the product's purpose.",
              //     imagePaths: [
              //       'asset/imges/categoryimg/product.jpg',
              //       'asset/imges/categoryimg/modeling.jpg',
              //       'asset/imges/categoryimg/cinematic.jpg',
              //       'asset/imges/categoryimg/advertising.jpg',
              //       'asset/imges/categoryimg/engagement.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => FashionBookingPage()));
              //     }),
              // MyItemCard(
              //     title: "Scale/Size Reference Shots",
              //     description:
              //         "Includes an object or person to provide a sense of scale or size for the product, especially useful for items with varying sizes or dimensions.",
              //     imagePaths: [
              //       'asset/imges/categoryimg/product.jpg',
              //       'asset/imges/categoryimg/modeling.jpg',
              //       'asset/imges/categoryimg/cinematic.jpg',
              //       'asset/imges/categoryimg/advertising.jpg',
              //       'asset/imges/categoryimg/engagement.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => FashionBookingPage()));
              //     }),
              // MyItemCard(
              //     title: "Creative/Artistic Shots",
              //     description:
              //         "Unconventional or artistic compositions that showcase the product in a unique or creative manner. These shots often focus on aesthetics and storytelling.",
              //     imagePaths: [
              //       'asset/imges/categoryimg/product.jpg',
              //       'asset/imges/categoryimg/modeling.jpg',
              //       'asset/imges/categoryimg/cinematic.jpg',
              //       'asset/imges/categoryimg/advertising.jpg',
              //       'asset/imges/categoryimg/engagement.jpg'
              //       // Add more image paths here
              //     ],
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => CommercialBookingPage()));
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
