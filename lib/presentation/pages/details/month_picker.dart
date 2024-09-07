import 'package:flutter/material.dart';

class MonthPickerBottomSheet extends StatefulWidget {
  final Function(DateTime) onMonthSelected;
  final DateTime initialDate;

  MonthPickerBottomSheet({
    required this.onMonthSelected,
    required this.initialDate,
  });

  @override
  _MonthPickerBottomSheetState createState() => _MonthPickerBottomSheetState();
}

class _MonthPickerBottomSheetState extends State<MonthPickerBottomSheet> {
  late DateTime selectedDate;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    scrollController = ScrollController(
      initialScrollOffset: (selectedDate.month - 1) * 60.0,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Month',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300, // Adjust height as needed
            child: ListView.builder(
              controller: scrollController,
              itemCount: 12,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Text(
                      _getMonthName(index),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: index == selectedDate.month - 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: index == selectedDate.month - 1
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedDate = DateTime(selectedDate.year, index + 1);
                      scrollController.animateTo(
                        (index * 60.0), // Adjust item height
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              widget.onMonthSelected(selectedDate);
              Navigator.pop(context);
            },
            child: Text('Select'),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int monthIndex) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[monthIndex];
  }
}
