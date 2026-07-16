import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widget/product_action_bottom_sheet.dart';
import 'package:flutter/material.dart';

class InventoryProductCard extends StatelessWidget {
  const InventoryProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final bool active = product.stock > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffE2E8F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 1,
                child: product.images.isNotEmpty
                    ? Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 70,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff001A2C),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff64748B),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Text(
                  "Stock : ${product.stock}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: active
                        ? const Color(
                            0xffDCFCE7)
                        : const Color(
                            0xffFEE2E2),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    active
                        ? "Active"
                        : "Out Of Stock",
                    style: TextStyle(
                      color: active
                          ? const Color(
                              0xff15803D)
                          : Colors.red,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {
                    ProductActionBottomSheet.show(
                      context,
                      product,
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}