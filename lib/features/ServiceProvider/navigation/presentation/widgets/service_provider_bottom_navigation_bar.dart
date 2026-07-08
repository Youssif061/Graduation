import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceProviderBottomNavigationBar extends StatelessWidget {
  const ServiceProviderBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<_NavigationItemData> _items = [
    _NavigationItemData(
      label: 'Home',
      iconPath: 'assets/icons/home_ServiceProvider.svg',
      iconSize: 18,
    ),
    _NavigationItemData(
      label: 'Requests',
      iconPath: 'assets/icons/requests_ServiceProvider.svg',
      iconSize: 18,
    ),
    _NavigationItemData(
      label: 'Inventory',
      iconPath: 'assets/icons/inventory_ServiceProvider.svg',
      iconSize: 20,
    ),
    _NavigationItemData(
      label: 'Chats',
      iconPath: 'assets/icons/chats_ServiceProvider.svg',
      iconSize: 20,
    ),
    _NavigationItemData(
      label: 'Profile',
      iconPath: 'assets/icons/profile.svg',
      iconSize: 18,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppColors.navBg,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusL),
        ),
        border: Border(top: BorderSide(color: AppColors.marketBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Row(
            children: List.generate(
              _items.length,
              (index) => Expanded(
                child: _NavigationItem(
                  item: _items[index],
                  isSelected: currentIndex == index,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _NavigationItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected
        ? AppColors.navActive
        : AppColors.navInactive;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            item.iconPath,
            width: item.iconSize,
            height: item.iconSize,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            item.label,
            maxLines: 1,
            style: MarketTextStyles.bodySmall.copyWith(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationItemData {
  const _NavigationItemData({
    required this.label,
    required this.iconPath,
    required this.iconSize,
  });

  final String label;
  final String iconPath;
  final double iconSize;
}
