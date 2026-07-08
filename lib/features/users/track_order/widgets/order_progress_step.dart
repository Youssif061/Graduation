import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../constants/track_order_icons.dart';
import '../models/track_order_step_model.dart';

class OrderProgressStep extends StatelessWidget {
  const OrderProgressStep({
    super.key,
    required this.step,
    required this.visualState,
    required this.isLast,
  });

  final TrackOrderStepModel step;
  final OrderStepVisualState visualState;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TimelineIndicator(
            stage: step.stage,
            visualState: visualState,
            isLast: isLast,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : AppSpacing.xl,
              ),
              child: _StepContent(
                step: step,
                visualState: visualState,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineIndicator extends StatelessWidget {
  const _TimelineIndicator({
    required this.stage,
    required this.visualState,
    required this.isLast,
  });

  final OrderStage stage;
  final OrderStepVisualState visualState;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      child: Column(
        children: [
          _StatusIcon(
            stage: stage,
            visualState: visualState,
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                margin: const EdgeInsets.only(top: AppSpacing.sm),
                color: _connectorColor,
              ),
            ),
        ],
      ),
    );
  }

  Color get _connectorColor {
    return visualState == OrderStepVisualState.completed
        ? AppColors.emeraldColor
        : AppColors.inputBorderColor;
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({
    required this.stage,
    required this.visualState,
  });

  final OrderStage stage;
  final OrderStepVisualState visualState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: _backgroundColor,
        shape: BoxShape.circle,
        border: visualState == OrderStepVisualState.current
            ? Border.all(
          color: AppColors.emeraldColor.withValues(alpha: 0.35),
          width: 2,
        )
            : null,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        _iconPath,
        width: _iconSize.width,
        height: _iconSize.height,
        colorFilter: ColorFilter.mode(
          _iconColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  String get _iconPath {
    switch (stage) {
      case OrderStage.orderPlaced:
      case OrderStage.processing:
        return TrackOrderIcons.orderStatusCheck;

      case OrderStage.outForDelivery:
        return TrackOrderIcons.outForDelivery;

      case OrderStage.delivered:
        return TrackOrderIcons.delivered;
    }
  }

  Size get _iconSize {
    switch (stage) {
      case OrderStage.orderPlaced:
      case OrderStage.processing:
        return const Size(11, 9);

      case OrderStage.outForDelivery:
        return const Size(15, 11);

      case OrderStage.delivered:
        return const Size(15, 9);
    }
  }

  Color get _backgroundColor {
    switch (visualState) {
      case OrderStepVisualState.completed:
        return AppColors.emeraldColor;

      case OrderStepVisualState.current:
        return AppColors.emeraldColor.withValues(alpha: 0.12);

      case OrderStepVisualState.upcoming:
        return AppColors.lightBackgroundColor;
    }
  }

  Color get _iconColor {
    switch (visualState) {
      case OrderStepVisualState.completed:
        return AppColors.surfaceColor;

      case OrderStepVisualState.current:
        return AppColors.emeraldColor;

      case OrderStepVisualState.upcoming:
        return AppColors.textMutedColor;
    }
  }
}

class _StepContent extends StatelessWidget {
  const _StepContent({
    required this.step,
    required this.visualState,
  });

  final TrackOrderStepModel step;
  final OrderStepVisualState visualState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step.title,
            style: ExpertiseTextStyles.label.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            step.description,
            style: ExpertiseTextStyles.bodyMedium.copyWith(
              height: 1.45,
              color: _descriptionColor,
            ),
          ),
          if (_showMeta) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              _metaText,
              style: ExpertiseTextStyles.helper.copyWith(
                fontSize: 14,
                color: _metaColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool get _showMeta {
    return visualState != OrderStepVisualState.upcoming;
  }

  String get _metaText {
    if (visualState == OrderStepVisualState.current) {
      return 'In Progress';
    }

    return _formatTimestamp(step.timestamp!);
  }

  String _formatTimestamp(DateTime dateTime) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final localDate = dateTime.toLocal();
    final month = months[localDate.month - 1];
    final hour =
    localDate.hour % 12 == 0 ? 12 : localDate.hour % 12;
    final minute = localDate.minute.toString().padLeft(2, '0');
    final period = localDate.hour >= 12 ? 'PM' : 'AM';

    return '$month ${localDate.day}, '
        '$hour:$minute $period';
  }

  Color get _titleColor {
    switch (visualState) {
      case OrderStepVisualState.completed:
        return AppColors.textPrimaryColor;

      case OrderStepVisualState.current:
        return AppColors.emeraldColor;

      case OrderStepVisualState.upcoming:
        return AppColors.textMutedColor;
    }
  }

  Color get _descriptionColor {
    return visualState == OrderStepVisualState.upcoming
        ? AppColors.textMutedColor.withValues(alpha: 0.65)
        : AppColors.textSecondaryColor;
  }

  Color get _metaColor {
    return visualState == OrderStepVisualState.current
        ? AppColors.emeraldColor
        : AppColors.textMutedColor;
  }
}