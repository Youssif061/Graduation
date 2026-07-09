import 'package:flutter/material.dart';

class UploadImageCard extends StatelessWidget {
  const UploadImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Product Image",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 10),

        InkWell(
          onTap: () {
            // سيتم إضافة ImagePicker لاحقاً
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            height: 170,

            decoration: BoxDecoration(
              color: const Color(0xffEEF5FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xffCBD5E1),
                width: 1.5,
              ),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  size: 46,
                  color: Color(0xff64748B),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Upload Product Image",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Color(0xff001A2C),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "JPG, PNG or WEBP (Max 5MB)",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}