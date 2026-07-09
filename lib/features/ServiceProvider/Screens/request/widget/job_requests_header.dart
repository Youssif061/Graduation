import 'package:flutter/material.dart';

class JobRequestsHeader extends StatelessWidget {
  const JobRequestsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        const Spacer(),

        const Icon(
          Icons.sort,
          size: 18,
          color: Colors.grey,
        ),

        const SizedBox(width: 6),

        Text(
          "Sort by: Latest",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade700,
          ),
        ),

        const SizedBox(width: 4),

        const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
        ),
      ],
    );
  }
}