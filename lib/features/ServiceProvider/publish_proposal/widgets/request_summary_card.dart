import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter/material.dart';

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({super.key, required RequestModel request});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Client Request Summary",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff001A2C),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Looking for a senior developer to integrate our legacy ERP system with a new cloud-based CRM. Requires expertise in REST APIs and secure data synchronization.",
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff43474D),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.monetization_on_rounded,
                    size: 20,
                    color: Color(0xff43474D),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Budget: \$1,500 - \$3,500",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff43474D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 20,
                    color: Color(0xff43474D),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Timeline: 14 days",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff43474D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(width: 24),

                  Icon(
                    Icons.location_on_rounded,
                    size: 20,
                    color: Color(0xff43474D),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Remote",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff43474D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
