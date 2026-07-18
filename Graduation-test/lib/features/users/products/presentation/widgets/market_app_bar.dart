import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/users/products/presentation/pages/main_shell_notifier.dart';

class MarketAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showHeart;
  final bool showProfile;
  final Widget? leading;
  final String? customTitle;
  final bool showCart;

  const MarketAppBar({
    super.key,
    this.showHeart = true,
    this.showProfile = false,
    this.leading,
    this.customTitle,
    this.showCart = true,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = MainShellNotifier.maybeOf(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          customTitle ?? "ExpertiseMarket",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: _buildActions(notifier, context),
        bottom: _buildBottom(),
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots(),
      builder: (context, snapshot) {
        String name = "ExpertiseMarket";
        String image = "";

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data()!;
          name = data['name'] ?? "ExpertiseMarket";
          image = data['image'] ?? "";
        }

        return AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leadingWidth: 60,
          leading: leading ??
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routers.profile);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.backgroundColor,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: image.isNotEmpty
                          ? NetworkImage(image)
                          : const AssetImage(AppImages.User) as ImageProvider,
                    ),
                  ),
                ),
              ),
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routers.profile);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                customTitle ?? name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          actions: _buildActions(notifier, context),
          bottom: _buildBottom(),
        );
      },
    );
  }

  List<Widget> _buildActions(MainShellNotifier? notifier, BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.favorite_border,
          color: AppColors.marketTextSub,
          size: 24,
        ),
        onPressed: () {
          if (notifier != null) {
            notifier.switchTab(1);
          } else {
            Navigator.pushNamed(context, Routers.wishlist);
          }
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.shopping_cart_outlined,
          color: AppColors.marketTextSub,
          size: 24,
        ),
        onPressed: () {
          if (notifier != null) {
            notifier.switchTab(2);
          } else {
            Navigator.pushNamed(context, Routers.cart);
          }
        },
      ),
      const SizedBox(width: 8),
    ];
  }

  PreferredSizeWidget _buildBottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(color: AppColors.marketBorder, height: 1),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
