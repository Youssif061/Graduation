import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/data/dummy_data.dart';
import 'package:expertisemarket/features/products/presentation/widgets/market_search_bar.dart';
import 'package:expertisemarket/features/products/presentation/widgets/search_product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar per mockup
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.marketText,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MarketSearchBar(
                  controller: _ctrl,
                  readOnly: false,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: MarketTextStyles.bodySmall.copyWith(
                    color: AppColors.marketTextSub,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.marketBorder,
            height: 1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          // Recent Searches
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: MarketTextStyles.sectionTitle.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Clear all',
                  style: MarketTextStyles.bodySmall.copyWith(
                    color: AppColors.marketTextSub,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: DummyData.recentSearches.map((s) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.marketCard,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.marketBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.history,
                      color: AppColors.marketTextSub,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      s,
                      style: MarketTextStyles.chipLabelInactive.copyWith(
                        color: AppColors.marketTextSub,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          // Trending Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Categories',
                style: MarketTextStyles.sectionTitle.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View All',
                  style: MarketTextStyles.bodySmall.copyWith(
                    color: AppColors.marketTextSub,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.4,
            ),
            itemCount: DummyData.trendingCategories.length,
            itemBuilder: (_, i) => Container(
              decoration: BoxDecoration(
                color: AppColors.marketCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.marketBorder),
              ),
              alignment: Alignment.center,
              child: Text(
                DummyData.trendingCategories[i],
                style: MarketTextStyles.chipLabelInactive.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.marketTextSub,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Recommended for You
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended for You',
                style: MarketTextStyles.sectionTitle.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View all',
                  style: MarketTextStyles.bodySmall.copyWith(
                    color: AppColors.marketGreenDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...DummyData.searchRecommended.map(
            (p) => SearchProductCard(product: p),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
