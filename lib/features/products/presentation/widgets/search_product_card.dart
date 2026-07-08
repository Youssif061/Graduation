import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/products/presentation/pages/product_details_screen.dart';

class SearchProductCard extends StatefulWidget {
  final ProductModel product;

  const SearchProductCard({super.key, required this.product});

  @override
  State<SearchProductCard> createState() => _SearchProductCardState();
}

class _SearchProductCardState extends State<SearchProductCard> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    // Categories for verification badges as seen in screen 2 mockup
    String categoryLabel = widget.product.category;
    if (widget.product.id == 'sr1') {
      categoryLabel = 'Measurement';
    } else if (widget.product.id == 'sr2') {
      categoryLabel = 'Electronics';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.marketCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.marketBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    color: const Color(0xFFF8FAFC),
                    child: Image.asset(
                      widget.product.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.inventory_2_outlined,
                          color: Color(0xFFCBD5E1),
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                // Verified badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.marketGreenBadge,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'VERIFIED',
                          style: MarketTextStyles.badge.copyWith(
                            color: AppColors.marketGreenDark,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        categoryLabel,
                        style: MarketTextStyles.bodySmall.copyWith(
                          color: AppColors.marketTextSub,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Heart Toggle
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () => setState(() => _isFav = !_isFav),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isFav ? Icons.favorite : Icons.favorite_border,
                        color: _isFav ? AppColors.marketRed : AppColors.marketTextSub,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Info Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: MarketTextStyles.productTitle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: MarketTextStyles.price.copyWith(
                            fontSize: 18,
                            color: AppColors.marketText, // dark navy text
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Dark Navy Cart Button per mockup
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.marketText, // Dark navy
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
