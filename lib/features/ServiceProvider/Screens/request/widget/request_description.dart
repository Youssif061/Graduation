import 'package:craftmarket/features/ServiceProvider/Screens/request/model/request_model.dart';
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
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          request.description,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xff64748B),
            height: 1.7,
          ),
        ),
      ],
    );
  }
}