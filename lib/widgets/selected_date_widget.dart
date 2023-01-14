import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDateWidget extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTap;

  const SelectedDateWidget(
      {super.key, required this.onTap, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            const Text(
              'Selected Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMMd().format(selectedDate),
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
