import 'package:flutter/material.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const QuickActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 40, color: Colors.blue),
          onPressed: () {
            // Handle action
          },
        ),
        Text(label, style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}