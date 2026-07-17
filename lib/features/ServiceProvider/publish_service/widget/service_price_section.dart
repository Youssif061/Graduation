import 'package:flutter/material.dart';

import 'publish_section_card.dart';

class ServicePriceSection extends StatelessWidget {
  const ServicePriceSection({
    super.key,
    required this.controller,
    required this.transportation,
    required this.negotiate,
    required this.onTransportationChanged,
    required this.onNegotiateChanged,
  });

  final TextEditingController controller;

  final bool transportation;

  final bool negotiate;

  final ValueChanged<bool> onTransportationChanged;

  final ValueChanged<bool> onNegotiateChanged;

  @override
  Widget build(BuildContext context) {
    return PublishSectionCard(
      title: 'Job Pricing (\$)',
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Exact Price',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          SwitchListTile(
            value: transportation,
            contentPadding: EdgeInsets.zero,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF006C3F),
            title: const Text('Customer pays for transportation'),
            onChanged: onTransportationChanged,
          ),

          SwitchListTile(
            value: negotiate,
            contentPadding: EdgeInsets.zero,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF006C3F),
            title: const Text('Willing to negotiate'),
            onChanged: onNegotiateChanged,
          ),
        ],
      ),
    );
  }
}
