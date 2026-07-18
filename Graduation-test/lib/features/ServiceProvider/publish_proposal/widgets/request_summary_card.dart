import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter/material.dart';

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xffE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Client Request Summary",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff001A2C),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            request.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff001A2C),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            request.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Color(0xff475569),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              const Icon(
                Icons.attach_money_rounded,
                color: Color(0xff64748B),
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  "Budget: \$${request.minBudget.toStringAsFixed(0)} - \$${request.maxBudget.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475569),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Color(0xff64748B),
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  "Timeline: ${request.timeline}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475569),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Color(0xff64748B),
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  request.location,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff475569),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xff64748B),
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  "Status: ${request.status}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: request.status.toLowerCase() == "open"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}