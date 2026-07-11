import 'package:expertisemarket/features/ServiceProvider/inventory/widget/product_action_bottom_sheet.dart';
import 'package:flutter/material.dart';

class InventoryProductCard extends StatelessWidget {
  const InventoryProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.stock,
    required this.price,
    required this.active,
    this.topSeller = false,
  });

  final String image;
  final String title;
  final String description;
  final int stock;
  final String price;
  final bool active;
  final bool topSeller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xffE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(image, fit: BoxFit.cover),
                    ),
                  ),
                ),

                if (topSeller)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff22C55E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "TOP Rated",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff001A2C),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xff64748B),
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Text(
                  "STOCK: $stock units",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xff64748B),
                  ),
                ),

                const Spacer(),

                Text(
                  "PRICE: $price",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xff64748B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(0xffDCFCE7)
                        : const Color(0xffF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    active ? "Active" : "Inactive",
                    style: TextStyle(
                      color: active ? const Color(0xff15803D) : Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

                const Spacer(),

                GestureDetector(
                  onTap: () {
                    ProductActionBottomSheet.show(context);
                  },
                  child: const Icon(Icons.more_vert, color: Color(0xff94A3B8)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
