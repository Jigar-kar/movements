import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/booking.dart';
//import 'package:moments/pages/categoryPages/photo&video/modeling.dart';
import 'package:moments/pages/categoryPages/photo&video/passport/visa.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.withOpacity(0.5),
              child: Center(
                child: Icon(Icons.error, color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
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
                          image: AssetImage(widget.imagePaths[index]),
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
  final List<Widget> destinationPages; // Pages to navigate to on image click
  final List<String> descriptions;
  final List<String> size; // Descriptions for each image

  const MyLayout(
      {required this.title,
      required this.imagePaths,
      required this.destinationPages,
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
                    destinationPages[index],
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

  Widget _buildImageBox(BuildContext context, String imagePath,
      Widget destinationPage, String description, String size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destinationPage),
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

//funtion /event layout

class MySlider extends StatelessWidget {
  final String title;
  final String description;
  final List<String> names;
  final List<String> credits;
  final List<String> photos;
  final List<String> videos;
  final List<String> edits;
  final List<String> images;
  final VoidCallback onPressed;

  MySlider({
    required this.title,
    required this.description,
    required this.names,
    required this.credits,
    required this.photos,
    required this.videos,
    required this.edits,
    required this.images,
    required this.onPressed,
    required String mainimage,
  });

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingPage(
                      documentId: 'sks',
                      collectionName: '',
                    )),
          );
        },
        child: Container(
          // height: 305,
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
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: -1.0),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 170.0,
                              autoPlay: false,
                              enlargeCenterPage: false,
                            ),
                            items: images.asMap().entries.map((entry) {
                              final index = entry.key;
                              final imageUrl = entry.value;

                              return Container(
                                child: Stack(
                                  children: [
                                    Image.asset(imageUrl,
                                        fit: BoxFit.cover, width: 1000.0),
                                    Positioned(
                                      bottom: 50.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6.0, horizontal: 20.0),
                                        child: Text(
                                          names[index],
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          credits[index],
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          photos[index],
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          videos[index],
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          edits[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: InkWell(
                                          onTap: () {
                                            // Show dialog box with GridView of images
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Image Gallery'),
                                                  content: Container(
                                                    width: double.maxFinite,
                                                    child: GridView.builder(
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 4.0,
                                                        mainAxisSpacing: 4.0,
                                                      ),
                                                      itemCount: images.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final imageUrl =
                                                            images[index];
                                                        return InkWell(
                                                          onTap: () {
                                                            // Tap on individual image
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FullScreenImagePage(
                                                                  imageUrl:
                                                                      imageUrl,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Image.asset(
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
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    106, 0, 0, 0)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Image.asset(
                                                  "asset/imges/iconeIMG.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Positioned(
                          left: -10,
                          top: 75,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new_sharp),
                            onPressed: () {
                              _controller.previousPage();
                            },
                          ),
                        ),
                        Positioned(
                          right: -10,
                          top: 75,
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios_sharp),
                            onPressed: () {
                              _controller.nextPage();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              // Align(
              //   alignment: Alignment.center,
              //   child: ElevatedButton(
              //     onPressed: onPressed,
              //     style: ElevatedButton.styleFrom(
              //       foregroundColor: Colors.white,
              //       backgroundColor: Color.fromARGB(151, 41, 41, 41),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20.0),
              //       ),
              //     ),
              //     child: Text(
              //       'Book an appointment',
              //       style: TextStyle(fontSize: 12),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _bulidSliderBox(BuildContext context, String name, String credit,
//     String photo, String video, String edit, String images) {
//   return
// }

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  FullScreenImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.black,
          child: Center(
            child: PhotoView(
              imageProvider: AssetImage(imageUrl),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      ),
    );
  }
}
