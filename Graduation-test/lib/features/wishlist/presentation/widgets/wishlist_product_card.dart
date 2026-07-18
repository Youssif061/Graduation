import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';
import 'package:expertisemarket/features/users/products/presentation/pages/product_details_screen.dart';
import 'package:expertisemarket/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:expertisemarket/features/users/products/presentation/cubit/cart_cubit.dart';


class WishlistProductCard extends StatefulWidget {
  final WishlistItemModel item;

  const WishlistProductCard({super.key, required this.item});

  @override
  State<WishlistProductCard> createState() => _WishlistProductCardState();
}

class _WishlistProductCardState extends State<WishlistProductCard> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = widget.item.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFav) return const SizedBox.shrink();

    // Determine badge and button color per mockup
    String badgeText = '';
    Color badgeBg = AppColors.marketGreenBadge;
    Color badgeTextColor = AppColors.marketGreenDark;
    Color buttonColor = AppColors.marketText; // Dark navy for first item

    if (widget.item.id == 'w1') {
      badgeText = 'In Stock';
      badgeBg = AppColors.marketGreenBadge;
      badgeTextColor = AppColors.marketGreenDark;
      buttonColor = AppColors.marketText; // Dark navy
    } else if (widget.item.id == 'w2') {
      badgeText = 'Expert Choice';
      badgeBg = const Color(0xFFE0F2FE); // Light blue
      badgeTextColor = const Color(0xFF0369A1); // Dark blue
      buttonColor = AppColors.marketGreen; // Green for second item
    }

    return GestureDetector(
      onTap: () {
        final product = _toProductModel(widget.item);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
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
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
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
                    child: widget.item.imageAsset.startsWith('http')
                        ? Image.network(
                            widget.item.imageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const Center(
                              child: Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFFCBD5E1),
                                size: 60,
                              ),
                            ),
                          )
                        : Image.asset(
                            widget.item.imageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => const Center(
                              child: Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFFCBD5E1),
                                size: 60,
                              ),
                            ),
                          ),
                  ),
                ),
                // Left badge
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
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badgeText,
                        style: MarketTextStyles.badge.copyWith(
                          color: badgeTextColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                // Red favorite heart on right
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      context.read<WishlistCubit>().removeFromWishlist(widget.item.id);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.marketRed,
                        size: 16,
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
                  Text(
                    widget.item.name,
                    style: MarketTextStyles.productTitle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.item.description,
                    style: MarketTextStyles.bodySmall.copyWith(
                      color: AppColors.marketTextSub,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.item.price.toStringAsFixed(2)}',
                        style: MarketTextStyles.price.copyWith(
                          fontSize: 18,
                          color: AppColors.marketGreenDark,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().addItem(
                            CartItemModel(
                              id: widget.item.id,
                              name: widget.item.name,
                              variant: 'Default',
                              imageAsset: widget.item.imageAsset,
                              price: widget.item.price,
                              quantity: 1,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to Cart!')),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Add to Cart',
                                style: MarketTextStyles.buttonText.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ProductModel _toProductModel(WishlistItemModel item) {
    return ProductModel(
      id: item.id,
      providerId: 'expert_dummy',
      name: item.name,
      category: 'Tools',
      description: item.description,
      imageAsset: item.imageAsset,
      price: item.price,
      originalPrice: item.price * 1.2,
      rating: 4.8,
      reviewCount: 245,
      isNew: item.id == 'w1',
      inStock: true,
      storeName: 'Mastercraft Solutions Ltd',
      storeRating: 4.8,
      storeProducts: '850+',
      bulletPoints: [
        'Lifetime warranty on all metal components',
        'Impact-resistant dual-locking carrying case',
        'Meets or exceeds ANSI and DIN standards',
      ],
      specs: {
        'Material': 'Chrome Vanadium',
        'Pieces Included': '152 Total',
        'Weight': '14.5 kg / 32 lbs',
        'Certifications': 'ANSI/ASME, DIN',
      },
      createdAt: DateTime.now(),
    );
  }
}
