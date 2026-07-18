import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
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

    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 60,
      leading:
          leading ??
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users') // لو عندك clients غيرها إلى clients
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .get(),
            builder: (context, snapshot) {
              String image = "";
              String name = "ExpertiseMarket";

              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data()!;

                name = data['name'] ?? "name";
                image = data['image'] ?? "";
              }

              return GestureDetector(
                onTap: () {
                  if (notifier != null) {
                    notifier.switchTab(3);
                  } else {
                    Navigator.pushNamed(context, Routers.profile);
                  }
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
              );
            },
          ),
      title: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('users') // أو clients
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, snapshot) {
          String name = "ExpertiseMarket";

          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data()!;
            name = data['name'] ?? "ExpertiseMarket";
          }

          return Text(
            customTitle ?? name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
      actions: [
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
        // Cart icon → switch to Cart tab (index 2)
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
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.marketBorder, height: 1),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
