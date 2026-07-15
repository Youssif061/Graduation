import 'package:flutter/material.dart';

class ProblemPhotos extends StatelessWidget {
  const ProblemPhotos({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Problem Photos",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xff001A2C),
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 95,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  images[index],
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xffCBD5E1),
                        ),
                      ),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Color(0xff64748B),
                        size: 32,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}