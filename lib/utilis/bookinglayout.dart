import 'package:flutter/material.dart';

class PackageSelection extends StatelessWidget {
  final List<Map<String, dynamic>> packages;
  final String selectedPackage;
  final Function(String) onPackageSelected;

  PackageSelection({
    required this.packages,
    required this.selectedPackage,
    required this.onPackageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: packages.map((package) {
        return GestureDetector(
          onTap: () => onPackageSelected(package['name']),
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
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
