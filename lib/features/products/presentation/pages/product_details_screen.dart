import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/products/presentation/cubit/cart_cubit.dart';
import 'package:expertisemarket/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:expertisemarket/features/products/presentation/pages/cart_screen.dart';
import 'package:expertisemarket/features/products/presentation/pages/checkout_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedThumb = 0;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _isLiked = context.read<WishlistCubit>().isInWishlist(widget.product.id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final discount = p.originalPrice > 0
        ? (((p.originalPrice - p.price) / p.originalPrice) * 100).round()
        : 0;

    return Scaffold(
      backgroundColor: Colors.white, // White background per mockup
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.marketText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('CraftMarket', style: MarketTextStyles.appBarTitle),
        actions: [
          IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? AppColors.marketRed : AppColors.marketTextSub,
            ),
            onPressed: () {
              final wishlistItem = WishlistItemModel(
                id: widget.product.id,
                name: widget.product.name,
                description: widget.product.description,
                imageAsset: widget.product.imageAsset,
                price: widget.product.price,
                isFavourite: !_isLiked,
              );
              context.read<WishlistCubit>().toggleFavorite(wishlistItem);
              setState(() => _isLiked = !_isLiked);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.marketBorder, height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Image
                  Container(
                    height: 280,
                    width: double.infinity,
                    color: const Color(0xFFF8FAFC), // Light image background
                    child: p.imageAsset.startsWith('http')
                        ? Image.network(
                            p.imageAsset,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFFCBD5E1),
                                size: 80,
                              ),
                            ),
                          )
                        : Image.asset(
                            p.imageAsset,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(
                                Icons.inventory_2_outlined,
                                color: Color(0xFFCBD5E1),
                                size: 80,
                              ),
                            ),
                          ),
                  ),
                  // Thumbnails row
                  if (p.thumbnails.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        children: List.generate(
                          p.thumbnails.length > 4 ? 4 : p.thumbnails.length,
                          (i) => GestureDetector(
                            onTap: () => setState(() => _selectedThumb = i),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _selectedThumb == i
                                      ? AppColors
                                            .marketText // Active has a dark slate border
                                      : AppColors.marketBorder,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: p.thumbnails[i].startsWith('http')
                                    ? Image.network(
                                        p.thumbnails[i],
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Icon(
                                          Icons.inventory_2_outlined,
                                          color: Color(0xFFCBD5E1),
                                          size: 28,
                                        ),
                                      )
                                    : Image.asset(
                                        p.thumbnails[i],
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Icon(
                                          Icons.inventory_2_outlined,
                                          color: Color(0xFFCBD5E1),
                                          size: 28,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badges row
                        Row(
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
                                'Verified Pro',
                                style: MarketTextStyles.badge.copyWith(
                                  color: AppColors.marketGreenDark,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'SKU: PRO-TK-2024',
                              style: MarketTextStyles.bodySmall.copyWith(
                                color: AppColors.marketTextMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Product title
                        Text(
                          p.name,
                          style: MarketTextStyles.productTitleLarge.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.marketText,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Rating row
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColors.marketYellow,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${p.rating} (${p.reviewCount} Reviews)  |  ',
                              style: MarketTextStyles.rating.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.marketTextSub,
                              ),
                            ),
                            Text(
                              p.inStock ? 'In Stock' : 'Out of Stock',
                              style: MarketTextStyles.rating.copyWith(
                                fontWeight: FontWeight.w700,
                                color: p.inStock
                                    ? AppColors.marketGreenDark
                                    : AppColors.marketRed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Price row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '\$${p.price.toStringAsFixed(2)}',
                              style: MarketTextStyles.priceLarge.copyWith(
                                fontSize: 24,
                                color: AppColors.marketGreenDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (p.originalPrice > 0)
                              Text(
                                '\$${p.originalPrice.toStringAsFixed(2)}',
                                style: MarketTextStyles.priceStrike.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Save discount banner (light blue with dark blue text)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFE0F2FE,
                            ), // Light blue background
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Save $discount% for a limited time',
                            style: MarketTextStyles.badge.copyWith(
                              color: const Color(0xFF0369A1), // Dark blue text
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Store card
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.marketBorder),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.marketGreenBadge,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.storefront,
                                  color: AppColors.marketGreen,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.storeName,
                                      style: MarketTextStyles.productTitle
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Elite Seller · 95% Positive Feedback',
                                      style: MarketTextStyles.bodySmall
                                          .copyWith(
                                            color: AppColors.marketTextSub,
                                            fontSize: 11,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: AppColors.marketTextSub,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Tabs
                        TabBar(
                          controller: _tabController,
                          indicatorColor: AppColors.marketGreen,
                          indicatorWeight: 3,
                          labelColor: AppColors.marketText,
                          unselectedLabelColor: AppColors.marketTextSub,
                          labelStyle: MarketTextStyles.tabLabel.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          unselectedLabelStyle: MarketTextStyles.tabLabel
                              .copyWith(fontSize: 14),
                          dividerColor: AppColors.marketBorder,
                          tabs: const [
                            Tab(text: 'Description'),
                            Tab(text: 'Specifications'),
                            Tab(text: 'Reviews'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Tab content
                        SizedBox(
                          height: 480,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _DescriptionTab(product: p),
                              _SpecificationsTab(product: p),
                              const _ReviewsTab(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom bar
          _BottomBar(product: widget.product),
        ],
      ),
    );
  }
}

class _DescriptionTab extends StatelessWidget {
  final ProductModel product;

  const _DescriptionTab({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.description,
          style: MarketTextStyles.bodyMedium.copyWith(
            color: AppColors.marketTextSub,
            height: 1.5,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        ...product.bulletPoints.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.marketGreen,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    b,
                    style: MarketTextStyles.bodySmall.copyWith(
                      color: AppColors.marketTextSub,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Technical Specifications',
          style: MarketTextStyles.sectionTitle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: product.specs.entries
                .map(
                  (e) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.marketCardLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.marketBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.key.toUpperCase(),
                          style: MarketTextStyles.specKey.copyWith(
                            color: AppColors.marketTextMuted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          e.value,
                          style: MarketTextStyles.specValue.copyWith(
                            color: AppColors.marketText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _SpecificationsTab extends StatelessWidget {
  final ProductModel product;

  const _SpecificationsTab({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: product.specs.entries
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.marketCardLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.marketBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      e.key,
                      style: MarketTextStyles.specKey.copyWith(
                        color: AppColors.marketTextSub,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    e.value,
                    style: MarketTextStyles.specValue.copyWith(
                      color: AppColors.marketText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.rate_review_outlined,
            color: AppColors.marketTextSub,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            'Reviews coming soon',
            style: MarketTextStyles.bodySmall.copyWith(
              color: AppColors.marketTextSub,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final ProductModel product;

  const _BottomBar({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.marketBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<CartCubit>().addItem(
                  CartItemModel(
                    id: product.id,
                    name: product.name,
                    variant: product.category,
                    imageAsset: product.imageAsset,
                    price: product.price,
                    quantity: 1,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} added to cart'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'View Cart',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.marketBorder, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.marketText,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add to Cart',
                      style: MarketTextStyles.buttonText.copyWith(
                        color: AppColors.marketText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<CartCubit>().addItem(
                  CartItemModel(
                    id: product.id,
                    name: product.name,
                    variant: product.category,
                    imageAsset: product.imageAsset,
                    price: product.price,
                    quantity: 1,
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color:
                      AppColors.marketText, // Dark navy/slate "Buy Now" button
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Buy Now',
                  style: MarketTextStyles.buttonText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
