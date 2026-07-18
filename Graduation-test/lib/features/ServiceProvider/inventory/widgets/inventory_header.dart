import 'package:flutter/material.dart';

class InventoryHeader extends StatelessWidget {
  const InventoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Inventory",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff001A2C),
          ),
        ),

        SizedBox(height: 8),

        Text(
          "Manage your products, monitor stock levels, search, filter and update your inventory.",
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: Color(0xff64748B),
          ),
        ),
      ],
    );
  }
}