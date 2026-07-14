import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/chats/presentation/pages/chats_page.dart';
import 'package:expertisemarket/features/home/presentation/pages/home_page.dart';
import 'package:expertisemarket/features/products/presentation/pages/products_tab.dart';
import 'package:expertisemarket/features/pros/presentation/pages/pros_page.dart';
import 'package:expertisemarket/features/request/presentation/pages/request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainShell extends StatefulWidget {
  final int initialIndex;

  const MainShell({
    super.key,
    this.initialIndex = 2,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  final List<Widget> _tabs = const [
    HomePage(),
    ProsPage(),
    ProductsTab(),
    RequestPage(),
    ChatsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBg,
        border: Border(
          top: BorderSide(
            color: AppColors.marketBorder,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _UserNavItem(
                iconPath: AppImages.homeUserSvg,
                label: 'Home',
                isActive: _currentIndex == 0,
                onTap: () => _selectTab(0),
              ),
              _UserNavItem(
                iconPath: AppImages.prosUserSvg,
                label: 'Pros',
                isActive: _currentIndex == 1,
                onTap: () => _selectTab(1),
              ),
              _UserNavItem(
                iconPath: AppImages.productsUserSvg,
                label: 'Products',
                isActive: _currentIndex == 2,
                onTap: () => _selectTab(2),
              ),
              _UserNavItem(
                iconPath: AppImages.requestUserSvg,
                label: 'Request',
                isActive: _currentIndex == 3,
                onTap: () => _selectTab(3),
              ),
              _UserNavItem(
                iconPath: AppImages.chatsUserSvg,
                label: 'Chats',
                isActive: _currentIndex == 4,
                onTap: () => _selectTab(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectTab(int index) {
    if (_currentIndex == index) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }
}

class _UserNavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _UserNavItem({
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color itemColor =
    isActive ? AppColors.navActive : AppColors.navInactive;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  itemColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                  isActive ? FontWeight.w700 : FontWeight.w500,
                  color: itemColor,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}