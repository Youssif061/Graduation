import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter/material.dart';

class ClientHeader extends StatelessWidget {
  const ClientHeader({
    super.key,
    required this.request,
  });

  final RequestModel request;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: request.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              request.clientImage,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F5F9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xff64748B),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.clientName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff001A2C),
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xffF59E0B),
                    size: 18,
                  ),

                  const SizedBox(width: 4),

                  Text(
                    request.reviews,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffDCFCE7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            request.formattedPrice,
            style: const TextStyle(
              color: Color(0xff15803D),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}