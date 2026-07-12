import 'package:craftmarket/core/functions/navigations.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/chat/page/chat_screen.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/home/page/home_screen.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/inventory/page/inventory_screen.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/notification/page/notification_screen.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/profile/page/profile_screen.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/request/page/requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craftmarket/core/constants/app_images.dart';
import 'package:craftmarket/core/styles/coloras.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const RequestsScreen(),
    const InventoryScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,

        leadingWidth: 60,

        leading: Padding(
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
                  AppImages.userPng,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CraftMarket',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text(
              'PREMIUM SELLER',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF006D37),
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppImages.notificationsSvg,
              width: 26,
              height: 26,
            ),
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) => const NotificationScreen()),
              // );
                naviagationPush(context, const NotificationScreen());
            },
          ),
          const SizedBox(width: 8),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),

      body: IndexedStack(index: currentIndex, children: screens),

      bottomNavigationBar: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.homeServiceProviderSvg,
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  AppImages.homeServiceProviderSvg,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.requestsServiceProviderSvg,
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  AppImages.requestsServiceProviderSvg,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Requests',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.inventoryServiceProviderSvg,
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  AppImages.inventoryServiceProviderSvg,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Inventory',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.chatsServiceProviderSvg,
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  AppImages.chatsServiceProviderSvg,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppImages.profileSvg,
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  AppImages.profileSvg,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
