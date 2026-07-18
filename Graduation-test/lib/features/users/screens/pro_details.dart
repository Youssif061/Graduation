import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/users/data/models/pro_model.dart';
import 'package:expertisemarket/features/users/screens/booking.dart';
import 'package:expertisemarket/features/chats/presentation/pages/chat_detail_page.dart';
import 'package:expertisemarket/features/chats/data/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProDetailsScreen extends StatelessWidget {
  final ProModel pro;

  const ProDetailsScreen({super.key, required this.pro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      body: CustomScrollView(
        slivers: [
          // Header / Profile Banner Image
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/${pro.image}",
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black54, Colors.transparent, Colors.black87],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              pro.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (pro.isVerified)
                              const Icon(
                                Icons.verified,
                                color: AppColors.primaryColor,
                                size: 22,
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pro.job,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Details List
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick stats grid
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.marketBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat(Icons.star, "${pro.rating}", "Rating", color: AppColors.marketYellow),
                        _buildStat(Icons.history, "${pro.experience} yrs", "Experience"),
                        _buildStat(Icons.payments, "\$${pro.price}/hr", "Base Rate"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // About Section
                  const Text(
                    "About Professional",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Hello, I am ${pro.name}, a vetted and certified ${pro.job} specializing in ${pro.category} works. I guarantee high-quality craftsmanship, security standards compliance, and client satisfaction. Let's work together to complete your project with exceptional results.",
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Availability Section
                  const Text(
                    "Availability",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: AppColors.primaryColor),
                      SizedBox(width: 8),
                      Text("Monday - Saturday (09:00 AM - 06:00 PM)", style: TextStyle(color: AppColors.textSecondaryColor)),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Reviews List Section
                  const Text(
                    "Reviews (124)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildReview("Sarah Jenkins", 5.0, "Absolute lifesaver! Fixed my plumbing issue in no time. Highly recommended!"),
                  const SizedBox(height: 12),
                  _buildReview("John Doe", 4.8, "Prompt and professional. Cleaned up everything afterwards."),
                  const SizedBox(height: 100), // Padding for bottom actions
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.marketBorder),
          ),
        ),
        child: Row(
          children: [
            // Chat Button
            OutlinedButton(
              onPressed: () {
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please sign in to start a chat.")),
                  );
                  return;
                }
                final roomId = ChatRepository.instance.getRoomId(currentUser.uid, pro.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatDetailPage(
                      roomId: roomId,
                      recipientId: pro.uid,
                      recipientName: pro.name,
                      senderName: currentUser.displayName ?? currentUser.email?.split('@').first ?? 'Client',
                    ),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(60, 50),
                side: const BorderSide(color: AppColors.navyColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Icon(Icons.chat_bubble_outline, color: AppColors.navyColor),
            ),
            const SizedBox(width: 12),

            // Book Now Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingScreen(pro: pro),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navyColor,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Book Service Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label, {Color color = AppColors.navyColor}) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.navyColor)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMutedColor)),
      ],
    );
  }

  Widget _buildReview(String name, double rating, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.marketBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Row(
                children: [
                  const Icon(Icons.star, color: AppColors.marketYellow, size: 14),
                  const SizedBox(width: 2),
                  Text("$rating", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textSecondaryColor)),
        ],
      ),
    );
  }
}
