import 'package:flutter/material.dart';

class InventoryFilterRow extends StatelessWidget {
  const InventoryFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Button(icon: Icons.filter_list, text: 'Filter'),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _Button(icon: Icons.sort, text: 'Sort'),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: const Color(0xff475569)),

          const SizedBox(width: 8),

          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xff334155),
            ),
          ),
        ],
      ),
    );
  }
}
