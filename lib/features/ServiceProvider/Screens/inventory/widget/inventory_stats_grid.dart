import 'package:flutter/material.dart';
import 'stat_card.dart';

class InventoryStatsGrid extends StatelessWidget {
  const InventoryStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: "TOTAL ITEMS",
                value: "124",
                valueColor: Color(0xff001A2C),
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: StatCard(
                title: "ACTIVE",
                value: "98",
                valueColor: Color(0xff16A34A),
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: StatCard(
                title: "LOW STOCK",
                value: "12",
                valueColor: Color(0xffDC2626),
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: StatCard(
                title: "REVENUE (MTD)",
                value: "\$12.4k",
                valueColor: Color(0xff001A2C),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
