import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/presentation/widgets/market_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = false;
  final _fullNameCtrl = TextEditingController(text: 'David Miller');

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    super.dispose();
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
          Text(
            'Profile',
            style: MarketTextStyles.sectionTitle.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.marketText,
            ),
          ),
          const SizedBox(height: 16),
          // Avatar Card
          _SettingsCard(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: AppColors.marketCardLight,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.marketBorder,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.marketTextSub,
                        size: 48,
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.marketGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Change Photo',
                        style: MarketTextStyles.bodySmall.copyWith(
                          color: AppColors.marketText,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        '🗑 Delete',
                        style: MarketTextStyles.bodySmall.copyWith(
                          color: AppColors.marketRed,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Account Settings section
          Text(
            'ACCOUNT SETTINGS',
            style: MarketTextStyles.sectionLabel.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          _SettingsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FieldLabel('FULL NAME'),
                const SizedBox(height: 8),
                _InputField(controller: _fullNameCtrl),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change Password',
                        style: MarketTextStyles.productTitle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.marketText,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.marketTextSub,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Preferences section
          Text(
            'PREFERENCES',
            style: MarketTextStyles.sectionLabel.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          _SettingsCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: MarketTextStyles.productTitle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.marketText,
                  ),
                ),
                Switch(
                  value: _darkMode,
                  onChanged: (val) {
                    setState(() => _darkMode = val);
                  },
                  activeThumbColor: AppColors.marketGreen,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Logout Section
          _SettingsCard(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Logout',
                    style: MarketTextStyles.productTitle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.marketRed,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.marketRed,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.marketBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.01), blurRadius: 8),
        ],
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppColors.marketTextMuted,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;

  const _InputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.marketInputBg, // Soft blue-grey field background
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: MarketTextStyles.bodyMedium.copyWith(
          color: AppColors.marketText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}
