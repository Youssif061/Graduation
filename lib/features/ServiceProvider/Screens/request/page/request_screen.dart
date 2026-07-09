import 'package:craftmarket/features/ServiceProvider/Screens/request/model/request_model.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/request/widget/request_job_card.dart';
import 'package:craftmarket/features/ServiceProvider/Screens/request/widget/request_summary_card.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff001A2C),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequestSummaryCard(
              request: request,
            ),

            const SizedBox(height: 28),

            const Text(
              "Client Proposal",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff001A2C),
              ),
            ),

            const SizedBox(height: 18),

            RequestJobCard(
              request: request,
            ),
          ],
        ),
      ),
    );
  }
}