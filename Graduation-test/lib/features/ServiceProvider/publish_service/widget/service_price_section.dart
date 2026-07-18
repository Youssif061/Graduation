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
      title: "Job Pricing (\$)",
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: "Exact Price",

              prefixIcon: const Icon(
                Icons.attach_money_rounded,
              ),

              contentPadding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xff001A2C),
                  width: 1.5,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),

              focusedErrorBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),

            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return "Price is required";
              }

              final price =
                  double.tryParse(value);

              if (price == null) {
                return "Enter a valid price";
              }

              if (price <= 0) {
                return "Price must be greater than zero";
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          SwitchListTile(
            value: transportation,
            contentPadding: EdgeInsets.zero,
            activeColor: Colors.white,
            activeTrackColor:
                const Color(0xff006C3F),
            title: const Text(
              "Customer pays for transportation",
            ),
            subtitle: const Text(
              "Transportation cost will be added separately.",
            ),
            onChanged:
                onTransportationChanged,
          ),

          const Divider(),

          SwitchListTile(
            value: negotiate,
            contentPadding: EdgeInsets.zero,
            activeColor: Colors.white,
            activeTrackColor:
                const Color(0xff006C3F),
            title: const Text(
              "Willing to negotiate",
            ),
            subtitle: const Text(
              "Clients can negotiate your price.",
            ),
            onChanged:
                onNegotiateChanged,
          ),
        ],
      ),
    );
  }
}