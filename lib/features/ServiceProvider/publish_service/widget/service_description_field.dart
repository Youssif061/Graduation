import 'package:flutter/material.dart';

import 'publish_section_card.dart';

class ServiceDescriptionField extends StatelessWidget {
  const ServiceDescriptionField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PublishSectionCard(
      title: 'Service Description',
      child: TextFormField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
          hintText:
              "Describe what's included in this service, your process, and any requirements...",
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
            height: 1.4,
          ),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF001A2C),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}