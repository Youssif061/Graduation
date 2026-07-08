import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePhotoCard extends StatelessWidget {
  const ProfilePhotoCard({
    super.key,
    required this.hasPhoto,
    required this.onChangePhoto,
    required this.onDeletePhoto,
  });

  final bool hasPhoto;
  final VoidCallback onChangePhoto;
  final VoidCallback onDeletePhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.l),
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(color: AppColors.marketBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: AppColors.marketCardLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.marketBorder, width: 2),
                ),
                child: Icon(
                  hasPhoto ? Icons.person : Icons.person_outline,
                  size: 56,
                  color: AppColors.marketTextSub,
                ),
              ),
              Positioned(
                right: 2,
                bottom: 4,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.marketGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 17, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onChangePhoto,
                child: Text(
                  'Change Photo',
                  style: MarketTextStyles.bodySmall.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.marketText,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.m),
              TextButton.icon(
                onPressed: onDeletePhoto,
                icon: SvgPicture.asset(
                  'assets/icons/delete.svg',
                  width: AppSizes.iconS,
                  height: AppSizes.iconS,
                  colorFilter: const ColorFilter.mode(
                    AppColors.marketRed,
                    BlendMode.srcIn,
                  ),
                ),
                label: Text(
                  'Delete',
                  style: MarketTextStyles.bodySmall.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.marketRed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
