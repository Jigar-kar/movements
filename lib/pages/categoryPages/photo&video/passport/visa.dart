import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moments/pages/categoryPages/photo&video/passport/booking_passport.dart';
import 'package:moments/pages/categoryPages/photo&video/passport/reprint.dart';

class VisaPage extends StatelessWidget {
  final String description;
  final String size;
  final String imagePath;

  const VisaPage({
    required this.description,
    required this.size,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text('Country: $description'),
              Text('Size: $size'),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingPassportPage()));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // Optional: Change the color of the circle
                        ),
                        child: Center(
                          child: Icon(
                            Icons
                                .add_a_photo, // Replace Icons.check with your desired icon
                            color: Colors
                                .white, // Optional: Change the color of the icon
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Capture new photo for ${description}",
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Or"),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => (ReprintPage())));
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // Optional: Change the color of the circle
                        ),
                        child: Center(
                          child: Icon(
                            Icons
                                .replay, // Replace Icons.check with your desired icon
                            color: Colors
                                .white, // Optional: Change the color of the icon
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Reprint the previous capture photo",
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
