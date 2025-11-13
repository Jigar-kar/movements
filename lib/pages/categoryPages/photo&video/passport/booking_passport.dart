import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/address.dart';
import 'package:moments/pages/categoryPages/photo&video/bookingpage/modelingBooking/upi.dart';
// import 'package:moments/pages/categoryPages/photo&video/bookingPassportpage/modelingBooking/upi.dart';

class PackageSelection extends StatelessWidget {
  final List<Map<String, dynamic>> packages;
  final String? selectedPackage;
  final Function(String, String, int) onPackageSelected;

  PackageSelection({
    required this.packages,
    required this.onPackageSelected,
    this.selectedPackage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: packages.map((package) {
        return GestureDetector(
          onTap: () => onPackageSelected(
            package['name'],
            package['description'],
            (package['price'] is double)
                ? package['price'].toInt()
                : package['price'],
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: selectedPackage == package['name']
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: selectedPackage == package['name']
                    ? Color.fromRGBO(220, 26, 26, 1)
                    : Color.fromARGB(123, 255, 255, 255),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        package['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '\₹${package['price']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class DateSelection extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final String Function(int) getWeekday; // Function to get the weekday string

  DateSelection({
    required this.dates,
    required this.selectedDate,
    required this.onDateSelected,
    required this.getWeekday,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dates.map((date) {
          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                color: selectedDate != null &&
                        selectedDate!.day == date.day &&
                        selectedDate!.month == date.month &&
                        selectedDate!.year == date.year
                    ? Color.fromRGBO(220, 26, 26, 1)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getWeekday(date.weekday), // Use the passed function here
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TimeSelection extends StatelessWidget {
  final List<String> timeSlots;
  final String? selectedTimeSlot;
  final Function(String) onTimeSlotSelected;

  TimeSelection({
    required this.timeSlots,
    required this.selectedTimeSlot,
    required this.onTimeSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: timeSlots.map((timeSlot) {
        return GestureDetector(
          onTap: () => onTimeSlotSelected(timeSlot),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedTimeSlot == timeSlot
                      ? Color.fromRGBO(220, 26, 26, 1)
                      : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                timeSlot,
                style: TextStyle(
                  fontSize: 16,
                  color: selectedTimeSlot == timeSlot ? Colors.white : null,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class BookingPassportPage extends StatefulWidget {
  @override
  _BookingPassportPageState createState() => _BookingPassportPageState();
}

class _BookingPassportPageState extends State<BookingPassportPage> {
  String? _selectedPackageName;
  String? _selectedPackageDescription;
  int? _selectedPackagePrice;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  List<String> availableTimeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
  ];

  List<Map<String, dynamic>>? _packagesData;

  @override
  void initState() {
    super.initState();
    _fetchPackages();
  }

  void _fetchPackages() async {
    setState(() {
      _packagesData =
          null; // Set packages data to null to show loading indicator
    });

    final snapshot =
        await FirebaseFirestore.instance.collection('passportprice').get();

    setState(() {
      _packagesData = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Package Selection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (_packagesData == null)
                  Center(child: CircularProgressIndicator())
                else if (_packagesData!.isEmpty)
                  Center(child: Text('No packages available'))
                else
                  PackageSelection(
                    packages: _packagesData!,
                    onPackageSelected: (name, description, price) {
                      setState(() {
                        _selectedPackageName = name;
                        _selectedPackageDescription = description;
                        _selectedPackagePrice =
                            price; // Price is already an int
                      });
                    },
                    selectedPackage: _selectedPackageName,
                  ),
                SizedBox(height: 10),
                Text(
                  'Date Selection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                DateSelection(
                  dates: List.generate(
                      14, (index) => DateTime.now().add(Duration(days: index))),
                  selectedDate: _selectedDate,
                  onDateSelected: (selectedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  },
                  getWeekday: _getWeekday,
                ),
                SizedBox(height: 10),
                Text(
                  'Select a time slot:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TimeSelection(
                  timeSlots: availableTimeSlots,
                  selectedTimeSlot: _selectedTimeSlot,
                  onTimeSlotSelected: (selectedTimeSlot) {
                    setState(() {
                      _selectedTimeSlot = selectedTimeSlot;
                    });
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String errorMessage = '';

                      if (_selectedPackageName == null) {
                        errorMessage = 'Please select a package.';
                      } else if (_selectedDate == null) {
                        errorMessage = 'Date not selected.';
                      } else if (_selectedTimeSlot == null) {
                        errorMessage = 'Time not selected.';
                      }

                      if (errorMessage.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(errorMessage),
                        ));
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              selectedPackage: _selectedPackageName!,
                              selectedDate: _selectedDate!,
                              selectedTimeSlot: _selectedTimeSlot!,
                              description: _selectedPackageDescription!,
                              selectedPrice: _selectedPackagePrice!,
                            ),
                          ),
                        ); // Proceed to payment
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ), backgroundColor: Color.fromRGBO(220, 26, 26, 1),
                      foregroundColor: Colors.white,
                      fixedSize: Size(290, 54),
                    ),
                    child: Text('Continue to order'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return ''; // Handle any unexpected cases
    }
  }
}
