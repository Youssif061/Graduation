import 'package:expertisemarket/features/users/screens/rate_professional.dart';
import 'package:expertisemarket/features/users/widgets/booking_widget.dart';
import 'package:flutter/material.dart';



class BookingCompletedScreen extends StatelessWidget {
  const BookingCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobilePage(
      header: SimpleTopBar(
        title: 'Booking Completed',
        trailing: const AssetAvatar(size: 40, imagePath: 'assets/images/4.png'),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
        child: Column(
          children: [
            const CompletedStepper(),
            const SizedBox(height: 24),
            const CompletedSuccessCard(),
            const SizedBox(height: 24),
            const ExpertCompletedCard(),
            const SizedBox(height: 24),
            const CompletedServiceDetailsCard(),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Rate Professional',
              icon: Icons.star_border,
              onTap: () => pushScreen(context, const RateProfessionalScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
