import 'package:expertisemarket/features/users/screens/booking_status.dart';
import 'package:expertisemarket/features/users/widgets/booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingSuccessScreen extends StatelessWidget {
  final String service;
  final String expert;
  final double price;
  final String address;
  final String date;
  final String time;

  const BookingSuccessScreen({
    super.key,
    required this.service,
    required this.expert,
    required this.price,
    required this.address,
    required this.date,
    required this.time,
  });
  Future<String> saveBooking() async {
    final user = FirebaseAuth.instance.currentUser;

    DocumentReference doc = await FirebaseFirestore.instance
        .collection("bookings")
        .add({
          "userId": user?.uid,
          "status": "Booked",

          "service": service,
          "expert": expert,
          "price": price,

          "address": address,
          "date": date,
          "time": time,

          "bookingDate": Timestamp.now(),
        });
    return doc.id;
  }

  @override
  Widget build(BuildContext context) {
    return MobilePage(
      header: const BrandTopBar(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        child: Column(
          children: [
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 32, 32, 40),
                    child: Column(
                      children: [
                        const SuccessCircle(size: 96, iconSize: 42),
                        const SizedBox(height: 28),
                        const Text(
                          'Booking\nSuccessful',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your expert service has been booked\nsuccessfully.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.body,
                            fontSize: 16,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const OrderInfoCard(),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xffeaf4ff),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: PrimaryButton(
                      label: 'Track Booking',
                      icon: Icons.arrow_forward,
                      onTap: () async {
                        String bookingId = await saveBooking();

                        pushScreen(
                          context,
                          BookingStatusScreen(bookingId: bookingId),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const ProTipCard(),
          ],
        ),
      ),
    );
  }
}
