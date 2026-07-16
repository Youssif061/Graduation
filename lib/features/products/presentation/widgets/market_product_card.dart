import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/products/presentation/pages/product_details_screen.dart';

class MarketProductCard extends StatelessWidget {
  final ProductModel product;

  const MarketProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Determine the badge to show based on the mockup requirements
    String badgeText = '';
    Color badgeColor = AppColors.marketGreen;

    if (product.id == 'p1') {
      badgeText = 'VERIFIED';
      badgeColor = AppColors.marketGreen;
    } else if (product.isNew) {
      badgeText = 'NEW ARRIVAL';
      badgeColor = AppColors.marketText; // Dark slate color
    } else if (product.inStock) {
      badgeText = 'IN STOCK';
      badgeColor = AppColors.marketGreen;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.marketBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color(
                    0xFFF8FAFC,
                  ), // Light image container background
                  child: Image.asset(
                    product.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => _buildImagePlaceholder(),
                  ),
                ),
              ),
              // Mockup Badge
              if (badgeText.isNotEmpty)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badgeText,
                      style: MarketTextStyles.badge.copyWith(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: MarketTextStyles.productTitle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: MarketTextStyles.price.copyWith(
                        fontSize: 16,
                        color: AppColors.marketGreenDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Description (Ratings removed from card layout per mockup)
                Text(
                  product.description,
                  style: MarketTextStyles.bodySmall.copyWith(
                    color: AppColors.marketTextSub,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                // Buttons row
                Row(
                  children: [
                    // View Details
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.marketText, // Dark navy
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'View Details',
                            style: MarketTextStyles.buttonText.copyWith(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Cart button
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.marketGreen, // Vibrant green
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: const Color(0xFFF1F5F9),
      child: const Center(
        child: Icon(
          Icons.inventory_2_outlined,
          color: Color(0xFFCBD5E1),
          size: 60,
        ),
      ),
    );
  }
}
