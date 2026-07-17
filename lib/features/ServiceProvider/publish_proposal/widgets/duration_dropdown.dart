import 'package:flutter/material.dart';

class DurationDropdown extends StatelessWidget {
  const DurationDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String?> onChanged;

  static const durations = [
    "Less than 1 week",
    "1 to 2 weeks",
    "2 to 4 weeks",
    "More than 1 month",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffCBD5E1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: onChanged,
          items: durations.map((duration) {
            return DropdownMenuItem(
              value: duration,
              child: Text(duration),
            );
          }).toList(),
        ),
      ),
    );
  }
}