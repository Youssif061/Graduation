import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/users/products/presentation/widgets/primary_button.dart';
import 'package:expertisemarket/features/users/widgets/booking_widget.dart'
    hide AppColors, PrimaryButton;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RateProfessionalScreen extends StatefulWidget {
  const RateProfessionalScreen({super.key});

  @override
  State<RateProfessionalScreen> createState() => _RateProfessionalScreenState();
}

class _RateProfessionalScreenState extends State<RateProfessionalScreen> {
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 0;
  Future<void> submitReview() async {
    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection("feedback").add({
      "userId": user?.uid,
      "email": user?.email,
      "rating": _rating,
      "review": _reviewController.text.trim(),
      "createdAt": Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return MobilePage(
      header: const SimpleTopBar(title: 'Rate Experience'),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 64),
        child: Column(
          children: [
            const RatingProfessionalCard(),
            const SizedBox(height: 32),
            AppCard(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
              child: Column(
                children: [
                  Text(
                    'How was your service?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.ContainerColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your feedback helps the community\nfind the best experts.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starNumber = index + 1;
                      final selected = starNumber <= _rating;
                      return IconButton(
                        tooltip: '$starNumber star',
                        onPressed: () => setState(() => _rating = starNumber),
                        icon: Icon(
                          selected ? Icons.star : Icons.star_border,
                          color: selected
                              ? const Color(0xffffc857)
                              : const Color(0xffc7ccd5),
                          size: 40,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Write your review (optional)',
                      style: TextStyle(
                        color: Color(0xff1f2937),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reviewController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          'Tell us what you liked or how Marcus could improve...',
                      hintStyle: const TextStyle(color: Color(0xff8a94a6)),
                      filled: true,
                      fillColor: const Color(0xfff4f8fc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xffcbd5e1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xffcbd5e1)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    label: 'Submit Review',
                    onTap: () async {
                      if (_rating == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a rating"),
                          ),
                        );
                        return;
                      }

                      await submitReview();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Thank you for your feedback ❤️"),
                        ),
                      );

                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xffd8f8e4),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, color: AppColors.emeraldColor, size: 18),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Your review will be public and verified',
                      style: TextStyle(
                        color: AppColors.emeraldColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
