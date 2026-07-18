import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/users/products/presentation/cubit/product_cubit.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/users/products/data/dummy_data.dart';
import 'package:expertisemarket/features/users/products/presentation/widgets/market_app_bar.dart';
import 'package:expertisemarket/features/users/products/presentation/widgets/market_product_card.dart';
import 'package:expertisemarket/features/users/products/presentation/widgets/market_search_bar.dart';
import 'package:expertisemarket/features/users/products/presentation/widgets/category_chip.dart';
import 'package:expertisemarket/features/users/products/presentation/pages/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  int _selectedCategory = 0;
  late Future<DocumentSnapshot<Map<String, dynamic>>> userFuture;

  @override
  void initState() {
    super.initState();

    userFuture = FirebaseFirestore.instance
        .collection('users') // أو clients حسب مشروعك
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      appBar: const MarketAppBar(showHeart: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          // Search bar (Tap navigates to search screen)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
            child: const AbsorbPointer(child: MarketSearchBar(readOnly: true)),
          ),
          const SizedBox(height: 16),
          // Categories
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: DummyData.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => CategoryChip(
                label: DummyData.categories[i],
                isSelected: _selectedCategory == i,
                onTap: () => setState(() => _selectedCategory = i),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Inventory',
                    style: MarketTextStyles.sectionTitle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Product Cards
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is ProductError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: Text(state.message)),
                );
              }
              final products = state is ProductLoaded
                  ? state.products
                  : <ProductModel>[];
              final category = DummyData.categories[_selectedCategory];
              final filtered = products.where((p) {
                return _selectedCategory == 0 ||
                    p.category.toLowerCase() == category.toLowerCase();
              }).toList();

              if (filtered.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text('No products found in this category'),
                  ),
                );
              }

              return Column(
                children: filtered
                    .map((p) => MarketProductCard(product: p))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
