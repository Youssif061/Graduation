import 'package:expertisemarket/features/users/screens/booking_completed.dart';
import 'package:expertisemarket/features/users/widgets/booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingStatusScreen extends StatelessWidget {
  final String bookingId;

  const BookingStatusScreen({super.key, required this.bookingId});
  Future<void> cancelBooking() async {
    await FirebaseFirestore.instance
        .collection("bookings")
        .doc(bookingId)
        .update({"status": "Cancelled", "cancelDate": Timestamp.now()});
  }

  @override
  Widget build(BuildContext context) {
    return MobilePage(
      header: const BrandTopBar(),
      bottomNavigationBar: const BookingBottomNav(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 110),
        child: Column(
          children: [
            const StatusTimelineCard(),
            const SizedBox(height: 50),
            const ProfessionalStatusCard(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Contact Pro',
                    icon: Icons.chat_bubble_outline,
                    onTap: () =>
                        pushScreen(context, const BookingCompletedScreen()),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlineActionButton(
                    label: 'Cancel Service',
                    icon: Icons.close,
                    color: AppColors.red,
                    onTap: () async {
                      await cancelBooking();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Booking cancelled successfully"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const StatusServiceDetailsCard(),
          ],
        ),
      ),
    );
  }
}
