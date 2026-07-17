import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell_notifier.dart';

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
      leading: leading ??
          GestureDetector(
            onTap: () {
              // Switch to Profile tab (index 3) if inside MainShell,
              // otherwise push the profile route.
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
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      AppImages.User,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
      title: customTitle != null
          ? Text(customTitle!, style: MarketTextStyles.appBarTitle)
          : Text(
              'ExpertiseMarket',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
      actions: [
        // Wishlist icon → switch to Wishlist tab (index 1)
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
        child: Container(
          color: AppColors.marketBorder,
          height: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
