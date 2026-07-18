import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/widgets/product_action_bottom_sheet.dart';
import 'package:flutter/material.dart';

class InventoryProductCard extends StatelessWidget {
  const InventoryProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final bool isActive = product.stock > 0;

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Color(0xffE2E8F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///========================
            /// Product Image
            ///========================

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.3,
                child: product.images.isNotEmpty
                    ? Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return _imagePlaceholder();
                        },
                      )
                    : _imagePlaceholder(),
              ),
            ),

            const SizedBox(height: 16),

            ///========================
            /// Name
            ///========================

            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff001A2C),
              ),
            ),

            const SizedBox(height: 6),

            ///========================
            /// Category
            ///========================

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffEEF5FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                product.category,
                style: const TextStyle(
                  color: Color(0xff2563EB),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            ///========================
            /// Description
            ///========================

            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff64748B),
                height: 1.45,
              ),
            ),

            const SizedBox(height: 18),

            ///========================
            /// Price + Stock
            ///========================

            Row(
              children: [

                const Icon(
                  Icons.attach_money,
                  size: 18,
                  color: Color(0xff001A2C),
                ),

                Text(
                  product.price.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons.inventory_2_outlined,
                  size: 18,
                  color: Color(0xff64748B),
                ),

                const SizedBox(width: 6),

                Text(
                  "${product.stock}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            ///========================
            /// Status + More
            ///========================

            Row(
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xffDCFCE7)
                        : const Color(0xffFEE2E2),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    isActive
                        ? "Active"
                        : "Out Of Stock",
                    style: TextStyle(
                      color: isActive
                          ? const Color(0xff15803D)
                          : Colors.red,
                      fontWeight: FontWeight.w600,
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

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xffF1F5F9),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 60,
          color: Colors.grey,
        ),
      ),
    );
  }
}