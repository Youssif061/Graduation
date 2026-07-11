import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/client_header.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/problem_photos.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/request_action_buttons.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/request_description.dart';
import 'package:flutter/material.dart';

class RequestJobCard extends StatelessWidget {
  const RequestJobCard({super.key, required this.request});

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: const Color(0xffE5E7EB)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClientHeader(request: request),

          const SizedBox(height: 24),

          RequestDescription(request: request),

          const SizedBox(height: 24),

          ProblemPhotos(images: request.problemPhotos),

          const SizedBox(height: 30),

          const RequestActionButtons(),
        ],
      ),
    );
  }
}
