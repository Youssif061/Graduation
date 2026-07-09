import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText:
                "Write a detailed description of the product...",

            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),

            filled: true,
            fillColor: Colors.white,

            contentPadding: const EdgeInsets.all(18),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xffCBD5E1),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xff001A2C),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}