import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  final String imagePath;
  final String framePath;

  PreviewScreen({required this.imagePath, required this.framePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Container(
            height: 500,
            child: Stack(
              children: [
                // Frame
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Image.asset(
                      imagePath,
                      width: 380,
                      height: 400,
                    ),
                  ),
                ),
                // Image preview
                Positioned(
                  child: Image.asset(
                    framePath,
                    width: 400,
                    height: 600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
