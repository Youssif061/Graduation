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
      title: "Service Description",
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: 6,
        minLines: 5,
        decoration: InputDecoration(
          hintText:
              "Describe what's included in this service, your process, experience, and any requirements the client should know before booking.",

          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
            height: 1.4,
          ),

          contentPadding:
              const EdgeInsets.all(16),

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
            return "Service description is required";
          }

          if (value.trim().length < 30) {
            return "Description must be at least 30 characters";
          }

          return null;
        },
      ),
    );
  }
}