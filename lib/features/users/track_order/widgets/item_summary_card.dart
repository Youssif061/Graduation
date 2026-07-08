import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../constants/track_order_icons.dart';
import '../models/track_order_model.dart';

class ItemSummaryCard extends StatelessWidget {
  const ItemSummaryCard({
    super.key,
    required this.order,
  });

  final TrackOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyColor.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                TrackOrderIcons.itemSummary,
                width: 18,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.navyColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Item Summary',
                  style: ExpertiseTextStyles.screenTitle.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: AppColors.navyColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildItemDetails(),
          const SizedBox(height: AppSpacing.lg),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.inputBorderColor.withValues(alpha: 0.7),
          ),
          const SizedBox(height: AppSpacing.lg),
          _PriceRow(
            label: 'Taxes',
            value: _formatCurrency(
              order.taxes,
              showCents: true,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _PriceRow(
            label: 'Total Paid',
            value: _formatCurrency(
              order.totalPaid,
              showCents: true,
            ),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildItemDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItemImage(),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      order.serviceName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ExpertiseTextStyles.sectionTitle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    _formatCurrency(
                      order.itemPrice,
                      showCents: order.itemPrice % 1 != 0,
                    ),
                    style: ExpertiseTextStyles.sectionTitle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.navyColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                order.packageName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: ExpertiseTextStyles.bodyMedium.copyWith(
                  fontSize: 16,
                  height: 1.4,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              if (order.isVerifiedExpert) ...[
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    SvgPicture.asset(
                      TrackOrderIcons.verifiedExpert,
                      width: 13,
                      height: 13,
                      colorFilter: const ColorFilter.mode(
                        AppColors.emeraldColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Flexible(
                      child: Text(
                        'Verified Expert',
                        style: ExpertiseTextStyles.helper.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.emeraldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemImage() {
    const double imageSize = AppSpacing.xxl * 2;

    final String? imagePath = order.itemImagePath;

    if (imagePath != null && imagePath.trim().isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        child: Image.asset(
          imagePath,
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildImagePlaceholder(imageSize),
        ),
      );
    }

    return _buildImagePlaceholder(imageSize);
  }

  Widget _buildImagePlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.navyColor,
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        TrackOrderIcons.itemSummary,
        width: 32,
        height: 36,
        colorFilter: const ColorFilter.mode(
          AppColors.surfaceColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  String _formatCurrency(
      double value, {
        required bool showCents,
      }) {
    final String fixedValue = value.toStringAsFixed(
      showCents ? 2 : 0,
    );

    final List<String> parts = fixedValue.split('.');

    final String wholeNumber = parts.first.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (_) => ',',
    );

    if (!showCents) {
      return '${order.currencySymbol}$wholeNumber';
    }

    return '${order.currencySymbol}$wholeNumber.${parts.last}';
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = isTotal
        ? ExpertiseTextStyles.sectionTitle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.navyColor,
    )
        : ExpertiseTextStyles.bodyMedium.copyWith(
      fontSize: 16,
      color: AppColors.textSecondaryColor,
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: style,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Text(
          value,
          style: isTotal
              ? style.copyWith(fontSize: 22)
              : style.copyWith(
            color: AppColors.textPrimaryColor,
          ),
        ),
      ],
    );
  }
}