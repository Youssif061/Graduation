import 'package:craftmarket/core/constants/app_images.dart';
import 'package:craftmarket/core/styles/coloras.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/notification/widget/activity_card.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/notification/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF8FAFC),
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: SvgPicture.asset(AppImages.backSvg, width: 20, height: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001A2C),
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activity',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Mark all as read',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Today'),
            const SizedBox(height: 12),

            ActivityCard(
              iconPath: AppImages.correctSvg,
              title: 'Payment Received',
              subtitle:
                  'Transaction of \$1,200.00 for "Cloud Strategy Roadmap" was successful.',
              time: '2h ago',
              isVerified: true,
            ),
            ActivityCard(
              iconPath: AppImages.workSvg,
              title: 'New Proposal',
              subtitle:
                  'Sarah Jenkins submitted a proposal for your UI Audit Project.',
              time: '5h ago',
            ),
            ActivityCard(
              iconPath: AppImages.messageSvg,
              title: 'New Message',
              subtitle:
                  '"I\'ve uploaded the revised wireframes. Let me know if the user flow matches..."',
              time: '8h ago',
              hasUnreadDot: true,
            ),

            const SizedBox(height: 20),

            const SectionHeader(title: 'Earlier'),
            const SizedBox(height: 12),

            ActivityCard(
              iconPath: AppImages.inventorySvg,
              title: 'Stock Low',
              subtitle:
                  'Digital Asset Bundle: "Icon Set v2.0" has less than 5 copies remaining.',
              time: 'Yesterday',
            ),
            ActivityCard(
              iconPath: AppImages.protectSvg,
              title: 'Login Detected',
              subtitle:
                  'A new login was detected from Chrome on MacOS in New York, USA.',
              time: '2 days ago',
            ),
          ],
        ),
      ),
    );
  }
}
