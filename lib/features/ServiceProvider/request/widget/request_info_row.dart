import 'package:flutter/material.dart';

class RequestInfoRow extends StatelessWidget {
  const RequestInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xff64748B),
          size: 20,
        ),

        const SizedBox(width: 10),

        Text(
          "$title: ",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xff64748B),
            ),
          ),
        ),
      ],
    );
  }
}