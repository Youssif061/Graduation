import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/inventory_product_card.dart';
import 'package:flutter/material.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        InventoryProductCard(
          image: AppImages.User,
          title: "Advanced Analytics Suite v2.0",
          description:
              "Full-stack data visualization and reporting toolkit for enterprise clients.",
          stock: 45,
          price: "\$299.00",
          active: true,
          topSeller: true,
        ),

        InventoryProductCard(
          image: AppImages.User,
          title: "Cloud Infrastructure Consultation",
          description:
              "Scalable AWS/GCP architecture planning for high-traffic applications.",
          stock: 3,
          price: "\$1,250.00",
          active: true,
        ),

        InventoryProductCard(
          image: AppImages.User,
          title: "Executive Leadership Workshop",
          description:
              "Intensive 3-day training module for senior management teams.",
          stock: 0,
          price: "\$4,999.00",
          active: false,
        ),
      ],
    );
  }
}
