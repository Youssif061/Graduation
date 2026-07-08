import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/core/routes/routers.dart';

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
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      backgroundColor: Colors.white, // Pure white app bar as shown in mockup
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: leading ?? (canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.marketText),
              onPressed: () => Navigator.pop(context),
            )
          : null),
      title: customTitle != null
          ? Text(customTitle!, style: MarketTextStyles.appBarTitle)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Green user avatar circle as seen in screen 1 mockup
                if (!canPop)
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.marketGreenBadge,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.marketGreen,
                      size: 20,
                    ),
                  ),
                if (!canPop) const SizedBox(width: 10),
                Text(
                  canPop ? 'CraftMarket' : 'CraftMarket',
                  style: MarketTextStyles.appBarTitle,
                ),
              ],
            ),
      actions: [
        if (showHeart && !canPop)
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: AppColors.marketTextSub,
              size: 24,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routers.wishlist);
            },
            
          ),
           if (showCart && !canPop)
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.marketTextSub,
              size: 24,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routers.cart);
            },
            
          ),
        if (showProfile || canPop)
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
          )
        else
          const SizedBox(width: 4),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
