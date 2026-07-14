import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'request_text_field.dart';

class PricingPreferenceSection extends StatelessWidget {
  const PricingPreferenceSection({
    super.key,
    required this.budgetController,
    required this.willingToNegotiate,
    required this.onNegotiationChanged,
    required this.budgetValidator,
  });

  final TextEditingController budgetController;
  final bool willingToNegotiate;
  final ValueChanged<bool> onNegotiationChanged;
  final String? Function(String?) budgetValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pricing Preference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.marketText,
          ),
        ),
        const SizedBox(height: 18),
        RequestTextField(
          controller: budgetController,
          label: 'Budget Amount',
          hintText: 'e.g. 150',
          prefixText: '\$ ',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          validator: budgetValidator,
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => onNegotiationChanged(!willingToNegotiate),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: willingToNegotiate
                  ? AppColors.marketGreenBadge
                  : AppColors.marketCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: willingToNegotiate
                    ? AppColors.marketGreenDark
                    : AppColors.inputBorderColor,
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: willingToNegotiate,
                  activeColor: AppColors.marketGreenDark,
                  onChanged: (value) {
                    onNegotiationChanged(value ?? false);
                  },
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Willing to negotiate',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.marketText,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Open to expert quotes',
                        style: TextStyle(
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
        ),
      ],
    );
  }
}
