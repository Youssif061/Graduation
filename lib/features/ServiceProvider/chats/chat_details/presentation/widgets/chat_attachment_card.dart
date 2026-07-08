import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ChatAttachmentCard extends StatelessWidget {
  const ChatAttachmentCard({
    super.key,
    required this.fileName,
    required this.fileDetails,
    required this.onDownload,
  });

  final String fileName;
  final String fileDetails;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.marketInputBg,
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      child: InkWell(
        onTap: onDownload,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.m),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            border: Border.all(color: AppColors.marketBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.marketCard,
                  borderRadius: BorderRadius.circular(AppSizes.radiusS),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  size: AppSizes.iconM,
                  color: AppColors.marketRed,
                ),
              ),
              const SizedBox(width: AppSizes.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: MarketTextStyles.bodyMedium.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.marketText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      fileDetails,
                      style: MarketTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        color: AppColors.marketTextSub,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.s),
              const Icon(
                Icons.download_outlined,
                size: AppSizes.iconM,
                color: AppColors.marketText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
