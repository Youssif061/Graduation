import 'dart:io';

import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadSection extends StatelessWidget {
  const PhotoUploadSection({
    super.key,
    required this.selectedPhoto,
    required this.onUploadPressed,
    required this.onRemovePressed,
  });

  final XFile? selectedPhoto;
  final VoidCallback onUploadPressed;
  final VoidCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attach Photos',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.marketText,
          ),
        ),
        const SizedBox(height: 10),
        CustomPaint(
          painter: const _DashedBorderPainter(),
          child: InkWell(
            onTap: onUploadPressed,
            borderRadius: BorderRadius.circular(12),
            child: const SizedBox(
              width: double.infinity,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 33,
                    height: 30,
                    child: FittedBox(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Tap to upload a photo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.marketText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'PNG or JPG — maximum 10 MB',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.marketTextSub,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (selectedPhoto != null) ...[
          const SizedBox(height: 14),
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(selectedPhoto!.path),
                  width: 82,
                  height: 82,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -8,
                right: -8,
                child: InkWell(
                  onTap: onRemovePressed,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.navyColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.inputBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      );

    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 6), paint);

        distance += 11;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
