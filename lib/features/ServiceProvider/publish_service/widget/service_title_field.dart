import 'package:flutter/material.dart';

import 'publish_section_card.dart';

class ServiceTitleField extends StatelessWidget {
  const ServiceTitleField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PublishSectionCard(
      title: 'Service Title',
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Professional Plumbing & Leak Repair',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
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