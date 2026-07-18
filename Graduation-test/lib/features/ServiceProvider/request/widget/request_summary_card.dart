import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/request_info_row.dart';
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
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            request.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff001A2C),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Client Request Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                    color: Color(
                      0xff001A2C,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  request.summary,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Color(
                      0xff64748B,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          RequestInfoRow(
            icon: Icons.attach_money,
            title: "Budget",
            value: request.budget,
          ),

          const SizedBox(height: 14),

          RequestInfoRow(
            icon: Icons.schedule,
            title: "Timeline",
            value: request.timeline,
          ),

          const SizedBox(height: 14),

          RequestInfoRow(
            icon: Icons.location_on,
            title: "Location",
            value: request.location,
          ),
        ],
      ),
    );
  }
}