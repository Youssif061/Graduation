import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:expertisemarket/features/ServiceProvider/request/page/request_screen.dart';
import 'package:flutter/material.dart';

class LatestRequestsListView extends StatelessWidget {
  const LatestRequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RequestModel> requests = [
      RequestModel(
        title: "Corporate Brand Identity & Guidelines",
        summary:
            "Looking for a senior designer to create a complete brand package including logo, typography and visual assets for a fintech startup.",

        clientName: "Marcus Thorne",
        clientImage: AppImages.User,
        reviews: "89 Reviews",

        description:
            "Expert in minimalist corporate identities and fintech branding with over 8 years experience. Looking for someone to create a complete branding package.",

        budget: "\$1,500 - \$3,500",
        timeline: "14 Days",

        price: "\$1,800",

        timeAgo: "2 hours ago",

        isNew: true,

        problemPhotos: [AppImages.User, AppImages.User],
      ),

      RequestModel(
        title: "Corporate Brand Identity & Guidelines",
        summary:
            "Creative designer specialized in startup branding and premium identity systems.",

        clientName: "Sarah Jenkins",
        clientImage: AppImages.User,
        reviews: "215 Reviews",

        description:
            "Top-rated agency expertise at a solo consultant rate. Looking for premium branding package.",

        budget: "\$2,000 - \$4,000",
        timeline: "10 Days",

        price: "\$3,200",

        timeAgo: "5 hours ago",

        problemPhotos: [AppImages.User, AppImages.User],
      ),
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final item = requests[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xffE5E7EB)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffEBF5FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.design_services,
                  color: Color(0xff001A2C),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff001A2C),
                            ),
                          ),
                        ),

                        if (item.isNew)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffD1FAE5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "NEW",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff065F46),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Client: ${item.clientName}",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "• ${item.timeAgo}",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RequestScreen(
                        request: item,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff001A2C),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("View Details"),
              ),
            ],
          ),
        );
      },
    );
  }
}
