import 'package:flutter/material.dart';

class RequestInfoRow extends StatelessWidget {
  const RequestInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xff64748B),
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff64748B),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}