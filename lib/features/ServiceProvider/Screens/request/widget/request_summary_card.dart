import 'package:craftmarket/features/ServiceProvider/Screens/request/model/request_model.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/request/widget/request_info_row.dart';
import 'package:flutter/material.dart';

class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          request.title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff001A2C),
            height: 1.2,
          ),
        ),

        const SizedBox(height: 22),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffF1F7FD),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Client Request Summary",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff001A2C),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                request.summary,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Color(0xff64748B),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: RequestInfoRow(
                icon: Icons.schedule_outlined,
                text: "Timeline: ${request.timeline}",
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: RequestInfoRow(
                icon: Icons.attach_money_outlined,
                text: "Budget: ${request.budget}",
              ),
            ),
          ],
        ),
      ],
    );
  }
}