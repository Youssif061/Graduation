import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/users/products/data/dummy_data.dart';
import 'package:expertisemarket/features/users/products/presentation/widgets/market_search_bar.dart';
import 'package:expertisemarket/features/users/products/presentation/widgets/search_product_card.dart';
import 'package:expertisemarket/features/users/products/presentation/cubit/product_cubit.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCubit>().searchProducts('');
    });
  }

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
                onTap: () {
                  context.read<ProductCubit>().searchProducts('');
                  Navigator.pop(context);
                },
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
                  onChanged: (val) {
                    context.read<ProductCubit>().searchProducts(val);
                  },
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  context.read<ProductCubit>().searchProducts('');
                  Navigator.pop(context);
                },
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
              return GestureDetector(
                onTap: () {
                  _ctrl.text = s;
                  context.read<ProductCubit>().searchProducts(s);
                },
                child: Container(
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
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                _ctrl.text = DummyData.trendingCategories[i];
                context.read<ProductCubit>().searchProducts(DummyData.trendingCategories[i]);
              },
              child: Container(
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
          ),
          const SizedBox(height: 24),
          // Recommended for You / Search Results
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Products List',
                style: MarketTextStyles.sectionTitle.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final products = state is ProductLoaded ? state.products : <ProductModel>[];
              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: Text('No products found')),
                );
              }
              return Column(
                children: products.map((p) => SearchProductCard(product: p)).toList(),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
