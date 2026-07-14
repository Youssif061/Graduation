import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/request/models/request_urgency.dart';
import 'package:flutter/material.dart';

class UrgencySelector extends StatelessWidget {
  const UrgencySelector({
    super.key,
    required this.selectedUrgency,
    required this.onChanged,
  });

  final RequestUrgency selectedUrgency;
  final ValueChanged<RequestUrgency> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Urgency Level',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.marketText,
          ),
        ),
        const SizedBox(height: 14),
        _UrgencyOption(
          urgency: RequestUrgency.low,
          title: 'Low',
          subtitle: 'Flexible schedule',
          selectedUrgency: selectedUrgency,
          onTap: onChanged,
        ),
        const SizedBox(height: 8),
        _UrgencyOption(
          urgency: RequestUrgency.medium,
          title: 'Medium',
          subtitle: 'Within 2–3 days',
          selectedUrgency: selectedUrgency,
          onTap: onChanged,
        ),
        const SizedBox(height: 8),
        _UrgencyOption(
          urgency: RequestUrgency.high,
          title: 'High',
          subtitle: 'Emergency — as soon as possible',
          selectedUrgency: selectedUrgency,
          onTap: onChanged,
        ),
      ],
    );
  }
}

class _UrgencyOption extends StatelessWidget {
  const _UrgencyOption({
    required this.urgency,
    required this.title,
    required this.subtitle,
    required this.selectedUrgency,
    required this.onTap,
  });

  final RequestUrgency urgency;
  final String title;
  final String subtitle;
  final RequestUrgency selectedUrgency;
  final ValueChanged<RequestUrgency> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = urgency == selectedUrgency;

    return InkWell(
      onTap: () => onTap(urgency),
      borderRadius: BorderRadius.circular(9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.marketGreenBadge : AppColors.marketCard,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: isSelected
                ? AppColors.marketGreenDark
                : AppColors.inputBorderColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.marketGreenDark
                      : AppColors.inputBorderColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.marketGreenDark,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: urgency == RequestUrgency.high
                          ? AppColors.marketRed
                          : AppColors.marketText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.marketTextSub,
                    ),
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
