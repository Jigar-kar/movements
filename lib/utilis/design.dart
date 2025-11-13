import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file/src/interface/file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moments/admin/acategory/apackage.dart';
import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/booking.dart';
//import 'package:moments/pages/categoryPages/photo&video/modeling.dart';
import 'package:moments/pages/categoryPages/photo&video/passport/visa.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';

class MyLoding extends StatefulWidget {
  final String name;
  const MyLoding({super.key, required this.name});

  @override
  State<MyLoding> createState() => _MyLodingState();
}

class _MyLodingState extends State<MyLoding> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 74, 74, 74),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.red,
                    size: 40,
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      decoration: TextDecoration
                          .none, // Add this line to remove underline
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAdminCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> imagePaths;
  final VoidCallback onPressedDel;
  final VoidCallback onPressedUpdate;
  final VoidCallback onPressedPackage;

  const MyAdminCard(
      {required this.title,
      required this.description,
      required this.imagePaths,
      required this.onPressedDel,
      required this.onPressedUpdate,
      required this.onPressedPackage});

  @override
  _MyAdminCardState createState() => _MyAdminCardState();
}

class _MyAdminCardState extends State<MyAdminCard> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: const Color.fromARGB(123, 255, 255, 255),
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 9.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  showFullDescription = !showFullDescription;
                });
              },
              child: Text(
                showFullDescription
                    ? widget.description
                    : _getTrimmedDescription(),
                maxLines: showFullDescription ? 4 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < 3 && i < widget.imagePaths.length; i++)
                  _buildImageBox(context, widget.imagePaths[i], i),
              ],
            ),
            SizedBox(height: 15.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Align buttons in the center
                children: [
                  ElevatedButton.icon(
                    onPressed: widget.onPressedDel,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(151, 41, 41, 41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ), // Icon for the Delete button
                    label: Text(
                      'Delete',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  //SizedBox(width: 55.0), // Add some spacing between the buttons
                  ElevatedButton.icon(
                    onPressed: widget.onPressedUpdate,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(151, 41, 41, 41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    icon: Icon(
                      Icons.update,
                      color: Colors.blue,
                    ), // Icon for the Update button
                    label: Text(
                      'Update',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: widget.onPressedPackage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(151, 41, 41, 41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    icon: Icon(
                      Icons.price_change,
                      color: Colors.blue,
                    ), // Icon for the Update button
                    label: Text(
                      'Package',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBox(BuildContext context, String imagePath, int index) {
    return GestureDetector(
        onTap: () {
          if (widget.imagePaths.length > 3) {
            _showEnlargedImage(context, widget.imagePaths, index);
          }
        },
        onLongPress: () {
          _checkAdminUser(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: imagePath,
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return Container(
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              );
            },
            cacheManager: DefaultCacheManager(),
            fadeInDuration: Duration(milliseconds: 100),
          ),
        ));
  }

  void _checkAdminUser(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? uid = user.uid; // Get the UID of the currently logged-in user

      // Compare the UID with the UID of the admin user
      if (uid == "5a8XKzYyEPWc4CbcsT2f8RjRoF43") {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Admin Verification'),
            content: Text('You are an admin user.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showEnlargedImage(
      BuildContext context, List<String> imagePaths, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageSliderDialog(
          imagePaths: imagePaths,
          initialIndex: initialIndex,
        );
      },
    );
  }

  String _getTrimmedDescription() {
    if (widget.description.length > 100) {
      return '${widget.description.substring(0, 100)}...';
    }
    return widget.description;
  }
}

class MyItemCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> imagePaths;
  final VoidCallback onPressed;

  const MyItemCard({
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.onPressed,
  });

  @override
  _MyItemCardState createState() => _MyItemCardState();
}

class _MyItemCardState extends State<MyItemCard> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: const Color.fromARGB(123, 255, 255, 255),
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 9.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  showFullDescription = !showFullDescription;
                });
              },
              child: Text(
                showFullDescription
                    ? widget.description
                    : _getTrimmedDescription(),
                maxLines: showFullDescription ? 4 : 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < 3 && i < widget.imagePaths.length; i++)
                  _buildImageBox(context, widget.imagePaths[i], i),
              ],
            ),
            SizedBox(height: 8.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(151, 41, 41, 41),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  'Book an appointment',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBox(BuildContext context, String imagePath, int index) {
    return GestureDetector(
        onTap: () {
          if (widget.imagePaths.length > 3) {
            _showEnlargedImage(context, widget.imagePaths, index);
          }
        },
        onLongPress: () {
          _checkAdminUser(context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: imagePath,
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return Container(
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              );
            },
            cacheManager: DefaultCacheManager(),
            fadeInDuration: Duration(milliseconds: 100),
          ),
        ));
  }

  void _checkAdminUser(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? uid = user.uid; // Get the UID of the currently logged-in user

      // Compare the UID with the UID of the admin user
      if (uid == "5a8XKzYyEPWc4CbcsT2f8RjRoF43") {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Admin Verification'),
            content: Text('You are an admin user.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showEnlargedImage(
      BuildContext context, List<String> imagePaths, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageSliderDialog(
          imagePaths: imagePaths,
          initialIndex: initialIndex,
        );
      },
    );
  }

  String _getTrimmedDescription() {
    if (widget.description.length > 100) {
      return '${widget.description.substring(0, 100)}...';
    }
    return widget.description;
  }
}

class ImageSliderDialog extends StatefulWidget {
  final List<String> imagePaths;
  final int initialIndex;

  ImageSliderDialog({required this.imagePaths, required this.initialIndex});

  @override
  _ImageSliderDialogState createState() => _ImageSliderDialogState();
}

class _ImageSliderDialogState extends State<ImageSliderDialog> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: CarouselSlider.builder(
                itemCount: widget.imagePaths.length,
                options: CarouselOptions(
                  initialPage: widget.initialIndex,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (BuildContext context, int index, _) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.imagePaths[index],
                            cacheManager: DefaultCacheManager(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imagePaths.map((String path) {
                int index = widget.imagePaths.indexOf(path);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.white
                            .withOpacity(0.5) // Active dot color with opacity
                        : Colors.white.withOpacity(
                            0.2), // Inactive dot color with lower opacity
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10), // Adjust the spacing
          ],
        ),
      ),
    );
  }
}

class MyLayout extends StatelessWidget {
  final String title;
  final List<String> imagePaths;
  // Pages to navigate to on image click
  final List<String> descriptions;
  final List<String> size; // Descriptions for each image

  const MyLayout(
      {required this.title,
      required this.imagePaths,
      required this.descriptions,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: const Color.fromARGB(123, 255, 255, 255),
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  imagePaths.length,
                  (index) => _buildImageBox(
                    context,
                    imagePaths[index],
                    descriptions[index],
                    size[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBox(
      BuildContext context, String imagePath, String description, String size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VisaPage(
                          description: description,
                          size: size,
                          imagePath: imagePath)),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              description,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 3.0),
            Text(
              size,
              style: TextStyle(
                fontSize: 9,
                color: Color.fromARGB(123, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyLayoutForVisa extends StatelessWidget {
  final String title;
  final List<String> imagePaths;
  final List<String> descriptions;
  final List<String> size;

  const MyLayoutForVisa({
    required this.title,
    required this.imagePaths,
    required this.descriptions,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: const Color.fromARGB(123, 255, 255, 255),
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  imagePaths.length,
                  (index) => _buildImageBox(
                    context,
                    imagePaths[index],
                    descriptions[index],
                    size[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBox(
      BuildContext context, String imagePath, String description, String size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisaPage(
                      description: description,
                      size: size,
                      imagePath: imagePath,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              description,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 3.0),
            Text(
              size,
              style: TextStyle(
                fontSize: 9,
                color: Color.fromARGB(123, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderItem {
  final String imageUrl;
  final String imageName;
  final String photographerName;
  final String videographerName;
  final String editorName;
  final List<String> showcase;
  // New field for document ID
  final String sliderDataId;

  SliderItem(
      {required this.imageUrl,
      required this.imageName,
      required this.photographerName,
      required this.videographerName,
      required this.editorName,
      required this.showcase,
      required this.sliderDataId});
}

class MySliderData extends StatelessWidget {
  final List<SliderItem> items;

  MySliderData({required this.items});

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
          viewportFraction: 1,
          height: 170.0, // Fixed height of the slider
          autoPlay: false,
          enlargeCenterPage: false,
        ),
        items: items.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                    // Image.network(
                    //   item.imageUrl,
                    //   fit: BoxFit.cover,
                    //   width:
                    //       1000, // Ensure the image fits within the width of the slider
                    // ),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.imageName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Photographer: ${item.photographerName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'Videographer: ${item.videographerName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'Editor: ${item.editorName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: -10,
                      top: 60,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_sharp),
                        onPressed: () {
                          _controller.previousPage();
                        },
                      ),
                    ),
                    Positioned(
                      right: -10,
                      top: 60,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () {
                          _controller.nextPage();
                        },
                      ),
                    ),
                    Positioned(
                      right: 10.0,
                      bottom: 10.0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(100, 158, 158, 158),
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.photo_library,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  var images = item.showcase;
                                  return AlertDialog(
                                    title: const Text('Image Gallery'),
                                    content: Container(
                                      width: double.maxFinite,
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0,
                                        ),
                                        itemCount: images.length,
                                        itemBuilder: (context, index) {
                                          final imageUrl = images[index];
                                          return InkWell(
                                            onTap: () {
                                              // Tap on individual image
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenImagePage(
                                                    imageUrls: images,
                                                    initialIndex: index,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrl,
                                              fit: BoxFit.cover,
                                              width: 100.0,
                                              fadeInDuration:
                                                  Duration(milliseconds: 100),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey,
                                                highlightColor:
                                                    const Color.fromARGB(
                                                        255, 99, 90, 90),
                                                child: Container(
                                                  color:
                                                      Colors.white, // Optional
                                                  width: 100.0,
                                                  height:
                                                      100.0, // Adjust this according to your image size
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              cacheManager:
                                                  DefaultCacheManager(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            // Handle image icon click
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class AdminSliderData extends StatefulWidget {
  final List<SliderItem> items;
  final Function(int) onDeletePressed;
  AdminSliderData({required this.items, required this.onDeletePressed});

  @override
  State<AdminSliderData> createState() => _AdminSliderDataState();
}

class _AdminSliderDataState extends State<AdminSliderData> {
  final CarouselController _controller = CarouselController();
  bool isDeleteOptionVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
          viewportFraction: 1,
          height: 170.0, // Fixed height of the slider
          autoPlay: false,
          enlargeCenterPage: false,
        ),
        items: widget.items.asMap().entries.map((entry) {
          final int index = entry.key;
          final SliderItem item = entry.value;
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onLongPress: () {
                  // Show delete option on long press
                  setState(() {
                    isDeleteOptionVisible = true;
                  });
                },
                onTap: () {
                  // Show delete option on long press
                  setState(() {
                    isDeleteOptionVisible = false;
                  });
                },
                onLongPressEnd: (details) {
                  // Schedule hiding the delete option after 2 seconds
                  Timer(Duration(seconds: 3), () {
                    setState(() {
                      isDeleteOptionVisible = false;
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                      // Image.network(
                      //   item.imageUrl,
                      //   fit: BoxFit.cover,
                      //   width:
                      //       1000, // Ensure the image fits within the width of the slider
                      // ),
                      Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.imageName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Photographer: ${item.photographerName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              'Videographer: ${item.videographerName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                            Text(
                              'Editor: ${item.editorName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: -10,
                        top: 60,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_sharp),
                          onPressed: () {
                            _controller.previousPage();
                          },
                        ),
                      ),
                      Positioned(
                        right: -10,
                        top: 60,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_sharp),
                          onPressed: () {
                            _controller.nextPage();
                          },
                        ),
                      ),
                      Positioned(
                        right: 10.0,
                        bottom: 10.0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(100, 158, 158, 158),
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(
                                Icons.photo_library,
                                color: Colors.white,
                                size: 18.0,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    var images = item.showcase;
                                    return AlertDialog(
                                      title: const Text('Image Gallery'),
                                      content: Container(
                                        width: double.maxFinite,
                                        child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 4.0,
                                          ),
                                          itemCount: images.length,
                                          itemBuilder: (context, index) {
                                            final imageUrl = images[index];
                                            return InkWell(
                                              onTap: () {
                                                // Tap on individual image
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FullScreenImagePage(
                                                      imageUrls: images,
                                                      initialIndex: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl: imageUrl,
                                                fit: BoxFit.cover,
                                                width: 100.0,
                                                fadeInDuration:
                                                    Duration(milliseconds: 100),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                cacheManager:
                                                    DefaultCacheManager(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              // Handle image icon click
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isDeleteOptionVisible,
                        child: Center(
                          child: Container(
                            width:
                                double.infinity, // Adjust the width as needed
                            height:
                                double.infinity, // Adjust the height as needed
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(114, 171, 13,
                                  13), // Background color for the delete icon
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),

                                  color: Colors.white, // Icon color
                                  onPressed: () {
                                    // Handle delete button press
                                    widget.onDeletePressed(index);
                                    setState(() {
                                      isDeleteOptionVisible = false;
                                    });
                                  },
                                ),
                                Text("Delete this slider data")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class MySliderHome extends StatelessWidget {
  final List<SliderItem> items;

  MySliderHome({required this.items});

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
          viewportFraction: 1,
          height: 230.0, // Fixed height of the slider
          autoPlay: true,
          enlargeCenterPage: false,
        ),
        items: items.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Stack(
                  children: [
                    // CachedNetworkImage(
                    //   imageUrl: "http://via.placeholder.com/350x150",
                    //   placeholder: (context, url) =>
                    //       CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),
                    CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 100),
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      cacheManager: DefaultCacheManager(),
                    ),

                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.imageName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Photographer: ${item.photographerName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'Videographer: ${item.videographerName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'Editor: ${item.editorName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: -10,
                      top: 60,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_sharp),
                        onPressed: () {
                          _controller.previousPage();
                        },
                      ),
                    ),
                    Positioned(
                      right: -10,
                      top: 60,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () {
                          _controller.nextPage();
                        },
                      ),
                    ),
                    Positioned(
                      right: 10.0,
                      bottom: 10.0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(100, 158, 158, 158),
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.photo_library,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  var images = item.showcase;
                                  return AlertDialog(
                                    title: const Text('Image Gallery'),
                                    content: Container(
                                      width: double.maxFinite,
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 4.0,
                                        ),
                                        itemCount: images.length,
                                        itemBuilder: (context, index) {
                                          final imageUrl = images[index];
                                          return InkWell(
                                            onTap: () {
                                              // Tap on individual image
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenImagePage(
                                                    imageUrls: images,
                                                    initialIndex: index,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                              width: 100.0,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            // Handle image icon click
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class HaveSlider extends StatefulWidget {
  final String title;
  final String description;
  final List<SliderItem> items;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onEditPressed;
  final VoidCallback? onAddSliderPressed;
  final Function(int) onSliderDelete;
  final String docid;
  final String collectioName;

  HaveSlider(
      {required this.title,
      required this.description,
      required this.items,
      required this.onDeletePressed,
      required this.onEditPressed,
      required this.onAddSliderPressed,
      required this.onSliderDelete,
      required this.collectioName,
      required this.docid});

  @override
  State<HaveSlider> createState() => _HaveSliderState();
}

class _HaveSliderState extends State<HaveSlider> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity, // Ensure the Slidable fills the available width
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  widget.onEditPressed!();
                  print("object");
                },
                icon: Icons.edit,
                borderRadius: BorderRadius.circular(12),
              ),
              SlidableAction(
                onPressed: (context) {
                  widget.onDeletePressed!();
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(12),
              ),
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPackageList(
                        documentId: widget.docid,
                        collectionName: widget.collectioName,
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.green,
                icon: Icons.currency_rupee_sharp,
                borderRadius: BorderRadius.circular(12),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color.fromARGB(123, 255, 255, 255),
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        _buildIconButtonWithText(
                          icon: Icons.delete,
                          text: 'Delete',
                          onPressed: widget.onDeletePressed,
                        ),
                        _buildIconButtonWithText(
                          icon: Icons.edit,
                          text: 'Edit',
                          onPressed: widget.onEditPressed,
                        ),
                        _buildIconButtonWithText(
                          icon: Icons.add,
                          text: 'Add Slider',
                          onPressed: widget.onAddSliderPressed,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFullDescription = !showFullDescription;
                    });
                  },
                  child: Text(
                    showFullDescription
                        ? widget.description
                        : _getTrimmedDescription(),
                    maxLines: showFullDescription ? 8 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10.0),
                // Wrap MySliderData with a SizedBox to provide explicit constraints
                Container(
                  // Fixed height of the slider
                  child: AdminSliderData(
                    items: widget.items,
                    onDeletePressed: widget.onSliderDelete,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButtonWithText({
    required IconData icon,
    required String text,
    required VoidCallback? onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 20,
          ),
          onPressed: onPressed,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  String _getTrimmedDescription() {
    if (widget.description.length > 100) {
      return '${widget.description.substring(0, 100)}...';
    }
    return widget.description;
  }
}

class MySlider extends StatefulWidget {
  final String title;
  final String description;
  final List<SliderItem> items;
  final VoidCallback onPressed;

  MySlider(
      {required this.title,
      required this.description,
      required this.items,
      required this.onPressed});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  bool showFullDescription = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color.fromARGB(123, 255, 255, 255),
              width: 2.0,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showFullDescription = !showFullDescription;
                  });
                },
                child: Text(
                  showFullDescription
                      ? widget.description
                      : _getTrimmedDescription(),
                  maxLines: showFullDescription ? 8 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              // Text(
              //   widget.description,
              //   style: TextStyle(fontSize: 14.0, color: Colors.grey),
              // ),
              SizedBox(height: 10.0),
              // Wrap MySliderData with a SizedBox to provide explicit constraints
              Container(
                // Fixed height of the slider
                child: MySliderData(
                  items: widget.items,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTrimmedDescription() {
    if (widget.description.length > 100) {
      return '${widget.description.substring(0, 100)}...';
    }
    return widget.description;
  }
}

// Widget _bulidSliderBox(BuildContext context, String name, String credit,
//     String photo, String video, String edit, String images) {
//   return
// }

class FullScreenImagePage extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;

  FullScreenImagePage({required this.imageUrls, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.black,
          child: PhotoViewGallery.builder(
            itemCount: imageUrls.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                  imageUrls[index],
                  cacheManager: DefaultCacheManager(),
                ),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Colors.black,
            ),
            pageController: PageController(initialPage: initialIndex),
          ),
        ),
      ),
    );
  }
}

//Add Slider design or layout
class AddSlider extends StatelessWidget {
  final String documentId;
  final String title;
  final String description;

  final VoidCallback onPressed;

  AddSlider({
    required this.documentId,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color.fromARGB(123, 255, 255, 255),
              width: 2.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      _buildIconButtonWithText(
                        icon: Icons.delete,
                        text: 'Delete',
                        onPressed: () {
                          // Implement delete functionality
                        },
                      ),
                      _buildIconButtonWithText(
                        icon: Icons.edit,
                        text: 'Edit',
                        onPressed: () {
                          // Implement update functionality
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 20.0),
              Center(
                child: InkWell(
                    onTap: onPressed,
                    child: DottedBorder(
                      color: Colors.grey, //color of dotted/dash line
                      strokeWidth: 2, //thickness of dash/dots
                      dashPattern: [10, 6],
                      child: Container(
                        width: 350,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 50,
                              color: Colors.red,
                            ),
                            Text("Add Slider")
                          ],
                        ),
                      ),
                    )
                    //
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButtonWithText({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 20,
          ),
          onPressed: onPressed,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
