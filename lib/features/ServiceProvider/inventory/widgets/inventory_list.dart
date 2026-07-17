import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/inventory_product_card.dart';
import 'package:flutter/material.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 60,
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 70,
                color: Colors.grey,
              ),

              SizedBox(height: 16),

              Text(
                "No Products Found",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Start by adding your first product.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return InventoryProductCard(
          product: products[index],
        );
      },
    );
  }
}