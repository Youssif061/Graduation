import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_product_card.dart';
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
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                size: 70,
                color: Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                "No Products Found",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: products.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InventoryProductCard(
          product: products[index],
        );
      },
    );
  }
}