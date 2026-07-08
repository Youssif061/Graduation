import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/ServiceProvider/profile/presentation/widgets/profile_action_tile.dart';
import 'package:expertisemarket/features/ServiceProvider/profile/presentation/widgets/profile_name_field.dart';
import 'package:expertisemarket/features/ServiceProvider/profile/presentation/widgets/profile_photo_card.dart';
import 'package:expertisemarket/features/ServiceProvider/profile/presentation/widgets/profile_section_label.dart';
import 'package:expertisemarket/features/ServiceProvider/profile/presentation/widgets/profile_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceProviderProfilePage extends StatefulWidget {
  const ServiceProviderProfilePage({super.key});

  @override
  State<ServiceProviderProfilePage> createState() =>
      _ServiceProviderProfilePageState();
}

class _ServiceProviderProfilePageState
    extends State<ServiceProviderProfilePage> {
  final TextEditingController _fullNameController = TextEditingController(
    text: 'David Miller',
  );

  bool _darkMode = false;
  bool _hasPhoto = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _showPhotoOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.marketCard,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                    color: AppColors.marketText,
                  ),
                  title: const Text('Choose from gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _markPhotoChanged();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.marketText,
                  ),
                  title: const Text('Take a photo'),
                  onTap: () {
                    Navigator.pop(context);
                    _markPhotoChanged();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _markPhotoChanged() {
    setState(() {
      _hasPhoto = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Photo selection updated')));
  }

  Future<void> _deletePhoto() async {
    final bool shouldDelete =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete profile photo?'),
              content: const Text(
                'Your current profile photo will be removed.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: AppColors.marketRed),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!shouldDelete || !mounted) {
      return;
    }

    setState(() {
      _hasPhoto = false;
    });
  }

  Future<void> _logout() async {
    final bool shouldLogout =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Logout?'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: AppColors.marketRed),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!shouldLogout || !mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Logged out')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _ProfileHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.md,
                  AppSizes.s,
                  AppSizes.md,
                  AppSizes.xxl,
                ),
                children: [
                  Text(
                    'Profile',
                    style: MarketTextStyles.sectionTitle.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.marketText,
                    ),
                  ),
                  const SizedBox(height: AppSizes.md),
                  ProfilePhotoCard(
                    hasPhoto: _hasPhoto,
                    onChangePhoto: _showPhotoOptions,
                    onDeletePhoto: _deletePhoto,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  const ProfileSectionLabel(label: 'ACCOUNT SETTINGS'),
                  const SizedBox(height: AppSizes.s),
                  ProfileNameField(controller: _fullNameController),
                  const SizedBox(height: AppSizes.s),
                  ProfileActionTile(
                    title: 'Change Password',
                    onTap: () {
                      Navigator.pushNamed(context, Routers.changePassword);
                    },
                  ),
                  const SizedBox(height: AppSizes.xl),
                  const ProfileSectionLabel(label: 'PREFERENCES'),
                  const SizedBox(height: AppSizes.s),
                  ProfileSwitchTile(
                    title: 'Dark Mode',
                    value: _darkMode,
                    onChanged: (value) {
                      setState(() {
                        _darkMode = value;
                      });
                    },
                  ),
                  const SizedBox(height: AppSizes.xl),
                  ProfileActionTile(
                    title: 'Logout',
                    isDestructive: true,
                    onTap: _logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).maybePop();
              },
              borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s),
                child: SvgPicture.asset(
                  'assets/icons/back.svg',
                  width: AppSizes.iconL,
                  height: AppSizes.iconL,
                  colorFilter: const ColorFilter.mode(
                    AppColors.marketText,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.s),
            Expanded(
              child: Text(
                'ExpertiseMarket',
                style: MarketTextStyles.sectionTitle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.marketText,
                ),
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.marketCard,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.marketBorder),
              ),
              child: const Icon(
                Icons.person_outline,
                color: AppColors.marketText,
                size: AppSizes.iconL,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
