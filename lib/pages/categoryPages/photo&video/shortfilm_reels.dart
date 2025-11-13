import 'package:flutter/material.dart';
// import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/booking.dart';
import 'package:moments/utilis/abs.dart';

class ReelsShootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const listImages = [
      'asset/imges/fashionimg/01.jpg',
      'asset/imges/fashionimg/02.jpg',
      'asset/imges/fashionimg/04.jpg',
      'asset/imges/fashionimg/03.jpg',
      'asset/imges/fashionimg/04.jpg'
      // Add more image paths here
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text('Reels Shot'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MyItemCard(
                    title: "Video Shooting Service",
                    description:
                        "Effortless filming, professional results. Let us handle the filming while you focus on the moment. Receive expertly captured content ready for your creative touch.",
                    imagePaths: listImages,
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FashionBookingPage()));
                    }),
                MyItemCard(
                    title: "Editing Service",
                    description:
                        "Transform footage into magic. Send us your video, and our editing wizards will craft an engaging story with effects and precision for your audience.",
                    imagePaths: listImages,
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FashionBookingPage()));
                    }),
                MyItemCard(
                    title: "Video Shooting and Editing Service",
                    description:
                        "From vision to reality. Our team handles filming and editing, turning your story into a captivating, ready-to-share video experience.",
                    imagePaths: listImages,
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FashionBookingPage()));
                    })
              ],
            ),
          ),
        ));
  }
}
