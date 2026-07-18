import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class InventoryStatsGrid extends StatelessWidget {
  const InventoryStatsGrid({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final int totalProducts = products.length;

    final int activeProducts = products
        .where((product) => product.stock > 0)
        .length;

    final int lowStockProducts = products
        .where(
          (product) =>
              product.stock > 0 &&
              product.stock <= 5,
        )
        .length;

    final double totalInventoryValue = products.fold<double>(
      0,
      (sum, product) =>
          sum + (product.price * product.stock),
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: "TOTAL PRODUCTS",
                value: totalProducts.toString(),
                valueColor: const Color(0xff001A2C),
                icon: Icons.inventory_2_outlined,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StatCard(
                title: "ACTIVE",
                value: activeProducts.toString(),
                valueColor: const Color(0xff16A34A),
                icon: Icons.check_circle_outline,
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
                value: lowStockProducts.toString(),
                valueColor: Colors.orange,
                icon: Icons.warning_amber_rounded,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: StatCard(
                title: "TOTAL VALUE",
                value:
                    "\$${totalInventoryValue.toStringAsFixed(2)}",
                valueColor: const Color(0xff2563EB),
                icon: Icons.attach_money_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}