import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/job_requests_header.dart';
import 'package:expertisemarket/features/ServiceProvider/request/widget/requests_list_view.dart';
import 'package:flutter/material.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = [
      RequestModel(
        title: "Corporate Brand Identity & Guidelines",
        summary:
            "Looking for a senior designer to create a complete brand package including logo, typography and visual assets.",

        clientName: "Marcus Thorne",
        clientImage: AppImages.User,
        reviews: "89 Reviews",

        description:
            "Expert in minimalist corporate identities and fintech branding with over 8 years experience.",

        budget: "\$1,500 - \$3,500",
        timeline: "14 Days",

        price: "\$1,800",

        timeAgo: "2 hours ago",

        isNew: true,

        problemPhotos: [AppImages.User, AppImages.User],
      ),

      RequestModel(
        title: "Corporate Brand Identity & Guidelines",
        summary: "Creative designer specialized in startup branding.",

        clientName: "Sarah Jenkins",
        clientImage: AppImages.User,
        reviews: "215 Reviews",

        description: "Top-rated agency expertise at a solo consultant rate.",

        budget: "\$2,000 - \$4,000",
        timeline: "10 Days",

        price: "\$3,200",

        timeAgo: "5 hours ago",

        problemPhotos: [AppImages.User, AppImages.User],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Job Requests"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const JobRequestsHeader(),

            const SizedBox(height: 20),

            Expanded(child: RequestsListView(requests: requests)),
          ],
        ),
      ),
    );
  }
}
