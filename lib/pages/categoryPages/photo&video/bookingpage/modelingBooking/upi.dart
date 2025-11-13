import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moments/pages/categoryPages/function&event/wedding.dart';
import 'package:moments/pages/categoryPages/other/editing.dart';
import 'package:moments/pages/categoryPages/other/personalizegift.dart';
import 'package:moments/pages/categoryPages/photo&video/passport/passport.dart';
import 'package:moments/pages/navigationBarPages/home.dart';
import 'package:upi_india/upi_india.dart';

class PaymentPage extends StatefulWidget {
  final String selectedPackage;
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final int selectedPrice;
  final String description;

  PaymentPage({
    required this.selectedPackage,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.description,
    required this.selectedPrice,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  UpiIndia _upiIndia = UpiIndia();
  UpiApp app = UpiApp.googlePay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Color.fromARGB(123, 255, 255, 255),
                    width: 2,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Package: ${widget.selectedPackage}',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Description: ${widget.description}',
                                style: TextStyle(fontSize: 15),
                                overflow: TextOverflow.clip,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Date: ${widget.selectedDate.toString().substring(0, 10)}',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Time: ${widget.selectedTimeSlot}',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Row(
                            children: [
                              Text(
                                "₹",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${widget.selectedPrice}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 19),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Choose a Payment Method:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      mainAxisExtent: 100),
                  shrinkWrap: true,
                  itemCount: 4, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        return PayButton(
                          image: AssetImage('asset/imges/gpay.jpg'),
                          text: 'GPay',
                          onPressed: _initiateUpiPayment,
                        );
                      case 1:
                        return PayButton(
                          image: AssetImage('asset/imges/paytm.jpg'),
                          text: 'Paytm',
                          onPressed: _initiateUpiPayment,
                        );
                      case 2:
                        return PayButton(
                          image: AssetImage('asset/imges/phonepay.jpg'),
                          text: 'PhonePe',
                          onPressed: _initiateUpiPayment,
                        );
                      case 3:
                        return PayButton(
                          image: AssetImage('asset/imges/bhim.png'),
                          text: 'Bhim',
                          onPressed: _initiateUpiPayment,
                        );
                      default:
                        return SizedBox(); // Return an empty SizedBox for any other index
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 90, // Make the button take full width
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => _sendOrderToFirestore(context),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Cash on Delivery",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendOrderToFirestore(BuildContext context) async {
    try {
      // Get current user's email
      final user = FirebaseAuth.instance.currentUser;
      String? currentUserEmail = user!.email;

      // Construct the Firestore path
      String firestorePath = 'orderlist/$currentUserEmail/orders';

      // Prepare data to be stored
      Map<String, dynamic> orderData = {
        'package': widget.selectedPackage,
        'date': widget.selectedDate.toString().substring(0, 10),
        'time': widget.selectedTimeSlot,
        'price': widget.selectedPrice,
      };

      // Add data to Firestore
      await FirebaseFirestore.instance.collection(firestorePath).add(orderData);
      print("Order placed");
      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order placed successfully!'),
        ),
      );
    } catch (e) {
      print('Error sending order to Firestore: $e');
      // Handle error here
    }
  }

  void _initiateUpiPayment() async {
    UpiResponse? _upiResponse = await _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "hareshpbhadresha@okhdfcbank",
      receiverName: 'Capture Moments',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Payment for ${widget.selectedPackage}',
      amount: widget.selectedPrice.toDouble(),
    );

    // Handle the response accordingly
    _showPaymentStatusDialog(_upiResponse.status.toString());
  }

  void _showPaymentStatusDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Status'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class PayButton extends StatelessWidget {
  final ImageProvider<Object> image;
  final String text;
  final void Function() onPressed;

  PayButton({required this.image, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
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
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.contain,
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
