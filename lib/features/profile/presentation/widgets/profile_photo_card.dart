import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/profile/models/user_profile_model.dart';
import 'package:flutter/material.dart';

class ProfilePhotoCard extends StatelessWidget {
  const ProfilePhotoCard({
    super.key,
    required this.profile,
    required this.isBusy,
    required this.onChangePhoto,
    required this.onDeletePhoto,
  });

  final UserProfileModel profile;
  final bool isBusy;
  final VoidCallback onChangePhoto;
  final VoidCallback onDeletePhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 104,
              height: 104,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.marketCard,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.marketBorder, width: 2),
              ),
              child: ClipOval(child: _buildPhoto()),
            ),
            Positioned(
              right: 1,
              bottom: 3,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.marketGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
            if (isBusy)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          profile.fullName.isEmpty ? 'ExpertiseMarket User' : profile.fullName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.marketText,
          ),
        ),
        if (profile.email.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            profile.email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.marketTextSub,
            ),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: isBusy ? null : onChangePhoto,
              icon: const Icon(Icons.photo_camera_outlined, size: 17),
              label: const Text('Change Photo'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.marketGreenDark,
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            TextButton.icon(
              onPressed: isBusy || !profile.hasPhoto ? null : onDeletePhoto,
              icon: const Icon(Icons.delete_outline_rounded, size: 17),
              label: const Text('Delete'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.marketRed,
                disabledForegroundColor: AppColors.marketTextMuted,
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoto() {
    if (!profile.hasPhoto) {
      return Image.asset(
        AppImages.User,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const ColoredBox(
            color: AppColors.marketCardLight,
            child: Icon(
              Icons.person_rounded,
              size: 58,
              color: AppColors.marketTextMuted,
            ),
          );
        },
      );
    }

    return Image.network(
      profile.photoUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) {
          return child;
        }

        return const ColoredBox(
          color: AppColors.marketCardLight,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.marketGreen,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const ColoredBox(
          color: AppColors.marketCardLight,
          child: Icon(
            Icons.person_rounded,
            size: 58,
            color: AppColors.marketTextMuted,
          ),
        );
      },
    );
  }
}
