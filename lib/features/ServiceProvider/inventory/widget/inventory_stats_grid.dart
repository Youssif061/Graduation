import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:flutter/material.dart';

import 'stat_card.dart';

class InventoryStatsGrid extends StatelessWidget {
  const InventoryStatsGrid({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final totalProducts = products.length;

    final activeProducts = products
        .where((e) => e.stock > 0)
        .length;

    final lowStock = products
        .where((e) => e.stock > 0 && e.stock <= 5)
        .length;

    double revenue = 0;

    for (final product in products) {
      revenue +=
          product.price * product.stock;
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: "TOTAL ITEMS",
                value:
                    totalProducts.toString(),
                valueColor:
                    const Color(0xff001A2C),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StatCard(
                title: "ACTIVE",
                value:
                    activeProducts.toString(),
                valueColor:
                    const Color(0xff16A34A),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: StatCard(
                title: "LOW STOCK",
                value: lowStock.toString(),
                valueColor:
                    Colors.red,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StatCard(
                title: "TOTAL VALUE",
                value:
                    "\$${revenue.toStringAsFixed(0)}",
                valueColor:
                    const Color(0xff001A2C),
              ),
            ),
          ],
        ),
      ],
    );
  }
}