import 'package:flutter/material.dart';

class JobRequestsHeader
    extends StatelessWidget {
  const JobRequestsHeader({
    super.key,
    this.totalRequests,
    this.onSortPressed,
  });

  final int? totalRequests;

  final VoidCallback? onSortPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            totalRequests == null
                ? "Available Requests"
                : "$totalRequests Available Requests",
            style: const TextStyle(
              fontSize: 22,
              fontWeight:
                  FontWeight.bold,
              color: Color(0xff001A2C),
            ),
          ),
        ),

        InkWell(
          onTap: onSortPressed,
          borderRadius:
              BorderRadius.circular(12),
          child: Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                12,
              ),
              border: Border.all(
                color: const Color(
                  0xffE2E8F0,
                ),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.sort,
                  size: 18,
                  color: Color(
                    0xff64748B,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "Latest",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(
                      0xff64748B,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons
                      .keyboard_arrow_down,
                  size: 18,
                  color: Color(
                    0xff64748B,
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