import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/users/screens/booking_success.dart';
import 'package:expertisemarket/features/users/widgets/booking_widget.dart'
    hide AppColors;
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final String service;
  final String expert;
  final double price;

  final String address;
  final String date;
  final String time;
  const CheckoutScreen({
    super.key,
    required this.service,
    required this.expert,
    required this.price,
    required this.address,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return MobilePage(
      header: const SimpleTopBar(title: 'Checkout', trailing: ShieldIcon()),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 128),
        child: Column(
          children: [
            const ServiceProtectionCard(),
            const SizedBox(height: 32),
            AppCard(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(
                      color: AppColors.ContainerColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ServiceSummaryRow(service: service, expert: expert),
                  const SizedBox(height: 24),
                  PriceRow(label: 'Service Fee', value: '\$$price'),
                  const SizedBox(height: 24),
                  const PriceRow(label: 'Security Deposit', value: '\$25.00'),
                  const SizedBox(height: 16),
                  Divider(color: AppColors.borderColor),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL AMOUNT',
                              style: TextStyle(
                                color: AppColors.textMutedColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: .6,
                              ),
                            ),
                            Text(
                              '\$${price + 25}',
                              style: TextStyle(
                                color: AppColors.ContainerColor,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const GreenBadge(label: 'Tax Included', large: true),
                    ],
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Confirm Booking',
                    icon: Icons.lock_outline,
                    color: AppColors.emeraldColor ?? Colors.green,
                    height: 56,
                    onTap: () {
                      pushScreen(
                        context,
                        BookingSuccessScreen(
                          service: service,
                          expert: expert,
                          price: price,
                          address: address,
                          date: date,
                          time: time,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
