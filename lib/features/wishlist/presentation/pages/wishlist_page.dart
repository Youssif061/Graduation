import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/data/dummy_data.dart';
import 'package:expertisemarket/features/wishlist/presentation/widgets/wishlist_product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _selectedTab = 0;
  final List<String> _tabs = ['All Saved (12)', 'Products', 'Experts'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar as shown in mockup
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.marketText),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Wishlist',
          style: MarketTextStyles.appBarTitle.copyWith(fontWeight: FontWeight.w800),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.marketCardLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.marketBorder),
            ),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.marketTextSub,
              size: 20,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.marketBorder,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Segmented Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 42,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.marketCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.marketBorder),
              ),
              child: Row(
                children: List.generate(_tabs.length, (i) {
                  final isActive = _selectedTab == i;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.marketText : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _tabs[i],
                          style: MarketTextStyles.chipLabel.copyWith(
                            color: isActive ? Colors.white : AppColors.marketTextSub,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          // Product list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: DummyData.wishlistItems.length,
              itemBuilder: (_, i) => WishlistProductCard(
                item: DummyData.wishlistItems[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
