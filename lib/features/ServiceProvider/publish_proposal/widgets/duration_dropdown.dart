import 'package:flutter/material.dart';

class DurationDropdown extends StatelessWidget {
  const DurationDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffCBD5E1).withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.unfold_more_rounded,
            color: Color(0xff64748B),
            size: 22,
          ),
          style: const TextStyle(
            color: Color(0xff0F172A),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          onChanged: onChanged,
          items: const [
            DropdownMenuItem(
              value: "Less than 1 week",
              child: Text("Less than 1 week"),
            ),
            DropdownMenuItem(
              value: "1 to 2 weeks",
              child: Text("1 to 2 weeks"),
            ),
            DropdownMenuItem(
              value: "2 to 4 weeks",
              child: Text("2 to 4 weeks"),
            ),
            DropdownMenuItem(
              value: "More than 1 month",
              child: Text("More than 1 month"),
            ),
          ],
        ),
      ),
    );
  }
}
