import 'package:flutter/material.dart';

class InventoryHeader extends StatelessWidget {
  const InventoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inventory Management",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff001A2C),
          ),
        ),

        SizedBox(height: 6),

        Text(
          "Track, update, and manage your professional\nproduct offerings.",
          style: TextStyle(
            fontSize: 15,
            height: 1.45,
            color: Color(0xff64748B),
          ),
        ),
      ],
    );
  }
}
