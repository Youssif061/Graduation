import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/wishlist/presentation/widgets/wishlist_product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final items = state is WishlistLoaded
            ? state.items
            : <WishlistItemModel>[];
        final tabs = ['All Saved (${items.length})', 'Products', 'Experts'];

        return Scaffold(
          backgroundColor: AppColors.marketBg,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            // Only show back arrow when this page was pushed (not a tab)
            automaticallyImplyLeading: false,
            leading: canPop
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.marketText,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                : null,
            title: Text(
              'My Wishlist',
              style: MarketTextStyles.appBarTitle.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  String image = '';

                  if (snapshot.hasData && snapshot.data!.exists) {
                    final data = snapshot.data!.data()!;
                    image = data['image'] ?? '';
                  }

                  return Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.marketBorder),
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppColors.marketCardLight,
                      backgroundImage: image.isNotEmpty
                          ? NetworkImage(image)
                          : const AssetImage("assets/images/2.png")
                                as ImageProvider,
                    ),
                  );
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
              const SizedBox(height: 8),
              // Segmented Tabs
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.marketCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.marketBorder),
                  ),
                  child: Row(
                    children: List.generate(tabs.length, (i) {
                      final isActive = _selectedTab == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.marketText
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tabs[i],
                              style: MarketTextStyles.chipLabel.copyWith(
                                color: isActive
                                    ? Colors.white
                                    : AppColors.marketTextSub,
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
                child: Builder(
                  builder: (context) {
                    if (state is WishlistLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is WishlistError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (items.isEmpty) {
                      return const Center(
                        child: Text(
                          'Your wishlist is empty',
                          style: TextStyle(
                            color: AppColors.marketTextSub,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: items.length,
                      itemBuilder: (_, i) =>
                          WishlistProductCard(item: items[i]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
