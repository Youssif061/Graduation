import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  const CustomChip({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff0B253B)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xff0B253B)
                : const Color(0xffD9E1E8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: selected
                ? Colors.white
                : const Color(0xff263B4D),
          ),
        ),
      ),
    );
  }
}