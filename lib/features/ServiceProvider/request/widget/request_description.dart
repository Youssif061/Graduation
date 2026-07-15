import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter/material.dart';

class RequestDescription extends StatelessWidget {
  const RequestDescription({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Project Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          request.description,
          style: const TextStyle(
            fontSize: 15,
            height: 1.7,
            color: Color(0xff64748B),
          ),
        ),
      ],
    );
  }
}