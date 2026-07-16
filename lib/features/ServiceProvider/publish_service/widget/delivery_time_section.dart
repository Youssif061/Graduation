import 'package:flutter/material.dart';

import 'publish_section_card.dart';

class DeliveryTimeSection extends StatelessWidget {
  const DeliveryTimeSection({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return PublishSectionCard(
      title: 'Delivery Time',
      child: Column(
        children: [
          _item(
            title: 'Standard',
            subtitle: '3-5 days',
          ),
          const SizedBox(height: 12),
          _item(
            title: 'Express',
            subtitle: '1-2 days',
          ),
          const SizedBox(height: 12),
          _item(
            title: 'Custom / Variable',
            subtitle: 'Based on project scope',
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String title,
    required String subtitle,
  }) {
    final bool active = selected == title;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onChanged(title),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFF2F9F6)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active
                ? const Color(0xFF006C3F)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Icon(
              active
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: active
                  ? const Color(0xFF006C3F)
                  : Colors.grey,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(subtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}