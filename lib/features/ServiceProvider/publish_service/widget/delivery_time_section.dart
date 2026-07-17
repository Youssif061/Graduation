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

  static const List<Map<String, String>> _items = [
    {
      "title": "Standard",
      "subtitle": "3 - 5 Days",
    },
    {
      "title": "Express",
      "subtitle": "1 - 2 Days",
    },
    {
      "title": "Custom / Variable",
      "subtitle": "Based on project scope",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PublishSectionCard(
      title: "Delivery Time",
      child: Column(
        children: _items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: _DeliveryItem(
                  title: item["title"]!,
                  subtitle: item["subtitle"]!,
                  selected:
                      selected == item["title"],
                  onTap: () {
                    onChanged(item["title"]!);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DeliveryItem extends StatelessWidget {
  const _DeliveryItem({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 180,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xffF0FDF4)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xff22C55E)
                : const Color(0xffCBD5E1),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: selected
                  ? const Color(0xff22C55E)
                  : Colors.grey,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w700,
                      color: Color(
                        0xff001A2C,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(
                        0xff64748B,
                      ),
                      fontSize: 14,
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