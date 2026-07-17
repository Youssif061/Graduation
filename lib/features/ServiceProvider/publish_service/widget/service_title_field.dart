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
      title: "Service Title",
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText:
              "Professional Plumbing & Leak Repair",

          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
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
            return "Service title is required";
          }

          if (value.trim().length < 5) {
            return "Title must be at least 5 characters";
          }

          return null;
        },
      ),
    );
  }
}